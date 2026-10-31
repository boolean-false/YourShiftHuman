local K = require("kompot:kompot")
local E = require("game:ui/components")
local Theme = require("game:ui/theme")

local Pause = K.component(function(p)
    E.modal({ visible = p.visible, w = p.w, h = p.h, width = 460, height = 420,
              title = "Пауза", text = "Можно передохнуть. Схема сохранена." }, function()
        E.button("ПРОДОЛЖИТЬ", p.on_resume, nil, "primary", not p.busy)
        E.button("СОХРАНИТЬ И ВЫЙТИ В МЕНЮ", p.on_menu, nil, "secondary", not p.busy)
        E.button("ВЕРНУТЬ ИСХОДНУЮ СХЕМУ", p.on_restart, nil, "secondary", not p.busy)
        K.Row({ spacing = 8, modifier = K.M:fill_max_width() }, function()
            E.button("ЦЕХА", p.on_cases, nil, "secondary", not p.busy, K.M:weight(1))
            E.button(p.music == false and "МУЗЫКА: ВЫКЛ" or "МУЗЫКА: ВКЛ", p.on_music, nil, "secondary", true, K.M:weight(1))
        end)
    end)
end)

K.preview("Пауза", { width = 900, height = 700, padding = 0, theme = Theme.theme, group = "Экраны" }, function()
    Pause({ visible = true, w = 900, h = 700 })
end)

return Pause
