local Conveyor = require("game:conveyor")

function on_placed(x, y, z)
    Conveyor.update_nearby(x, y, z)
end
function on_block_present(x, y, z)
    Conveyor.update_nearby(x, y, z)
end
