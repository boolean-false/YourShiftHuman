local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Session = require("game:session")

-- Менюшка
return K.component(function()
    local visible = K.poll(function()
        return Session.pause_open
    end)
    local busy = K.poll(function()
        return Session.busy
    end)
    UI.Dialog({
        visible = visible,
        title = "Пауза",
        on_dismiss = Session.close_pause,
        dismiss = { text = "Продолжить" }
    }, function()
        K.Column({ spacing = 4 }, function()
            UI.Button({
                text = "Заново",
                enabled = not busy,
                on_click = function()
                    Session.queue("play", Session.index)
                end
            })
            UI.Button({
                text = "Главное меню",
                enabled = not busy,
                on_click = function()
                    Session.queue("menu")
                end
            })
            K.Text(K.poll(function()
                return Session.message or ""
            end))
        end)
    end)
end)
