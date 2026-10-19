local Conveyor = require("game:conveyor")

function on_block_tick(x, y, z, tps)
    local dx, _, dz = block.get_Z(x, y, z)
    local nx, nz = x + dx, z + dz

    if block.get(nx, y, nz) ~= block.index("game:conveyor") then return end

    -- Глядим что конвеер не смотрит на источник
    local next_dx, _, next_dz = block.get_Z(nx, y, nz)
    if next_dx == -dx and next_dz == -dz then return end

    Conveyor.insert(nx, y, nz, "base:red_lamp.item")
end

-- поворот с Ctrl + ПКМ
function on_interact(x, y, z, player_id)
    if input.is_pressed("key:left-ctrl") then
        block.set_rotation(x, y, z, (block.get_rotation(x, y, z) + 1) % 4)
        return true
    end
    return false
end
