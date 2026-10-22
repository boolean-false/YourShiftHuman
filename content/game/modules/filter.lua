local M = {}
local Utils = require("game:utils")

-- TODO Временно -1 налево, 1 направо
local routes = {
    ore = -1,
    ingot = 1,
    gear = 1,
    rod = 1,
    gearbox = 1
}

-- Принимаем предметы только через задний проход...
function M.can_accept(x, y, z, dx, dz, item_name)
    return routes[item_name] ~= nil and Utils.same_direction(x, y, z, dx, dz)
end

function M.output(x, y, z, item_name)
    local side = routes[item_name]
    if not side then
        return nil
    end
    local dx, dz = Utils.direction(x, y, z)
    return dz * side, -dx * side
end

function M.is_output(x, y, z, dx, dz, item_name)
    if item_name then
        local out_x, out_z = M.output(x, y, z, item_name)
        return out_x == dx and out_z == dz
    end
    local forward_x, forward_z = Utils.direction(x, y, z)
    return forward_x * dx + forward_z * dz == 0
end

return M
