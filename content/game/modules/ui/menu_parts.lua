local K = require("kompot:kompot")
local Theme = require("game:ui/theme")
local C = Theme.colors
local M = {}

function M.text(text, style, color)
    K.Text(text, { style = style or "body", color = color or C.ink, wrap = true })
end

function M.mark()
    K.Box({
        modifier = K.M:size(45):background(C.white, K.Shape.rounded(10))
    }, function()
        K.Box({
            modifier = K.M:offset(12, 14):size(6, 9):background(C.blue, K.Shape.rounded(3))
        })
        K.Box({
            modifier = K.M:offset(27, 14):size(6, 9):background(C.blue, K.Shape.rounded(3))
        })
        K.Box({
            modifier = K.M:offset(14, 31):size(17, 3):background(C.blue)
        })
    end)
end

function M.badge(text, width)
    K.Box({
        modifier = K.M:width(width)
                    :height(25)
                    :background(C.yellow, K.Shape.rounded(5))
                    :padding(8, 0),
        align = "center_start"
    }, function()
        K.Text(text, { style = "caption", color = C.ink, wrap = false })
    end)
end

function M.sheet(x, y, width, height, content)
    local shape = K.Shape.rounded(12)
    K.Box({ modifier = K.M:offset(x + 3, y + 4):size(width, height):background("#20263855", shape) })
    K.Box({ modifier = K.M:offset(x, y):size(width, height):background(C.paper, shape)
                        :border(1, "#FFFFFF88", shape):padding(18):block_pointer() }, content)
end

K.preview("Текст", {
    width = 420,
    height = 200,
    theme = Theme.theme,
    group = "Элементы меню"
}, function()
    K.Column({ spacing = 12, modifier = K.M:fill_max_size():background(C.paper):padding(12) }, function()
        M.text("Ваша смена, человек", "heading")
        M.text("Само не починится", "title", C.blue)
        M.text("Обычный текст")
        M.text("Служебная подпись", "caption", C.muted)
    end)
end)

K.preview("Чел", {
    width = 100,
    height = 100,
    theme = Theme.theme,
    group = "Элементы меню"
}, function()
    M.mark()
end)

K.preview("Плашка", {
    width = 410,
    height = 70,
    theme = Theme.theme,
    group = "Элементы меню"
}, function()
    M.badge("БЕЗ ТЕБЯ НЕ РАЗОБРАТЬСЯ", 370)
end)

K.preview("Панель", {
    width = 360,
    height = 240,
    padding = 0,
    theme = Theme.theme,
    group = "Элементы меню"
}, function()
    M.sheet(20, 20, 320, 200, function()
    end)
end)

return M
