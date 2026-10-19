local Conveyor = require("game:conveyor")
local Utils = require("game:utils")

function on_block_tick(x, y, z, tps)
    local dx, dz = Utils.direction(x, y, z)
    local nx, nz = x + dx, z + dz

    if block.get(nx, y, nz) ~= block.index("game:conveyor") then return end

    -- Глядим что конвеер не смотрит на источник
    if Utils.opposite_direction(nx, y, nz, dx, dz) then return end

    Conveyor.insert(nx, y, nz, "base:red_lamp.item")
end

-- поворот с Ctrl + ПКМ
function on_interact(x, y, z, player_id)
    return Utils.rotate_on_ctrl(x, y, z)
end
