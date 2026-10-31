local K = require("kompot:kompot")
local Theme = require("game:ui/theme")
local C = Theme.colors

local Badge = K.component(function(p)
    K.Box({
        modifier = K.M:width(p.width or 40):height(24)
            :background(p.color or C.paper, K.Shape.rounded(5)):padding(5, 0),
        align = "center"
    }, function()
        K.Text(p.text, { style = "caption", color = p.color and C.white or C.blue, wrap = false })
    end)
end)

K.preview("Подпись входа", { width = 100, height = 60, theme = Theme.theme, group = "Подписи" }, function()
    Badge({ text = "ВХ", color = C.green })
end)

K.preview("Подпись выхода", { width = 100, height = 60, theme = Theme.theme, group = "Подписи" }, function()
    Badge({ text = "ВЫХ", color = C.blue })
end)

K.preview("Название станка", { width = 210, height = 60, theme = Theme.theme, group = "Подписи" }, function()
    Badge({ text = "Пресс", width = 170 })
end)

return Badge
