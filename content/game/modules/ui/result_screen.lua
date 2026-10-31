local K = require("kompot:kompot")
local E = require("game:ui/components")
local Parts = require("game:ui/menu_parts")
local Theme = require("game:ui/theme")

local Result = K.component(function(p)
    E.modal({ visible = p.visible, w = p.w, h = p.h, width = 560, height = 460,
              badge = "ДИСПЕТЧЕР / ИИ ЗАВОДА", title = "На сегодня\nвсё" }, function()
        Parts.text("Все цеха работают. Теперь по-настоящему. Спасибо, человек. Похоже, с полной автоматизацией я поторопился.", "title")
        Parts.text("Пройдено цехов: " .. p.count, "body", Theme.colors.muted)
        E.button("В ГЛАВНОЕ МЕНЮ", p.on_close)
    end)
end)
K.preview("Итоги смены", { width = 900, height = 650, padding = 0, theme = Theme.theme, group = "Экраны" }, function()
    Result({ visible = true, w = 900, h = 650, count = 3 })
end)
return Result
