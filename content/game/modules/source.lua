local Machine = require("game:machine")
local Products = require("game:products")
local Session = require("game:session")
local Utils = require("game:utils")
local Room = require("game:room")
local sources = {}

local M = Machine.create({
    block_name = "game:source",
    entity_name = "game:source_visual",
    size = 1
})

local register_model = M.register
local remove_model = M.remove_model
local clear = M.clear

function M.register(x, y, z)
    register_model(x, y, z)
    if block.is_segment(x, y, z) or block.get(x, y, z) ~= block.index(M.block_name) then return end
    local key = Utils.key(x, y, z)
    sources[key] = sources[key] or { x = x, y = y, z = z, ticks = 0 }
end

function M.remove_model(x, y, z)
    remove_model(x, y, z)
    sources[Utils.key(x, y, z)] = nil
end

function M.clear()
    clear()
    sources = {}
end

-- Подача идёт по тем же часам, что и станки с лентами.
function M.tick()
    local Conveyor = require("game:conveyor")
    for _, source in pairs(sources) do
        local x, y, z = source.x, source.y, source.z
        if block.get(x, y, z) == block.index(M.block_name) and Room.contains(x, y, z) then
            source.ticks = math.min(source.ticks + 1, 5)
            if source.ticks == 5 then
                local dx, dz = Utils.direction(x, y, z)
                local item_name = M.types[M.get_type(x, y, z)]
                if Conveyor.feed(x + dx, y, z + dz, dx, dz, item_name) then
                    source.ticks = 0
                end
            end
        end
    end
end

M.types = { "ore", "ingot", "gear", "rod", "gearbox" }

function M.get_type(x, y, z)
    local index = block.get_user_bits(x, y, z, 0, 3) + 1
    return M.types[index] and index or 1
end

function M.caption(index)
    return Products[M.types[index]].caption
end

-- Ноль в блоке оставляем под руду, чтобы старые пункты работали дальше.
function M.set_type(x, y, z, index)
    if not Session.editing or not M.types[index] or block.get(x, y, z) ~= block.index(M.block_name) then
        return false
    end
    if M.get_type(x, y, z) == index then return false end
    block.set_user_bits(x, y, z, 0, 3, index - 1)
    return true
end

return M
