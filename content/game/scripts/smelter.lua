local Smelter = require("game:smelter")
local Utils = require("game:utils")

function on_placed(x, y, z)
    Smelter.register(x, y, z)
end

function on_block_present(x, y, z)
    Smelter.register(x, y, z)
end

function on_block_removed(x, y, z)
    Smelter.remove_model(x, y, z)
end

function on_interact(x, y, z, player_id)
    x, y, z = block.seek_origin(x, y, z)
    return Utils.rotate_on_ctrl(x, y, z)
end
