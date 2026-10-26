local Conveyor = require("game:conveyor")
local Utils = require("game:utils")
local Source = require("game:source")
local Production = require("game:production")

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
    if block.is_segment(x, y, z) then
        return
    end
    local dx, dz = Utils.direction(x, y, z)
    Conveyor.feed(x + dx, y, z + dz, dx, dz, "ore")
end
