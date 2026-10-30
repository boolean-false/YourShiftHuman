-- Диагностика не зависит от композиции, которая могла завершиться ошибкой.
local E = {}
local min, max, floor = math.min, math.max, math.floor

function E.append(dl, regions, message, width, height)
    if not message then
        return
    end
    local lines = 1
    for _ in message:gmatch("\n") do
        lines = lines + 1
    end
    local margin = min(8, max(0, floor(min(width, height) / 4)))
    local x, y = margin, margin
    local w = max(1, width - margin * 2)
    local h = min(max(1, height - margin * 2), max(120, min(360, lines * 16 + 32)))
    local inset = min(8, floor(w / 4))
    local header = h >= 80 and 24 or 0
    local field_x, field_y = x + inset, y + header
    local field_w, field_h = max(1, w - inset * 2), max(1, h - header - inset)
    dl[#dl + 1] = {
        key = "__error_bg",
        kind = "rect",
        clip = "",
        x = x,
        y = y,
        w = w,
        h = h,
        color = { 0.35, 0.035, 0.055, 0.98 },
        radius = 8,
    }
    dl[#dl + 1] = {
        key = "__error_input",
        kind = "input",
        clip = "",
        x = x,
        y = y,
        w = w,
        h = h,
    }
    regions[#regions + 1] = {
        key = "__error_panel",
        x = x,
        y = y,
        w = w,
        h = h,
        block = true,
    }
    if header > 0 then
        dl[#dl + 1] = {
            key = "__error_title",
            kind = "text",
            clip = "",
            x = x + inset,
            y = y + 6,
            w = field_w,
            h = 16,
            text = "Ошибка Kompot",
            font = "kompot_12",
            color = { 1, 1, 1, 1 },
        }
    end
    dl[#dl + 1] = {
        key = "__error_text",
        input_key = "__error_field",
        kind = "field",
        clip = "",
        x = field_x,
        y = field_y,
        w = field_w,
        h = field_h,
        text = message,
        font = "kompot_12",
        color = { 1, 1, 1, 1 },
        -- Отступ задан снаружи: нативная прокрутка не учитывает padding снизу.
        pad = 0,
        multiline = true,
        editable = false,
        wrap = true,
        line_height = 16,
    }
    regions[#regions + 1] = {
        key = "__error_field",
        x = field_x,
        y = field_y,
        w = field_w,
        h = field_h,
        focus = {
            enabled = true,
        },
        block = true,
        cursor = "ibeam",
    }
end

return E
