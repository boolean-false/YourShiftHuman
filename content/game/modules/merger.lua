local M = {}
local Utils = require("game:utils")
local next_input = {}

-- Спереди только выход.
local function inputs(x, y, z)
    local dx, dz = Utils.direction(x, y, z)
    return {
        { -dx, -dz },
        { -dz, dx },
        { dz, -dx }
    }
end

function M.is_input(x, y, z, dx, dz)
    return not Utils.opposite_direction(x, y, z, dx, dz)
end

-- Выбираем следующий вход по кругу
function M.can_accept(x, y, z, dx, dz, is_ready)
    local sides = inputs(x, y, z)
    local first = next_input[Utils.key(x, y, z)] or 1
    for i = 0, 2 do
        local side = sides[(first - 1 + i) % 3 + 1]
        if is_ready(side[1], side[2]) then
            return dx == -side[1] and dz == -side[2]
        end
    end
    return false
end

-- Передали предмет, выбираем след сторону по кругу
function M.received(x, y, z, dx, dz)
    for index, side in ipairs(inputs(x, y, z)) do
        if dx == -side[1] and dz == -side[2] then
            next_input[Utils.key(x, y, z)] = index % 3 + 1
            return
        end
    end
end

function M.remove(x, y, z)
    next_input[Utils.key(x, y, z)] = nil
end

function M.clear()
    next_input = {}
end

return M
