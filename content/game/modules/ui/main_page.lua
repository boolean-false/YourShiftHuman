local K = require("kompot:kompot")
local E = require("game:ui/components")
local Parts = require("game:ui/menu_parts")
local Theme = require("game:ui/theme")
local C = Theme.colors

local Main = K.component(function(p)
    local scroll = K.scroll_state()
    local width = math.min(510, p.w - 56)
    E.panel({ x = 28, y = 28, width = width, height = math.min(660, p.h - 56) }, function()
        K.Column({ spacing = 20, modifier = K.M:fill_max_size():vertical_scroll(scroll) }, function()
            K.Row({ spacing = 15, align = "center" }, function()
                Parts.mark()
                Parts.text("КОНТРОЛЬ ПРОИЗВОДСТВА\nДЕЖУРНЫЙ ПЕРСОНАЛ: 1", "caption", C.blue)
            end)
            E.line()
            Parts.text("Ваша смена,\nчеловек", "display")
            Parts.badge("НАРЯД НА РУЧНУЮ ПРОВЕРКУ", math.min(370, width - 36))
            Parts.text("По отчёту всё работает", "title", C.blue)
            Parts.text("Заводы перешли на автоматическое управление. Сырьё поступает, отчёты сходятся, а из цехов ничего не выходит. Вы единственный, кого ещё можно отправить разобраться на месте.", "body", C.muted)
            if p.progress then
                E.button("ПРОДОЛЖИТЬ СМЕНУ", p.on_continue, nil, "primary", p.ready and not p.busy)
            end
            E.button("НОВАЯ СМЕНА", p.on_new, nil, p.progress and "secondary" or "primary", p.first_ready and not p.busy)
            K.Row({ spacing = 8 }, function()
                local bw = (width - 60) / 4
                E.button("КУРАТОР", p.on_curator, bw, "secondary")
                E.button("ЦЕХА", p.on_cases, bw, "secondary")
                E.button("ПАМЯТКА", p.on_help, bw, "secondary")
                E.button("ВЫХОД", p.on_quit, bw, "secondary", not p.busy)
            end)
            if p.editor then
                E.button("РЕДАКТОР УРОВНЕЙ", p.on_editor, nil, "secondary", not p.busy)
            end
            if p.message and p.message ~= "" then
                Parts.text(p.message, "caption", C.muted)
            end
        end)
    end)
end)

K.preview("Главное меню", { width = 1280, height = 760, padding = 0, theme = Theme.theme, group = "Экраны" }, function()
    Main({ w = 1280, h = 760, progress = true, ready = true, first_ready = true })
end)

return Main
