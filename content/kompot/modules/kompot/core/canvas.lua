-- Общая растеризация изображений
-- Наклонные преобразования: покрытие 4x4 и усреднение premultiplied RGBA.
local A = require "kompot:kompot/core/affine"
local C = {}
local floor, min, max = math.floor, math.min, math.max
local immutable = setmetatable({}, {
    __mode = "k",
})
local source_buffers = setmetatable({}, {
    __mode = "k",
})
local UNIFORM_SOURCE_LIMIT = 4
local UNIFORM_PIXEL_LIMIT = 512 * 512
local UNIFORM_FOOTPRINT_LIMIT = 16
local uniform_cache = {}
-- Ограничиваем память кеша неизменяемых источников.
local function uniform_rows(source, data, w, h)
    for i, cached in ipairs(uniform_cache) do
        if cached.source == source then
            table.remove(uniform_cache, i)
            uniform_cache[#uniform_cache + 1] = cached
            return cached.rows
        end
    end
    local rows, equal = {}, 0
    for y = 0, h - 1 do
        local last = w - 1
        for x = w - 1, 0, -1 do
            local p = y * w + x
            local i = p * 4
            if
                x == w - 1
                or data[i] ~= data[i + 4]
                or data[i + 1] ~= data[i + 5]
                or data[i + 2] ~= data[i + 6]
                or data[i + 3] ~= data[i + 7]
            then
                last = x
            else
                equal = equal + 1
            end
            rows[p + 1] = last
        end
    end
    if #uniform_cache == UNIFORM_SOURCE_LIMIT then
        table.remove(uniform_cache, 1)
    end
    -- Шумные текстуры не окупают индекс и используют прежнюю выборку.
    if equal < w * h * 0.5 then
        rows = nil
    end
    uniform_cache[#uniform_cache + 1] = {
        source = source,
        rows = rows,
    }
    return rows
end
local function uniform_region(data, rows, width, ax, ay, bx, by)
    local p = ay * width + ax
    if rows[p + 1] < bx then
        return nil
    end
    local i = p * 4
    local r, g, b, a = data[i], data[i + 1], data[i + 2], data[i + 3]
    for y = ay + 1, by do
        p = y * width + ax
        i = p * 4
        if
            rows[p + 1] < bx
            or data[i] ~= r
            or data[i + 1] ~= g
            or data[i + 2] ~= b
            or data[i + 3] ~= a
        then
            return nil
        end
    end
    return r + g * 256 + b * 65536 + a * 16777216
end
local function source_data(source)
    local buffer = source_buffers[source]
    if not buffer and source.get_data then
        buffer = source:get_data()
        if buffer and immutable[source] then
            source_buffers[source] = buffer
        end
    end
    return buffer
end
local function unpack_pixel(p)
    return p % 256, floor(p / 256) % 256, floor(p / 65536) % 256, floor(p / 16777216) % 256
end
-- Осевой путь читает готовые RGBA-каналы без промежуточной упаковки пикселя.
local function draw_axis(ctx)
    for y = ctx.bottom, ctx.top do
        local row = ctx.rows[y]
        for x = ctx.left, ctx.right do
            local col = ctx.columns[x]
            if col and row then
                local r, g, b, a
                if ctx.source_bytes then
                    local i = (row * ctx.iw + col) * 4
                    r, g, b, a =
                        ctx.source_bytes[i],
                        ctx.source_bytes[i + 1],
                        ctx.source_bytes[i + 2],
                        ctx.source_bytes[i + 3]
                else
                    r, g, b, a = unpack_pixel(ctx.source:at(col, row) or 0)
                end
                local sa = a / 255 * ctx.alpha
                if sa > 0 then
                    if sa == 1 then
                        if not ctx.unchanged_color then
                            r, g, b =
                                floor(r * ctx.tr + 0.5),
                                floor(g * ctx.tg + 0.5),
                                floor(b * ctx.tb + 0.5)
                        end
                        a = 255
                    else
                        local dr, dg, db, da
                        if ctx.target_bytes then
                            local i = (y * ctx.dw + x) * 4
                            dr, dg, db, da =
                                ctx.target_bytes[i],
                                ctx.target_bytes[i + 1],
                                ctx.target_bytes[i + 2],
                                ctx.target_bytes[i + 3]
                        else
                            dr, dg, db, da = unpack_pixel(ctx.dst:at(x, y) or 0)
                        end
                        local oa = sa + da / 255 * (1 - sa)
                        local weight = da / 255 * (1 - sa)
                        r, g, b, a =
                            floor((r * ctx.tr * sa + dr * weight) / oa + 0.5),
                            floor((g * ctx.tg * sa + dg * weight) / oa + 0.5),
                            floor((b * ctx.tb * sa + db * weight) / oa + 0.5),
                            floor(oa * 255 + 0.5)
                    end
                    if ctx.target_bytes then
                        local i = (y * ctx.dw + x) * 4
                        ctx.target_bytes[i], ctx.target_bytes[i + 1], ctx.target_bytes[i + 2], ctx.target_bytes[i + 3] =
                            r, g, b, a
                    else
                        ctx.dst:set(x, y, r, g, b, a)
                    end
                end
            end
        end
    end
end
local function finish_buffers(dst, source_buffer, target_buffer, iw, ih)
    if source_buffer then
        assert(source_buffer.size == iw * ih * 4, "source RGBA size mismatch")
    end
    if target_buffer then
        dst:set_data(target_buffer)
    end
end
-- Окрашивание готовой геометрии не затрагивает выборку и сглаживание.
function C.tint_buffer(dst, w, h, source_buffer, tint)
    tint = tint or { 1, 1, 1, 1 }
    local tr, tg, tb = min(1, max(0, tint[1])), min(1, max(0, tint[2])), min(1, max(0, tint[3]))
    local rows, columns = {}, {}
    for x = 0, w - 1 do
        columns[x] = x
    end
    for y = 0, h - 1 do
        rows[y] = y
    end
    local target_buffer = dst:get_data()
    draw_axis({
        source_bytes = source_buffer.bytes,
        target_bytes = target_buffer.bytes,
        iw = w,
        dw = w,
        left = 0,
        right = w - 1,
        bottom = 0,
        top = h - 1,
        rows = rows,
        columns = columns,
        tr = tr,
        tg = tg,
        tb = tb,
        alpha = min(1, max(0, tint[4] or 1)),
        unchanged_color = tr == 1 and tg == 1 and tb == 1,
    })
    finish_buffers(dst, source_buffer, target_buffer, w, h)
end
function C.composite(dst, dw, dh, source, sw, sh, matrix, opts, top_down)
    opts = opts or {}
    local inv = A.inverse(matrix)
    if not inv then
        return
    end
    local x0, y0, x1, y1 = A.bounds(matrix, 0, 0, sw, sh)
    local uv = opts.region or { 0, 0, 1, 1 }
    local tint = opts.color or { 1, 1, 1, 1 }
    local tr, tg, tb = min(1, max(0, tint[1])), min(1, max(0, tint[2])), min(1, max(0, tint[3]))
    local alpha = (opts.alpha or 1) * min(1, max(0, tint[4] or 1))

    -- Размеры Canvas - свойства C API; читаем их один раз за рисунок.
    local iw, ih = source.width, source.height
    local unchanged_color = tr == 1 and tg == 1 and tb == 1
    -- Осевая геометрия (включая четверть оборота) сохраняет точные пиксели.
    local eps = 1e-9
    local tilted = not (
        (math.abs(matrix[2]) < eps and math.abs(matrix[3]) < eps)
        or (math.abs(matrix[1]) < eps and math.abs(matrix[4]) < eps)
    )
    -- В движке читаем/записываем RGBA одним буфером за проход: вызов C API
    -- Canvas:at на каждую подвыборку слишком дорог. SoftCanvas работает
    -- через тот же алгоритм без зависимости от FFI.
    local source_buffer = source ~= dst and (opts.source_buffer or source_data(source))
    local target_buffer = source ~= dst and dst.get_data and dst:get_data()
    if source_buffer and source_buffer.size ~= iw * ih * 4 then
        source_buffer = nil
    end
    if target_buffer and target_buffer.size ~= dw * dh * 4 then
        target_buffer = nil
    end
    local source_bytes = source_buffer and source_buffer.bytes
    local target_bytes = target_buffer and target_buffer.bytes
    if matrix[2] == 0 and matrix[3] == 0 then
        local ctx = {
            source = source,
            dst = dst,
            iw = iw,
            dw = dw,
            source_bytes = source_bytes,
            target_bytes = target_bytes,
            tr = tr,
            tg = tg,
            tb = tb,
            alpha = alpha,
            unchanged_color = unchanged_color,
            left = max(0, floor(x0)),
            right = min(dw - 1, math.ceil(x1) - 1),
            bottom = max(0, floor(y0)),
            top = min(dh - 1, math.ceil(y1) - 1),
            columns = {},
            rows = {},
        }
        for x = ctx.left, ctx.right do
            local sx = inv[1] * (x + 0.5) + inv[5]
            if sx >= 0 and sx < sw then
                local u = uv[1] + sx / sw * (uv[3] - uv[1])
                ctx.columns[x] = min(iw - 1, max(0, floor(u * iw + 1e-9)))
            end
        end
        for y = ctx.bottom, ctx.top do
            local sy = inv[4] * (y + 0.5) + inv[6]
            if sy >= 0 and sy < sh then
                local v = uv[4] + sy / sh * (uv[2] - uv[4])
                local row = min(ih - 1, max(0, floor((1 - v) * ih + 1e-9)))
                ctx.rows[y] = top_down and row or ih - 1 - row
            end
        end
        draw_axis(ctx)
        finish_buffers(dst, source_buffer, target_buffer, iw, ih)
        return
    end
    local function read_source(x, y)
        if source_bytes then
            local i = (y * iw + x) * 4
            return source_bytes[i]
                + source_bytes[i + 1] * 256
                + source_bytes[i + 2] * 65536
                + source_bytes[i + 3] * 16777216
        end
        return source:at(x, y) or 0
    end
    local function read_target(x, y)
        if target_bytes then
            local i = (y * dw + x) * 4
            return target_bytes[i]
                + target_bytes[i + 1] * 256
                + target_bytes[i + 2] * 65536
                + target_bytes[i + 3] * 16777216
        end
        return dst:at(x, y) or 0
    end
    local function write_target(x, y, r, g, b, a)
        if target_bytes then
            if g == nil then
                r, g, b, a = unpack_pixel(r)
            end
            local i = (y * dw + x) * 4
            target_bytes[i], target_bytes[i + 1], target_bytes[i + 2], target_bytes[i + 3] =
                r, g, b, a
        else
            if g == nil then
                dst:set(x, y, r)
            else
                dst:set(x, y, r, g, b, a)
            end
        end
    end
    local hx = (math.abs(inv[1]) + math.abs(inv[3])) * 0.5
    local hy = (math.abs(inv[2]) + math.abs(inv[4])) * 0.5
    local rows
    local footprint =
        max(hx * 2 * math.abs(uv[3] - uv[1]) * iw / sw, hy * 2 * math.abs(uv[2] - uv[4]) * ih / sh)
    if
        tilted
        and immutable[source]
        and source_bytes
        and iw * ih <= UNIFORM_PIXEL_LIMIT
        and footprint > 1
        and footprint < UNIFORM_FOOTPRINT_LIMIT
    then
        rows = uniform_rows(source, source_bytes, iw, ih)
    end
    -- Сетка сглаживания одинакова для всех пикселей этого преобразования.
    local dx_x, dx_y, dy_x, dy_y = {}, {}, {}, {}
    if tilted then
        for i = 0, 3 do
            local offset = (i + 0.5) / 4 - 0.5
            dx_x[i], dx_y[i] = inv[1] * offset, inv[2] * offset
            dy_x[i], dy_y[i] = inv[3] * offset, inv[4] * offset
        end
    end
    local function texel(sx, sy)
        local u = uv[1] + sx / sw * (uv[3] - uv[1])
        local v = uv[4] + sy / sh * (uv[2] - uv[4])
        local tx = min(iw - 1, max(0, floor(u * iw + 1e-9)))
        local ty = min(ih - 1, max(0, floor((1 - v) * ih + 1e-9)))
        if not top_down then
            ty = ih - 1 - ty
        end
        return tx, ty
    end
    local function sample(sx, sy)
        if sx < 0 or sy < 0 or sx >= sw or sy >= sh then
            return 0
        end
        local tx, ty = texel(sx, sy)
        return read_source(tx, ty)
    end
    local function coverage(sx, sy)
        if sx + hx <= 0 or sy + hy <= 0 or sx - hx >= sw or sy - hy >= sh then
            return 0
        end
        if sx - hx >= 0 and sy - hy >= 0 and sx + hx <= sw and sy + hy <= sh then
            return 1
        end
        -- Точное пересечение пикселя с прямоугольником слоя. Оно даёт плавный
        -- край даже при очень малом угле, когда сетка выборок ещё его не видит.
        local dx, dy, ex, ey = inv[1] * 0.5, inv[2] * 0.5, inv[3] * 0.5, inv[4] * 0.5
        local poly = {
            sx - dx - ex,
            sy - dy - ey,
            sx + dx - ex,
            sy + dy - ey,
            sx + dx + ex,
            sy + dy + ey,
            sx - dx + ex,
            sy - dy + ey,
        }
        for edge = 1, 4 do
            local axis = edge <= 2 and 1 or 2
            local bound = (edge == 2 and sw) or (edge == 4 and sh) or 0
            local sign = edge % 2 == 1 and 1 or -1
            local out = {}
            local px, py = poly[#poly - 1], poly[#poly]
            local pd = ((axis == 1 and px or py) - bound) * sign
            for i = 1, #poly, 2 do
                local x, y = poly[i], poly[i + 1]
                local d = ((axis == 1 and x or y) - bound) * sign
                if (d >= 0) ~= (pd >= 0) then
                    local t = pd / (pd - d)
                    out[#out + 1] = px + (x - px) * t
                    out[#out + 1] = py + (y - py) * t
                end
                if d >= 0 then
                    out[#out + 1] = x
                    out[#out + 1] = y
                end
                px, py, pd = x, y, d
            end
            if #out < 6 then
                return 0
            end
            poly = out
        end
        local area = 0
        local px, py = poly[#poly - 1] - sx, poly[#poly] - sy
        for i = 1, #poly, 2 do
            local x, y = poly[i] - sx, poly[i + 1] - sy
            area = area + px * y - py * x
            px, py = x, y
        end
        return min(1, math.abs(area / (inv[1] * inv[4] - inv[2] * inv[3])) * 0.5)
    end
    local function filtered(sx, sy)
        local cover = coverage(sx, sy)
        if cover == 0 then
            return 0
        end
        -- Проверяем все texel footprint, а не только углы: иначе можно
        -- потерять тонкую деталь в середине. Одноцветные области обходятся
        -- без шестнадцати выборок, включая сглаженный внешний край.
        local ax, ay = texel(max(0, sx - hx), max(0, sy - hy))
        local bx, by = texel(min(sw, sx + hx), min(sh, sy + hy))
        ax, bx = min(ax, bx), max(ax, bx)
        ay, by = min(ay, by), max(ay, by)
        if rows and bx - ax <= UNIFORM_FOOTPRINT_LIMIT and by - ay <= UNIFORM_FOOTPRINT_LIMIT then
            local first = uniform_region(source_bytes, rows, iw, ax, ay, bx, by)
            if first ~= nil then
                local a = floor(first / 16777216) % 256
                return first % 16777216 + floor(a * cover + 0.5) * 16777216
            end
        end
        if bx - ax <= 2 and by - ay <= 2 then
            local first = read_source(ax, ay)
            local same = true
            for y = ay, by do
                for x = ax, bx do
                    if read_source(x, y) ~= first then
                        same = false
                        break
                    end
                end
                if not same then
                    break
                end
            end
            if same then
                local a = floor(first / 16777216) % 256
                return first % 16777216 + floor(a * cover + 0.5) * 16777216
            end
        end
        local rr, gg, bb, aa, n = 0, 0, 0, 0, 0
        for j = 0, 3 do
            for i = 0, 3 do
                local x, y = sx + dx_x[i] + dy_x[j], sy + dx_y[i] + dy_y[j]
                if x >= 0 and y >= 0 and x < sw and y < sh then
                    local tx, ty = texel(x, y)
                    local r, g, b, a
                    if source_bytes then
                        local index = (ty * iw + tx) * 4
                        r, g, b, a =
                            source_bytes[index],
                            source_bytes[index + 1],
                            source_bytes[index + 2],
                            source_bytes[index + 3]
                    else
                        r, g, b, a = unpack_pixel(read_source(tx, ty))
                    end
                    rr, gg, bb, aa, n = rr + r * a, gg + g * a, bb + b * a, aa + a, n + 1
                end
            end
        end
        if n == 0 then
            local r, g, b, a =
                unpack_pixel(sample(min(sw - 1e-9, max(0, sx)), min(sh - 1e-9, max(0, sy))))
            rr, gg, bb, aa, n = r * a, g * a, b * a, a, 1
        end
        if aa == 0 then
            return 0
        end
        -- RGB полностью прозрачных texel не влияет на цвет края.
        return floor(rr / aa + 0.5)
            + floor(gg / aa + 0.5) * 256
            + floor(bb / aa + 0.5) * 65536
            + floor(aa / n * cover + 0.5) * 16777216
    end
    for y = max(0, floor(y0)), min(dh - 1, math.ceil(y1) - 1) do
        for x = max(0, floor(x0)), min(dw - 1, math.ceil(x1) - 1) do
            local sx, sy = A.point(inv, x + 0.5, y + 0.5)
            -- Даже если центр снаружи, часть пикселя может покрываться слоем.
            local pixel = tilted and filtered(sx, sy) or sample(sx, sy)
            local sa = floor(pixel / 16777216) % 256 / 255 * alpha
            if sa == 1 and unchanged_color then
                write_target(x, y, pixel)
            elseif sa > 0 then
                local r, g, b = unpack_pixel(pixel)
                if sa == 1 then
                    write_target(
                        x,
                        y,
                        floor(r * tr + 0.5),
                        floor(g * tg + 0.5),
                        floor(b * tb + 0.5),
                        255
                    )
                else
                    local dr, dg, db, da = unpack_pixel(read_target(x, y))
                    local oa = sa + da / 255 * (1 - sa)
                    local weight = da / 255 * (1 - sa)
                    write_target(
                        x,
                        y,
                        floor((r * tr * sa + dr * weight) / oa + 0.5),
                        floor((g * tg * sa + dg * weight) / oa + 0.5),
                        floor((b * tb * sa + db * weight) / oa + 0.5),
                        floor(oa * 255 + 0.5)
                    )
                end
            end
        end
    end
    -- Bytearray владеет памятью bytes; удерживаем владельцев до конца прохода.
    finish_buffers(dst, source_buffer, target_buffer, iw, ih)
end
local function finite(v, name)
    assert(type(v) == "number" and v == v and math.abs(v) < math.huge, name .. " must be finite")
end
function C.validate(opts)
    opts = opts or {}
    for _, k in ipairs({ "x", "y", "width", "height", "angle", "alpha" }) do
        if opts[k] ~= nil then
            finite(opts[k], "canvas image " .. k)
        end
    end
    if opts.alpha ~= nil then
        assert(opts.alpha >= 0 and opts.alpha <= 1, "canvas image alpha must be 0..1")
    end
    for _, k in ipairs({ "width", "height" }) do
        if opts[k] then
            assert(opts[k] > 0, "canvas image dimensions must be positive")
        end
    end
    local pivot = opts.pivot or { 0.5, 0.5 }
    finite(pivot.x or pivot[1], "pivot x")
    finite(pivot.y or pivot[2], "pivot y")
    local scale = opts.scale or 1
    if type(scale) == "table" then
        finite(scale.x or scale[1], "scale x")
        finite(scale.y or scale[2], "scale y")
    else
        finite(scale, "scale")
    end
    if opts.region then
        for i = 1, 4 do
            finite(opts.region[i], "image region")
        end
    end
end
function C.image_matrix(opts, w, h)
    opts = opts or {}
    local pivot = opts.pivot or { 0.5, 0.5 }
    local px, py = (pivot.x or pivot[1]) * w, (pivot.y or pivot[2]) * h
    local scale = opts.scale or 1
    local sx, sy = scale, scale
    if type(scale) == "table" then
        sx, sy = scale.x or scale[1], scale.y or scale[2]
    end
    local rad = math.rad(opts.angle or 0)
    local m = A.around(
        math.cos(rad) * sx,
        math.sin(rad) * sx,
        -math.sin(rad) * sy,
        math.cos(rad) * sy,
        px,
        py
    )
    m[5], m[6] = m[5] + (opts.x or 0), m[6] + (opts.y or 0)
    return m
end
function C.wrap(canvas, w, h, loader)
    local wrapper = {
        width = w,
        height = h,
        raw = canvas,
    }
    for _, name in ipairs({
        "set",
        "at",
        "line",
        "rect",
        "clear",
        "blit",
        "update",
        "create_texture",
        "get_data",
        "set_data",
    }) do
        wrapper[name] = function(_, ...)
            return canvas[name](canvas, ...)
        end
    end
    function wrapper:image(src, opts)
        opts = opts or {}
        C.validate(opts)
        local image, top = loader(src)
        assert(image, "canvas image not loaded: " .. tostring(src))
        local iw, ih = opts.width or image.width, opts.height or image.height
        assert(iw > 0 and ih > 0, "canvas image dimensions must be positive")
        local o = {
            alpha = opts.alpha,
            region = opts.region,
            color = require("kompot:kompot/core/color").of(opts.color),
        }
        C.composite(canvas, w, h, image, iw, ih, C.image_matrix(opts, iw, ih), o, top)
    end
    return wrapper
end
function C.engine_loader(src)
    if type(src) == "table" and src.kind == "raster" then
        C.rasters = C.rasters or setmetatable({}, {
            __mode = "k",
        })
        local old = C.rasters[src]
        if old and old.version == src.version then
            return old.canvas, true
        end
        local cv = Canvas({ src.width, src.height })
        cv:clear()
        src.draw(C.wrap(cv, src.width, src.height, C.engine_loader), src.width, src.height)
        C.rasters[src] = {
            canvas = cv,
            version = src.version,
        }
        immutable[cv] = true
        return cv, true
    end
    if type(src) ~= "string" then
        return src, true
    end
    C.sources = C.sources or {}
    if not C.sources[src] then
        C.sources[src] = assets.to_canvas(src)
        if C.sources[src] then
            immutable[C.sources[src]] = true
        end
    end
    return C.sources[src], false
end
function C.reset()
    uniform_cache = {}
    C.sources = {}
    C.rasters = nil
    immutable = setmetatable({}, {
        __mode = "k",
    })
    source_buffers = setmetatable({}, {
        __mode = "k",
    })
end
return C
