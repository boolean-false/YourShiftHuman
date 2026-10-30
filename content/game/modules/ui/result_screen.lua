local K = require("kompot:kompot")
local E = require("game:ui/components")
local Parts = require("game:ui/menu_parts")
local Theme = require("game:ui/theme")

local Result = K.component(function(p)
    E.modal({ visible = p.visible, w = p.w, h = p.h, width = 560, height = 460,
              badge = "СВОДКА ПО СМЕНЕ", title = "Смена\nзакрыта" }, function()
        Parts.text("Цеха вышли на норму. В итоговой сводке ваши исправления записаны как плановое обслуживание.", "title")
        Parts.text("Закрыто цехов: " .. p.count .. "\nСледующая смена пока без даты.", "body", Theme.colors.muted)
        E.button("ЗАКРЫТЬ СМЕНУ", p.on_close)
    end)
end)
K.preview("Итоги смены", { width = 900, height = 650, padding = 0, theme = Theme.theme, group = "Экраны" }, function()
    Result({ visible = true, w = 900, h = 650, count = 3 })
end)
return Result
