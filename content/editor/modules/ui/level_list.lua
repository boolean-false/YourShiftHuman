local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Session = require("game:session")
local Missions = require("game:missions")

return K.component(function()
    local busy = K.poll(function()
        return Session.busy
    end)
    for i, mission in ipairs(Missions) do
        local index = i
        UI.Button({
            text = mission.title,
            enabled = not busy,
            modifier = K.M:fill_max_width(),
            on_click = function()
                Session.queue("edit", index)
            end
        })
    end
    UI.Button({ text = "Назад", on_click = function()
        Session.menu_page = "main"
    end })
end)
