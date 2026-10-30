local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Mission = require("game:mission")
local Session = require("game:session")
local Actions = require("game:selection_actions")

return K.component(function()
    local visible = K.poll(function()
        return Session.managed and not Session.editing and Mission.completed
    end)
    local last = K.poll(function()
        return Mission.is_last()
    end)
    local ready = K.poll(function()
        return not Session.busy and (Mission.is_last() or Session.has_level(Mission.index + 1))
    end)
    UI.Dialog({
        visible = visible,
        title = last and "Все задания выполнены" or "Задание выполнено",
        on_dismiss = function()
            Session.queue("menu")
        end,
        dismiss = { text = "В главное меню" }
    }, function()
        if not last then
            UI.Button({
                text = ready and "Следующий уровень" or "Следующий уровень не готов",
                enabled = ready,
                modifier = K.M:fill_max_width(),
                on_click = Actions.next_mission
            })
        end
    end)
end)
