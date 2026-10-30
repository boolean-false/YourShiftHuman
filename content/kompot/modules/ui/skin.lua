-- Поверхности: заливка, текстуры и состояния.
local K = require "kompot:kompot"
local T = require "kompot:ui/tokens"
local S = {}
local function byte(v)
    return math.max(0, math.min(255, math.floor(v + 0.5)))
end
local MIDTONE = {
    panel = 140,
    button = 200,
    button_pressed = 140,
    inset = 140,
}
-- Размеры штатных PNG. У панелей и углублений большая
-- середина: маленький тайл на больших окнах читается как сетка. Для своих
-- без указания source_size по дефолту ожидается 72x72
local SOURCE_SIZE = {
    ["kompot_ui_skin:panel"] = { 264, 264 },
    ["kompot_ui_skin:inset"] = { 264, 264 },
    ["kompot_ui_skin:button"] = { 72, 72 },
    ["kompot_ui_skin:button_pressed"] = { 72, 72 },
}

local extend = T.extend_surface
local states = { "selected", "hovered", "focused", "pressed", "dragged", "error", "disabled" }
local properties = {
    "skin",
    "color",
    "content_color",
    "shape",
    "border_width",
    "border_color",
    "text_style",
    "press_offset",
    "focus_color",
    "draw",
}
local function apply_style(out, patch)
    for _, key in ipairs(properties) do
        if patch[key] ~= nil then
            out[key] = patch[key]
        end
    end
end
local shape_roles = {
    button = "control",
    inset = "field",
}
local function snapshot(value)
    local c = K.color.of(value)
    return c and { c[1], c[2], c[3], c[4] or 1 } or nil
end

-- Поведение передаёт снимок состояния; оформление не получает обработчиков ввода.
function S.resolve(p)
    local theme = T.current()
    local surfaces = theme.surfaces or {}
    local role = p.role or p.kind or "panel"
    local style = extend(surfaces.default or {}, surfaces[role] or {})
    if p.variant and style.variants then
        style = extend(style, style.variants[p.variant] or {})
    end
    style = extend(style, p.surface or {})
    local out = {}
    for k, v in pairs(p) do
        out[k] = v
    end
    out.role = role
    out.enabled = p.enabled ~= false
    out.disabled = not out.enabled
    out.shape = p.shape
        or theme.shapes[role]
        or theme.shapes[shape_roles[p.kind] or p.kind or "panel"]
        or 0
    if out.border_width == nil then
        out.border_width = p.selected and p.edge and 2 or 0
    end
    out.border_color = p.border_color or p.edge
    -- Настройки рисунка не подменяют снимок состояния компонента.
    apply_style(out, style)
    for _, state in ipairs(states) do
        if out[state] and style.states then
            apply_style(out, style.states[state] or {})
        end
    end
    if p.shape_override ~= nil then
        out.shape = p.shape_override
    end
    out.color = out.color == false and { 0, 0, 0, 0 } or snapshot(out.color)
    out.content_color = snapshot(out.content_color)
    out.border_color = snapshot(out.border_color)
    assert(
        type(out.border_width) == "number" and out.border_width >= 0,
        "surface border_width must be nonnegative"
    )
    out.resolved = true
    return out
end

local function draw_surface(p)
    local theme = T.current()
    local kind = p.kind or "panel"
    local c = theme.colors
    local base = p.color or (kind == "inset" and c.sunken or c.panel_bg)
    local state = kind == "button" and p.pressed and "button_pressed" or kind
    local choice = p.skin
    if choice == nil then
        choice = assert(theme.skin[state], "unknown Kompot UI skin: " .. tostring(state))
    end
    local m = p.modifier or K.M:match_parent_size()
    local alpha = base[4] or 1
    if choice == false then
        if alpha > 0 then
            m = m:background(base, p.shape)
        end
    elseif alpha > 0 then
        local opts = type(choice) == "table" and choice or {
            src = choice,
        }
        local paint = opts.kind == "nine_patch" and opts
            or K.nine_patch(opts.src, {
                source_size = opts.source_size or SOURCE_SIZE[opts.src] or { 72, 72 },
                border = opts.border or { 4, (kind == "inset" or p.pressed) and 6 or 4, 4, 4 },
                center = opts.center or "tile",
                edges = opts.edges or "tile",
                scale = opts.scale,
            })
        local mid = opts.midtone or MIDTONE[state] or 255
        assert(mid > 0, "surface midtone must be positive")
        local tint = opts.tint == false and { 1, 1, 1, alpha }
            or {
                math.min(1, byte(base[1] * 255) / mid),
                math.min(1, byte(base[2] * 255) / mid),
                math.min(1, byte(base[3] * 255) / mid),
                alpha,
            }
        -- Маска принадлежит только фону: соседние нативные поля не обрезаются ей.
        if p.shape ~= 0 then
            m = m:clip(p.shape)
        end
        K.Box({
            modifier = m:background_image(paint, tint),
        })
        m = p.modifier or K.M:match_parent_size()
    end
    if p.border_width > 0 and p.border_color then
        m = m:border(p.border_width, p.border_color, p.shape)
    end
    K.Box({
        modifier = m,
    })
end

S.Surface = K.component(function(p)
    p = p or {}
    local resolved = p.resolved and p or S.resolve(p)
    -- Один корень сохраняет пути соседних полей при смене рисунка.
    K.Box({
        modifier = resolved.modifier or K.M:match_parent_size(),
    }, function()
        local drawing = {}
        for k, v in pairs(resolved) do
            drawing[k] = v
        end
        drawing.modifier = K.M:match_parent_size()
        K.key(resolved.draw or "builtin", function()
            if resolved.draw then
                resolved.draw(drawing)
            else
                draw_surface(drawing)
            end
        end)
    end)
end)

-- Значки рисуем в той же пиксельной сетке, что и поверхности.
local glyphs = {
    health = { " ## ## ", "#######", "#######", " ##### ", "  ###  ", "   #   " },
    energy = { "   ##  ", "  ##   ", " ##### ", "   ##  ", "  ##   ", " ##    " },
    experience = { "   #   ", "  ###  ", " ## ## ", "##   ##", " ## ## ", "  ###  ", "   #   " },
}
function S.Icon(name, size, tint)
    local glyph = glyphs[name]
    if not glyph then
        local atlas = K.theme().icons or T.current().icons
        local src = name:find(":", 1, true) and name or atlas .. ":" .. name
        K.Icon(src, {
            size = size,
            color = tint,
        })
        return
    end
    local c = K.color.of(tint) or T.current().colors.text
    K.Canvas({
        width = size,
        height = size,
        version = name .. table.concat(c, ","),
        draw = function(cv, w, h)
            local scale = math.max(1, math.floor(math.min(w / #glyph[1], h / #glyph)))
            local ox, oy =
                math.floor((w - #glyph[1] * scale) / 2), math.floor((h - #glyph * scale) / 2)
            for y, row in ipairs(glyph) do
                for x = 1, #row do
                    if row:sub(x, x) == "#" then
                        cv:rect(
                            ox + (x - 1) * scale,
                            oy + (y - 1) * scale,
                            scale,
                            scale,
                            byte(c[1] * 255),
                            byte(c[2] * 255),
                            byte(c[3] * 255),
                            byte((c[4] or 1) * 255)
                        )
                    end
                end
            end
        end,
    })
end
return S
