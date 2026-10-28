local M = {}
local Utils = require("game:utils")
local next_slot = {}

M.ratios = {
    { name = "1:1", outputs = { 1, 2 } },
    { name = "2:1", outputs = { 1, 1, 2 } },
    { name = "1:2", outputs = { 1, 2, 2 } }
}

function M.get_ratio(x, y, z)
    local index = block.get_user_bits(x, y, z, 0, 2) + 1
    return M.ratios[index] and index or 1
end

-- 0 соответствует пропор 1:1
function M.set_ratio(x, y, z, index)
    if not M.ratios[index] or block.get(x, y, z) ~= block.index("game:splitter") then
        return false
    end
    if M.get_ratio(x, y, z) == index then
        return false
    end
    block.set_user_bits(x, y, z, 0, 2, index - 1)
    return true
end

-- У разделителя выходы только по бокам
function M.is_output(x, y, z, dx, dz)
    local forward_x, forward_z = Utils.direction(x, y, z)
    return forward_x * dx + forward_z * dz == 0
end

-- Обходим выходы по выбранной пропорции, пропуская занятые.
function M.choose_output(x, y, z, can_send)
    local dx, dz = Utils.direction(x, y, z)
    local sides = {{-dz, dx}, {dz, -dx}}
    local outputs = M.ratios[M.get_ratio(x, y, z)].outputs
    local first = next_slot[Utils.key(x, y, z)] or 1
    for i = 0, #outputs - 1 do
        local slot = (first - 1 + i) % #outputs + 1
        local direction = sides[outputs[slot]]
        if can_send(direction[1], direction[2]) then
            return direction[1], direction[2], slot
        end
    end
end

-- Меняем очередь только после фактической передачи предмета
function M.sent(x, y, z, slot)
    local outputs = M.ratios[M.get_ratio(x, y, z)].outputs
    next_slot[Utils.key(x, y, z)] = slot % #outputs + 1
end

function M.remove(x, y, z)
    next_slot[Utils.key(x, y, z)] = nil
end

function M.clear()
    next_slot = {}
end

return M
