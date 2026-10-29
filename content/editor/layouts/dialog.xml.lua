local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Hover = require("game:hover")
local EquipmentDialogs = require("game:ui/equipment_dialogs")
local handle

function on_open()
    handle = K.mount({
        target = document.root,
        theme = UI.DEFAULT,
        interactive = true,
        content = EquipmentDialogs
    })
end

function on_close()
    if handle then
        handle:dispose();
        handle = nil
    end
    Hover.clear_selection()
end
