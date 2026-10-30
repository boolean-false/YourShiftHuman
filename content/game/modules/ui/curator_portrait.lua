local K = require("kompot:kompot")
local Theme = require("game:ui/theme")
local Portrait = K.component(function(p)
    local t = p.time or 0
    K.Canvas({ width = p.width, height = p.height, version = math.floor(t * 24), draw = function(cv, w, h)
        local scale = math.min(w / 480, h / 290)
        local ox, oy = (w - 480 * scale) / 2, (h - 290 * scale) / 2
        local function rect(x, y, rw, rh, r, g, b)
            cv:rect(math.floor(ox + x * scale), math.floor(oy + y * scale), math.max(1, math.floor(rw * scale)), math.max(1, math.floor(rh * scale)), r, g, b, 255)
        end
        local function rounded(x, y, rw, rh, radius, r, g, b)
            radius = math.min(radius, rw / 2, rh / 2)
            for row = 0, math.ceil(rh) - 1 do
                local dy = math.max(0, radius - (row + .5), row + .5 - (rh - radius))
                local inset = radius - math.sqrt(math.max(0, radius * radius - dy * dy))
                rect(x + inset, y + row, rw - inset * 2, 1, r, g, b)
            end
        end
        cv:rect(0, 0, w, h, 13, 34, 42, 255)
        local blink = t % 5.3
        local lid = blink < .18 and math.max(.08, math.abs(blink - .09) / .09) or 1
        local look = math.sin(t * .6) * 3
        for _, x in ipairs({ 166, 314 }) do
            local eh = 62 * lid
            local y = 124 - eh / 2
            rounded(x - 30 + look, y - 5, 60, eh + 10, 15, 22, 60, 63)
            rounded(x - 24 + look, y, 48, eh, 12, 163, 234, 215)
        end
        for i = 0, 18 do
            local height = p.speaking and 3 + math.abs(math.sin(t * 13 + i * .72)) * 19 or 3
            rect(174 + i * 7, 208 - height / 2, 4, height, 118, 205, 181)
        end
    end })
end)
K.preview("Терминал куратора", { width = 520, height = 330, theme = Theme.theme, group = "Элементы" }, function()
    Portrait({ width = 480, height = 290, time = 1, speaking = true })
end)
return Portrait
