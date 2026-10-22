local Conveyor = require("game:conveyor")
local Utils = require("game:utils")
local Source = require("game:source")

function on_placed(x, y, z)
    Source.register(x, y, z)
    Conveyor.update_nearby(x, y, z)
end

function on_block_present(x, y, z)
    Source.register(x, y, z)
    Conveyor.update_nearby(x, y, z)
end

function on_block_removed(x, y, z)
    Source.remove_model(x, y, z)
end

function on_block_tick(x, y, z, tps)
    if block.is_segment(x, y, z) then return end
    local dx, dz = Utils.direction(x, y, z)
    Conveyor.feed(x + dx, y, z + dz, dx, dz, "ore")
end

function on_interact(x, y, z, player_id)
    x, y, z = block.seek_origin(x, y, z)
    if Utils.rotate_on_ctrl(x, y, z) then
        Conveyor.update_nearby(x, y, z)
        return true
    end
    return false
end
