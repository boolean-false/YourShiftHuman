local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Hover = require("game:hover")
local Actions = require("game:selection_actions")
local Splitter = require("game:splitter")

return K.component(function()
    local ratio = K.poll(function()
        local object = Hover.selected
        if Hover.dialog_open and object and object.id == block.index("game:splitter") and
                block.get(object.x, object.y, object.z) == object.id then
            return Splitter.get_ratio(object.x, object.y, object.z)
        end
        return 0
    end)
    local last = K.remember(function()
        return { value = 1 }
    end)
    if ratio ~= 0 then
        last.value = ratio
    end

    UI.Dialog({
        visible = ratio ~= 0,
        title = "Разделитель",
        text = "Лево : право",
        on_dismiss = Hover.close_dialog,
        dismiss = { text = "Закрыть" }
    }, function()
        K.Row({ spacing = 8 }, function()
            for i, setting in ipairs(Splitter.ratios) do
                local index = i
                UI.Button({
                    text = setting.name,
                    selected = last.value == i,
                    on_click = function()
                        if ratio ~= 0 then
                            Actions.set_splitter_ratio(index)
                        end
                    end
                })
            end
        end)
    end)
end)
