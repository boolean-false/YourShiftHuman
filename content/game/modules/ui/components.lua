local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Theme = require("game:ui/theme")
local Parts = require("game:ui/menu_parts")
local M = {}

function M.button(text, action, width, tone, enabled, modifier)
    UI.Button({
        modifier = modifier or (width and K.M:width(width) or K.M:fill_max_width()),
        text = text, on_click = action, enabled = enabled ~= false,
        variant = tone or "primary",
    })
end

M.panel = K.component(function(p, content)
    if p.height then
        Parts.sheet(p.x or 0, p.y or 0, p.width, p.height, function()
            K.Column({ spacing = p.spacing or 12, modifier = K.M:fill_max_size() }, content)
        end)
        return
    end

    local shape = K.Shape.rounded(12)
    K.Box({ modifier = K.M:offset(p.x or 0, p.y or 0):width(p.width):height_in(0, p.max_height) }, function()
        K.Box({ modifier = K.M:match_parent_size():offset(3, 4):background("#20263855", shape) })
        K.Box({ modifier = K.M:fill_max_width():background(Theme.colors.paper, shape)
            :border(1, "#FFFFFF88", shape):padding(18):block_pointer() }, function()
            K.Column({ spacing = p.spacing or 12, modifier = K.M:fill_max_width() }, content)
        end)
    end)
end)

M.modal = K.component(function(p, content)
    local scroll = K.scroll_state()
    if not p.visible then
        return
    end
    local width = math.min(p.width or 540, p.w - 40)
    local max_height = math.min(p.height or p.h - 40, p.h - 40)
    local shape = K.Shape.rounded(12)
    K.Box({ modifier = K.M:fill_max_size():background("#17262B99"):block_pointer() })
    K.Box({ modifier = K.M:fill_max_size(), align = "center" }, function()
        K.Box({ modifier = K.M:width(width):height_in(0, max_height) }, function()
            K.Box({ modifier = K.M:match_parent_size():offset(3, 4):background("#20263855", shape) })
            K.Box({ modifier = K.M:fill_max_width():background(Theme.colors.paper, shape)
                                :border(1, "#FFFFFF88", shape):padding(18):block_pointer() }, function()
                K.Column({ spacing = 18, modifier = K.M:fill_max_width():vertical_scroll(scroll) }, function()
                    if p.badge then
                        Parts.badge(p.badge, math.min(width - 36, 330))
                    end
                    if p.title then
                        Parts.text(p.title, "heading")
                    end
                    if p.text then
                        Parts.text(p.text)
                    end
                    if content then
                        content()
                    end
                end)
            end)
        end)
    end)
end)

function M.line()
    K.Box({ modifier = K.M:fill_max_width():height(1):background(Theme.colors.line) })
end

K.preview("Кнопы", { width = 380, height = 300, theme = Theme.theme, group = "Элементы" }, function()
    local value = K.state(0)
    K.Column({ spacing = 12 }, function()
        M.button("БАЗА / " .. value.value, function()
            value.value = value:peek() + 1
        end)
        M.button("СЕКОНД", function()
        end, nil, "secondary")
        M.button("СЕЛЕКТЕД", function()
        end, nil, "yellow")
        M.button("ДАНГЕР", function()
        end, nil, "danger")
        M.button("ИНВАЛИД", nil, nil, "primary", false)
    end)
end)

K.preview("Модалка", { width = 600, height = 240, padding = 0, theme = Theme.theme, group = "Элементы" }, function()
    M.modal({ visible = true, w = 700, h = 440, title = "Подтверждение", text = "Что-то" }, function()
        M.button("ПРОДОЛЖИТЬ", function()
        end)
    end)
end)

K.preview("Панелька", { width = 380, height = 220, padding = 0, theme = Theme.theme, group = "Элементы" }, function()
    M.panel({ x = 20, y = 20, width = 340, height = 180 }, function()
        Parts.text("Заголовок", "title")
        Parts.text("Содержимое панели")
    end)
end)

K.preview("Дивидер", { width = 380, height = 60, theme = Theme.theme, group = "Элементы" }, function()
    M.line()
end)

return M
