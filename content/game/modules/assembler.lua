local Machine = require("game:machine")
local Utils = require("game:utils")
local processing = {}
local recipe = { gear = 2, rod = 1 }
local process_ticks = 40

local M = Machine.create({
    block_name = "game:assembler",
    entity_name = "game:assembler_visual",
    two_inputs = true,
    process_ticks = process_ticks,
    animation = "assembler_work",
    get_process = function(x, y, z)
        return processing[Utils.key(x, y, z)]
    end
})

function M.can_accept(x, y, z, dx, dz, item_name)
    if not recipe[item_name] or not M.is_input(x, y, z, dx, dz) then
        return false
    end
    local ox, oy, oz = block.seek_origin(x, y, z)
    local state = processing[Utils.key(ox, oy, oz)]
    return not state or (state.stock[item_name] or 0) < 4
end

function M.accept(x, y, z, item_name)
    x, y, z = block.seek_origin(x, y, z)
    local key = Utils.key(x, y, z)
    local state = processing[key]
    if not state then
        state = { x = x, y = y, z = z, stock = {}, ticks = 0, ready = false }
        processing[key] = state
    end
    state.stock[item_name] = (state.stock[item_name] or 0) + 1
end

function M.has_output(x, y, z)
    local px, py, pz = M.port(x, y, z, true)
    local ox, oy, oz = block.seek_origin(x, y, z)
    local state = processing[Utils.key(ox, oy, oz)]
    return x == px and
            y == py and
            z == pz and
            state ~= nil
            and state.ready
end

function M.tick()
    local Conveyor = require("game:conveyor")
    for key, state in pairs(processing) do
        local x, y, z = state.x, state.y, state.z
        local id = block.get(x, y, z)

        if id == -1 then
        elseif id ~= block.index(M.block_name) then
            processing[key] = nil
        else
            if not state.ready then
                local enough = true
                for item_name, count in pairs(recipe) do
                    if (state.stock[item_name] or 0) < count then
                        enough = false
                    end
                end
                if enough then
                    state.ticks = state.ticks + 1
                    if state.ticks == process_ticks then
                        for item_name, count in pairs(recipe) do
                            state.stock[item_name] = state.stock[item_name] - count
                        end
                        state.ready = true
                    end
                end
            end

            if state.ready then
                local px, py, pz = M.port(x, y, z, true)
                local dx, dz = Utils.direction(x, y, z)
                if Conveyor.feed(px + dx, py, pz + dz, dx, dz, "gearbox") then
                    state.ready = false
                end
            end
        end
    end
end

function M.clear_process()
    processing = {}
end

local clear_models = M.clear
function M.clear()
    M.clear_process()
    clear_models()
end

return M
