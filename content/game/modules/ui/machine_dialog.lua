local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Hover = require("game:hover")
local MachineInfo = require("game:ui/machine_info")

return K.component(function(props)
    local object = K.poll(function()
        local selected = Hover.selected
        if Hover.dialog_open and selected and selected.id == block.index(props.machine.block_name) and
                block.get(selected.x, selected.y, selected.z) == selected.id then
            return selected
        end
        return false
    end)
    local last = K.remember(function()
        return {}
    end)
    if object then
        last.object = object
    end
    UI.Dialog({
        visible = object ~= false,
        title = props.title,
        on_dismiss = Hover.close_dialog,
        dismiss = { text = "Закрыть" }
    }, function()
        MachineInfo({ machine = props.machine, object = last.object })
    end)
end)
