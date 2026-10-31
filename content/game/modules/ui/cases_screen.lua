local K = require("kompot:kompot")
local E = require("game:ui/components")
local Parts = require("game:ui/menu_parts")
local Theme = require("game:ui/theme")
local C = Theme.colors

local Card = K.component(function(p)
    local hot = K.interaction()
    local level = p.level
    local fill = not level.available and "#E3E0D7" or hot.hovered.value and "#E0E7FD" or level.completed and "#E5EDE2" or C.white
    K.Box({ modifier = K.M:size(p.width, 94):background(fill, K.Shape.rounded(8)):padding(13)
                        :clickable(p.on_click, { enabled = level.available and not p.busy, interaction = hot }) }, function()
        K.Column({ spacing = 9 }, function()
            Parts.text(string.format("%02d / %s", p.index, level.title), "label", level.available and C.ink or C.muted)
            Parts.text(level.completed and "ПРОЙДЕН" or level.available and "МОЖНО НАЧИНАТЬ" or
                    level.unlocked and "ЦЕХ ПОКА НЕДОСТУПЕН" or "ПРОЙДИ ПРЕДЫДУЩИЙ ЦЕХ", "caption", level.completed and C.green or C.muted)
        end)
    end)
end)
local Cases = K.component(function(p)
    local width = math.min(980, p.w - 48)
    local columns = width >= 700 and 2 or 1
    E.modal({ visible = true, w = p.w, h = p.h, width = width }, function()
        K.Column({ spacing = 14, modifier = K.M:fill_max_width() }, function()
            Parts.text("ВЫБОР УРОВНЯ", "caption", C.blue)
            Parts.text("Цеха", "heading")
            for row = 1, #p.levels, columns do
                K.Row({ spacing = 12 }, function()
                    for index = row, math.min(row + columns - 1, #p.levels) do
                        local selected = index
                        K.key(selected, function()
                            Card({ index = selected, level = p.levels[selected], busy = p.busy,
                                   width = (width - 36 - (columns - 1) * 12) / columns,
                                   on_click = function()
                                       p.on_select(selected)
                                   end })
                        end)
                    end
                end)
            end
            Parts.text("Цех откроется с исходной схемой. Отметки о пройденных цехах сохранятся.", "body", C.muted)
            E.button("НАЗАД", p.on_back, nil, "secondary")
        end)
    end)
end)
K.preview("Превью1", { width = 500, height = 130, theme = Theme.theme, group = "Элементы" }, function()
    Card({ width = 466, index = 1, level = { title = "Первые детали", available = true, completed = true } })
end)
K.preview("Превью2", { width = 1100, height = 650, padding = 0, theme = Theme.theme, group = "Экраны" }, function()
    Cases({ w = 1100, h = 650, levels = {
        { title = "Первые детали", completed = true, available = true },
        { title = "Вторая плавильня", unlocked = true, available = true },
        { title = "Через стену" }
    }, on_select = function()
    end, on_back = function()
    end })
end)
return Cases
