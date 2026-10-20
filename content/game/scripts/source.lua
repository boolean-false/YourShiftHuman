local Conveyor = require("game:conveyor")
local Utils = require("game:utils")

function on_block_tick(x, y, z, tps)
    local dx, dz = Utils.direction(x, y, z)
    local nx, nz = x + dx, z + dz

    Conveyor.feed(nx, y, nz, dx, dz, "base:red_lamp.item")
end

-- поворот с Ctrl + ПКМ
function on_interact(x, y, z, player_id)
    if Utils.rotate_on_ctrl(x, y, z) then
        Conveyor.update_nearby(x, y, z)
        return true
    end
    return false
end
