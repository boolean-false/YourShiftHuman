local K = require("kompot:kompot")
local E = require("game:ui/components")
local Theme = require("game:ui/theme")
local Buttons = K.component(function(p)
    for i, level in ipairs(p.levels) do
        local index = i
        E.button(string.format("%02d / %s", i, level.title), function()
            p.on_select(index)
        end, nil, "secondary", not p.busy)
    end
    E.button("НАЗАД", p.on_back, nil, "secondary")
end)
K.preview("Выбор уровня редактора", { width = 440, height = 260, theme = Theme.theme, group = "Редактор" }, function()
    Buttons({ levels = { { title = "Тестовое задание 1" }, { title = "Тестовое задание 2" }, { title = "Тестовое задание 3" } }, on_select = function()
    end })
end)
return Buttons
