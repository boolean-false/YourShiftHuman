local Utils = require("game:utils")
local Conveyor = require("game:conveyor")

-- Поворачиваем пресс так же, как источник и конвейер.
function on_interact(x, y, z, player_id)
    if Utils.rotate_on_ctrl(x, y, z) then
        Conveyor.update_nearby(x, y, z)
        return true
    end
    return false
end
