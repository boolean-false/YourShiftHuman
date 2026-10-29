local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Hover = require("game:hover")
local Actions = require("game:selection_actions")
local Press = require("game:press")
local MachineInfo = require("game:ui/machine_info")

return K.component(function()
    local recipe = K.poll(function()
        local object = Hover.selected
        if Hover.dialog_open and object and object.id == block.index(Press.block_name) and
                block.get(object.x, object.y, object.z) == object.id then
            return Press.get_recipe(object.x, object.y, object.z) or ""
        end
        return ""
    end)

    local last = K.remember(function()
        return { value = "gear" }
    end)

    if recipe ~= "" then
        last.value = recipe
    end

    UI.Dialog({
        visible = recipe ~= "",
        title = "Пресс",
        on_dismiss = Hover.close_dialog,
        dismiss = { text = "Закрыть" }
    }, function()
        K.Column({ spacing = 4 }, function()
            MachineInfo({ machine = Press })
            UI.Button({
                text = "Шестерёнка",
                selected = last.value == "gear",
                modifier = K.M:fill_max_width(),
                on_click = function()
                    if recipe ~= "" then
                        Actions.set_press_recipe("gear")
                    end
                end
            })
            UI.Button({
                text = "Вал",
                selected = last.value == "rod",
                modifier = K.M:fill_max_width(),
                on_click = function()
                    if recipe ~= "" then
                        Actions.set_press_recipe("rod")
                    end
                end
            })
        end)
    end)
end)
