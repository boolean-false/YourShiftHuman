local Assembler = require("game:assembler")
local Utils = require("game:utils")

function on_placed(x, y, z)
    Assembler.register(x, y, z)
end

function on_block_present(x, y, z)
    Assembler.register(x, y, z)
end

function on_block_removed(x, y, z)
    Assembler.remove_model(x, y, z)
end

function on_interact(x, y, z, player_id)
    x, y, z = block.seek_origin(x, y, z)
    return Utils.rotate_on_ctrl(x, y, z)
end
