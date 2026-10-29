local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Hover = require("game:hover")
local Sink = require("game:sink")
local Session = require("game:session")
local Actions = require("game:selection_actions")

return K.component(function()
    local sink_type = K.poll(function()
        local object = Hover.selected
        if Hover.dialog_open and object and object.id == block.index("game:sink") and
                block.get(object.x, object.y, object.z) == object.id then
            return Sink.get_type(object.x, object.y, object.z)
        end
        return 0
    end)
    local last = K.remember(function()
        return { value = 1 }
    end)
    if sink_type ~= 0 then
        last.value = sink_type
    end

    UI.Dialog({
        visible = sink_type ~= 0,
        title = "Приёмка",
        on_dismiss = Hover.close_dialog,
        dismiss = { text = "Закрыть" }
    }, function()
        UI.Button({
            text = "Тип: " .. Sink.caption(last.value),
            enabled = Session.editing,
            modifier = K.M:fill_max_width(),
            on_click = function()
                if sink_type ~= 0 then
                    Actions.cycle_sink()
                end
            end
        })
    end)
end)
