local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Delivery = require("game:delivery")
local Products = require("game:products")

local parts = { "ore", "ingot", "gear", "rod", "gearbox" }

return K.component(function()
    UI.Panel({ title = "Приёмка", width = 340 }, function()
        K.Column({ spacing = 4 }, function()
            K.Text("Доставлено / выпуск в минуту")
            for _, item_name in ipairs(parts) do
                local part = item_name
                K.Text(K.poll(function()
                    return Products[part].caption .. ": " .. Delivery.total(part) ..
                        " / " .. Delivery.rate(part) .. " шт/мин"
                end))
            end
        end)
    end)
end)
