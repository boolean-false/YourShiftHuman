local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Hover = require("game:hover")
local Actions = require("game:selection_actions")
local Filter = require("game:filter")

return K.component(function()
    local filter_type = K.poll(function()
        local object = Hover.selected
        if Hover.dialog_open and object and object.id == block.index("game:filter") and
                block.get(object.x, object.y, object.z) == object.id then
            return Filter.get_type(object.x, object.y, object.z)
        end
        return 0
    end)

    local last = K.remember(function()
        return { value = 2 }
    end)

    if filter_type ~= 0 then
        last.value = filter_type
    end

    UI.Dialog({
        visible = filter_type ~= 0,
        title = "Фильтр",
        text = "Налево: выбранный. Направо: остальные",
        on_dismiss = Hover.close_dialog,
        dismiss = { text = "Закрыть" }
    }, function()
        K.Column({ spacing = 4 }, function()
            UI.Button({
                text = "Тип: " .. Filter.parts[last.value].name,
                modifier = K.M:fill_max_width(),
                on_click = function()
                    if filter_type ~= 0 then
                        Actions.cycle_filter()
                    end
                end
            })
        end)
    end)
end)
