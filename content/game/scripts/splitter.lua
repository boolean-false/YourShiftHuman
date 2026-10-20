local Conveyor = require("game:conveyor")
local Splitter = require("game:splitter")
local Utils = require("game:utils")

function on_placed(x, y, z) Conveyor.update_nearby(x, y, z) end
function on_block_present(x, y, z) Conveyor.update_nearby(x, y, z) end
function on_broken(x, y, z) Splitter.remove(x, y, z) end
function on_replaced(x, y, z) Splitter.remove(x, y, z) end

function on_interact(x, y, z, player_id)
    if Utils.rotate_on_ctrl(x, y, z) then
        Conveyor.update_nearby(x, y, z)
        return true
    end
    return false
end
