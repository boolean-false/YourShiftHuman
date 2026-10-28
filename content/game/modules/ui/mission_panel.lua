local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Mission = require("game:mission")
local Products = require("game:products")
local Delivery = require("game:delivery")
local Actions = require("game:selection_actions")
local parts = { "gear", "rod", "gearbox" }

return K.component(function()
    local mission = K.poll(function()
        return Mission.current()
    end)
    UI.Panel({ title = mission.title, width = 340 }, function()
        K.Column({ spacing = 8 }, function()
            for _, item_name in ipairs(parts) do
                local part = item_name
                if mission.goals[part] then
                    K.Text(K.poll(function()
                        return Products[part].caption .. ": "
                                .. Delivery.rate(part) .. " / "
                                .. mission.goals[part] .. " шт/мин"
                    end))
                end
            end

            K.Text(K.poll(function()
                return Mission.status()
            end))

            local completed = K.poll(function()
                return Mission.completed
            end)

            if completed and not Mission.is_last() then
                UI.Button({
                    text = "Следующее задание",
                    modifier = K.M:fill_max_width(),
                    on_click = Actions.next_mission
                })
            end
        end)
    end)
end)
