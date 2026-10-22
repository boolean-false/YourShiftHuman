local Conveyor = require("game:conveyor")
local Merger = require("game:merger")

function on_placed(x, y, z)
    Conveyor.update_nearby(x, y, z)
end
function on_block_present(x, y, z)
    Conveyor.update_nearby(x, y, z)
end
function on_broken(x, y, z)
    Merger.remove(x, y, z)
end
function on_replaced(x, y, z)
    Merger.remove(x, y, z)
end
