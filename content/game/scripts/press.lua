local Conveyor = require("game:conveyor")
local Press = require("game:press")

function on_interact(x, y, z)
    return events.emit("game:block_settings", x, y, z) or false
end

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
