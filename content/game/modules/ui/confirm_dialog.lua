local K = require("kompot:kompot")
local E = require("game:ui/components")
local Theme = require("game:ui/theme")

local Confirm = K.component(function(p)
    E.modal({ visible = p.visible, w = p.w, h = p.h, title = p.title, text = p.text, width = 540, height = 340 }, function()
        E.button(p.confirm or "ПОДТВЕРДИТЬ", p.on_confirm, nil, "danger", not p.busy)
        E.button(p.cancel or "ОТМЕНА", p.on_cancel, nil, "secondary", not p.busy)
    end)
end)

K.preview("Подтверждение", { width = 800, height = 500, padding = 0, theme = Theme.theme, group = "Диалоги" }, function()
    Confirm({ visible = true, w = 800, h = 500, title = "Новая смена?", text = "Начать с первого цеха? Текущая схема и весь прогресс будут удалены.", confirm = "НАЧАТЬ ЗАНОВО" })
end)

return Confirm
