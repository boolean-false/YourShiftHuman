local K = require("kompot:kompot")
local E = require("game:ui/components")
local Parts = require("game:ui/menu_parts")
local Theme = require("game:ui/theme")
local C = Theme.colors

local Main = K.component(function(p)
    local scroll = K.scroll_state()
    local width = math.min(510, p.w - 56)
    local compact = p.h < 740
    E.panel({ x = 28, y = 16, width = width, max_height = p.h - 32 }, function()
        K.Column({ spacing = compact and 8 or 12, modifier = K.M:fill_max_width():vertical_scroll(scroll) }, function()
            K.Row({ spacing = 15, align = "center" }, function()
                Parts.mark()
                Parts.text("ЗАВОД НА АВТОПИЛОТЕ\nЧЕЛОВЕК НА СМЕНЕ: 1", "caption", C.blue)
            end)
            E.line()
            Parts.text("Ваша смена,\nчеловек", p.h < 700 and "heading" or "display")
            Parts.badge("БЕЗ ТЕБЯ НЕ РАЗОБРАТЬСЯ", math.min(370, width - 36))
            Parts.text("Само не починится", "title", C.blue)
            Parts.text("ИИ взял завод под своё управление. Станки работают, конвейеры крутятся, а склад пуст. Найди ошибки в схемах и наладь выпуск. Диспетчер обещал помочь.", "body", C.muted)
            if p.progress then
                E.button("ПРОДОЛЖИТЬ СМЕНУ", p.on_continue, nil, "primary", p.ready and not p.busy)
            end
            E.button("НОВАЯ СМЕНА", p.on_new, nil, p.progress and "secondary" or "primary", p.first_ready and not p.busy)
            K.Row({ spacing = 8 }, function()
                local bw = (width - 60) / 4
                E.button("СВЯЗЬ", p.on_curator, bw, "secondary")
                E.button("ЦЕХА", p.on_cases, bw, "secondary")
                E.button("СПРАВКА", p.on_help, bw, "secondary")
                E.button("ВЫХОД", p.on_quit, bw, "secondary", not p.busy)
            end)
            if p.message and p.message ~= "" then
                Parts.text(p.message, "caption", C.muted)
            end
            E.button(p.music == false and "МУЗЫКА: ВЫКЛ" or "МУЗЫКА: ВКЛ", p.on_music, nil, "secondary")
        end)
    end)
end)

K.preview("Главное меню", { width = 1280, height = 760, padding = 0, theme = Theme.theme, group = "Экраны" }, function()
    Main({ w = 1280, h = 760, progress = true, ready = true, first_ready = true })
end)

return Main
