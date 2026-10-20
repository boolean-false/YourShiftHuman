local M = {}
local Utils = require("game:utils")
local next_side = {}

-- У разделителя выходы только по бокам
function M.is_output(x, y, z, dx, dz)
    local forward_x, forward_z = Utils.direction(x, y, z)
    return forward_x * dx + forward_z * dz == 0
end

-- Сначала пробуем очередной выход, затем второй. can_send чекает место впереди
function M.choose_output(x, y, z, can_send)
    local dx, dz = Utils.direction(x, y, z)
    local sides = {{-dz, dx}, {dz, -dx}}
    local first = next_side[Utils.key(x, y, z)] or 1
    for i = 0, 1 do
        local side = (first - 1 + i) % 2 + 1
        local direction = sides[side]
        if can_send(direction[1], direction[2]) then
            return direction[1], direction[2], side
        end
    end
end

-- Меняем очередь только после фактической передачи предмета
function M.sent(x, y, z, side)
    next_side[Utils.key(x, y, z)] = side == 1 and 2 or 1
end

function M.remove(x, y, z)
    next_side[Utils.key(x, y, z)] = nil
end

function M.clear()
    next_side = {}
end

return M
