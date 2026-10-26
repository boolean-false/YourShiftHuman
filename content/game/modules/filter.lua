local M = {}
local Utils = require("game:utils")
local Products = require("game:products")

M.parts = {
    { id = "ore", name = "Руда" },
    { id = "ingot", name = "Слиток" },
    { id = "gear", name = "Шестерёнка" },
    { id = "rod", name = "Вал" },
    { id = "gearbox", name = "Редуктор" }
}

function M.get_type(x, y, z)
    local index = block.get_user_bits(x, y, z, 0, 3)
    return M.parts[index] and index or 2
end

function M.set_type(x, y, z, index)
    if not M.parts[index] or block.get(x, y, z) ~= block.index("game:filter") then
        return false
    end
    if M.get_type(x, y, z) == index then
        return false
    end
    block.set_user_bits(x, y, z, 0, 3, index)
    return true
end

-- Принимаем предметы только через задний проход...
function M.can_accept(x, y, z, dx, dz, item_name)
    return Products[item_name] ~= nil and Utils.same_direction(x, y, z, dx, dz)
end

function M.output(x, y, z, item_name)
    if not Products[item_name] then
        return nil
    end
    local selected = M.parts[M.get_type(x, y, z)].id
    local side = item_name == selected and -1 or 1
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
