local Conveyor = require("game:conveyor")
local Utils = require("game:utils")


function on_interact(x, y, z, player_id)
    -- при нажатии пкм с котролом - вращяем по часовой
    if Utils.rotate_on_ctrl(x, y, z) then return true end

    Conveyor.insert(x, y, z, "base:red_lamp.item")
    return true
end
