local K = require("kompot:kompot")
local Hover = require("game:hover")

return K.component(function(props)
    K.Text(K.poll(function()
        local object = props.object or Hover.selected
        if not object or block.get(object.x, object.y, object.z) ~= block.index(props.machine.block_name) then
            return ""
        end
        return props.machine.describe(object.x, object.y, object.z)
    end))
end)
