local K = require("kompot:kompot")
local Parts = require("game:ui/menu_parts")
local E = require("game:ui/components")
local Portrait = require("game:ui/curator_portrait")
local Theme = require("game:ui/theme")
local paper, mint, muted = "#F5F0DF", "#A3EAD7", "#829C9F"

local function at(x, y, width, height, content)
    K.Box({ modifier = K.M:offset(x, y):size(width, height) }, content)
end

local Curator = K.component(function(p)
    local margin = math.max(32, math.floor(p.w * .0375))
    local left = math.min(530, math.floor((p.w - margin * 2 - 64) * .48))
    local rx = margin + left + 60
    local rw = p.w - rx - margin
    local mh = math.min(420, p.h - 230)
    local my = math.floor((p.h - mh) / 2) - 10
    local scroll = K.scroll_state()
    K.Box({ modifier = K.M:fill_max_size():background("#101F2A"):block_pointer() })
    at(p.w - 390, 60, 340, 44, function()
        K.Row({ spacing = 8 }, function()
            E.button("К ЗАДАНИЮ", p.on_skip, 160, "secondary", not p.assignment)
            E.button(p.sound == false and "ЗВУК: ВЫКЛ" or "ЗВУК: ВКЛ", p.on_sound, 160, "secondary")
        end)
    end)
    K.Box({ modifier = K.M:offset(margin + 4, my + 6):size(left, mh):background("#060F17", K.Shape.rounded(24)) })
    K.Box({ modifier = K.M:offset(margin, my):size(left, mh):background("#C8C9B9", K.Shape.rounded(24)) })
    local sh = mh - 48
    K.Box({ modifier = K.M:offset(margin + 16, my + 16):size(left - 32, mh - 32):background("#0D222A", K.Shape.rounded(14)) })
    at(margin + 24, my + 24, left - 48, sh, function()
        Portrait({ width = left - 48, height = sh, time = p.time, speaking = not p.ready })
    end)
    at(rx, my - 10, rw, 30, function()
        Parts.text("ДИСПЕТЧЕР / ИИ ЗАВОДА", "caption", mint)
    end)
    at(rx, my + 23, rw, 55, function()
        Parts.text(p.title, "heading", paper)
    end)
    K.Box({ modifier = K.M:offset(rx, my + 90):size(rw, 1):background("#476164") })
    at(rx, my + 117, rw, math.max(40, p.h - 225 - my - 117), function()
        K.Column({ modifier = K.M:fill_max_size():vertical_scroll(scroll) }, function()
            Parts.text(p.text, "title", paper)
        end)
    end)
    at(rx, p.h - 170, rw, 120, function()
        K.Column({ spacing = 10 }, function()
            for i, choice in ipairs(p.choices) do
                local index = i
                E.button(choice.label, function()
                    p.on_choose(index)
                end, nil, i == 1 and "yellow" or "secondary", p.ready)
            end
        end)
    end)
    if not p.ready then
        at(rx, my + 117, rw, math.max(40, p.h - 225 - my - 117), function()
            K.Box({ modifier = K.M:fill_max_size():clickable(p.on_reveal) })
        end)
    end
    at(margin, p.h - 39, p.w - margin * 2, 20, function()
        Parts.text(p.ready and (p.assignment and "Enter / Пробел - к работе · Esc - закрыть разговор" or "1 / 2 - ответить · Esc - закрыть разговор") or "Пробел / клик по тексту - показать целиком", "caption", muted)
    end)
end)
K.preview("Разговор с диспетчером", { width = 1280, height = 760, padding = 0, theme = Theme.theme, group = "Экраны" }, function()
    Curator({ w = 1280, h = 760, title = "Человек на связи", text = "А, ты пришёл. Я диспетчер, ИИ этого завода. Все линии работают по моим схемам. По отчётам всё отлично, а склад пустой. Нужно посмотреть, что там на самом деле.", step = 1, total = 5, ready = true, time = 1,
              choices = { { label = "Твои схемы точно работают?" }, { label = "Почему я?" } }, on_choose = function()
        end })
end)
return Curator
