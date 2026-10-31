local K = require("kompot:kompot")
local Parts = require("game:ui/menu_parts")
local E = require("game:ui/components")
local Theme = require("game:ui/theme")
local Complete = K.component(function(p)
    E.modal({ visible = p.visible, w = p.w, h = p.h, width = 540,
              badge = "ПРОВЕРКА ПРОЙДЕНА", title = p.last and "Последний цех готов" or "Линия работает" }, function()
        Parts.text("Заказ выполнен. Прогресс сохранён.")
        if p.verdict then
            Parts.text(p.verdict, "body", Theme.colors.muted)
        end
        E.button(p.last and "ИТОГИ СМЕНЫ" or "СЛЕДУЮЩИЙ ЦЕХ", p.on_next, nil, "primary", p.ready and not p.busy)
        if not p.ready then
            Parts.text("Следующий цех пока недоступен", "caption", Theme.colors.muted)
        end
        E.button("В ГЛАВНОЕ МЕНЮ", p.on_menu, nil, "secondary", not p.busy)
    end)
end)

K.preview("Превью", { width = 900, height = 650, padding = 0, theme = Theme.theme, group = "Диалоги" }, function()
    Complete({ visible = true, w = 900, h = 650, ready = true })
end)

return Complete
