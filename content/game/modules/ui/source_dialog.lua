local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Hover = require("game:hover")
local Source = require("game:source")
local Session = require("game:session")
local Actions = require("game:selection_actions")

return K.component(function()
    local source_type = K.poll(function()
        local object = Hover.selected
        if Hover.dialog_open and object and object.id == block.index("game:source") and
                block.get(object.x, object.y, object.z) == object.id then
            return Source.get_type(object.x, object.y, object.z)
        end
        return 0
    end)
    local last = K.remember(function()
        return { value = 1 }
    end)
    if source_type ~= 0 then
        last.value = source_type
    end

    UI.Dialog({
        visible = source_type ~= 0,
        title = "Пункт доставки",
        on_dismiss = Hover.close_dialog,
        dismiss = { text = "Закрыть" }
    }, function()
        UI.Button({
            text = "Продукция: " .. Source.caption(last.value),
            enabled = Session.editing,
            modifier = K.M:fill_max_width(),
            on_click = function()
                if source_type ~= 0 then
                    Actions.cycle_source()
                end
            end
        })
    end)
end)
