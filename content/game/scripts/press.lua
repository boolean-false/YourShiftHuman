local Utils = require("game:utils")
local Conveyor = require("game:conveyor")
local Press = require("game:press")

-- Обновляем форму лент возле входа и выхода
local function update_ports(x, y, z)
    local ix, iy, iz = Press.port(x, y, z, false)
    local ox, oy, oz = Press.port(x, y, z, true)
    if ix then
        Conveyor.update_nearby(ix, iy, iz)
    end
    if ox then
        Conveyor.update_nearby(ox, oy, oz)
    end
end

function on_placed(x, y, z)
    Press.register(x, y, z)
    update_ports(x, y, z)
end

function on_block_present(x, y, z)
    Press.register(x, y, z)
    update_ports(x, y, z)
end

function on_block_removed(x, y, z)
    Press.remove_model(x, y, z)
end

-- Ручной поврото. Потом уберу
function on_interact(x, y, z, player_id)
    x, y, z = block.seek_origin(x, y, z)
    local ix, iy, iz = Press.port(x, y, z, false)
    local ox, oy, oz = Press.port(x, y, z, true)
    if Utils.rotate_on_ctrl(x, y, z) then
        if ix then
            Conveyor.update_nearby(ix, iy, iz)
        end
        if ox then
            Conveyor.update_nearby(ox, oy, oz)
        end
        update_ports(x, y, z)
        return true
    end
    return false
end
