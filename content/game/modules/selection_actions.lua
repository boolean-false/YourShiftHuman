local M = {}
local Hover = require("game:hover")
local Conveyor = require("game:conveyor")
local Press = require("game:press")
local Smelter = require("game:smelter")
local Assembler = require("game:assembler")

local controllers = {
    ["game:press"] = Press,
    ["game:smelter"] = Smelter,
    ["game:assembler"] = Assembler
}

local function selected()
    local object = Hover.selected
    if not object then
        return nil
    end
    if block.get(object.x, object.y, object.z) ~= object.id then
        Hover.clear_selection()
        return nil
    end
    local name = block.name(object.id)
    if name == "game:source" or name == "game:sink" then
        Hover.message = "Оборудование закреплено"
        return nil
    end
    return object
end

local function clear_flows()
    Conveyor.clear()
    Press.clear_process()
    Smelter.clear_process()
end

local function corner(object, rotation)
    local sx, _, sz = block.get_size(object.id)
    local rx, _, rz = block.get_X(object.id, rotation)
    local fx, _, fz = block.get_Z(object.id, rotation)
    return object.x + math.min(0, rx * (sx - 1)) + math.min(0, fx * (sz - 1)),
    object.z + math.min(0, rz * (sx - 1)) + math.min(0, fz * (sz - 1))
end

local function update_belts(object, rotation)
    local x, z = corner(object, rotation)
    local sx, _, sz = block.get_size(object.id)
    for dx = 0, sx - 1 do
        for dz = 0, sz - 1 do
            Conveyor.update_nearby(x + dx, object.y, z + dz)
        end
    end
end

local function can_rotate(object, x, z, rotation)
    local sx, sy, sz = block.get_size(object.id)
    local rx, _, rz = block.get_X(object.id, rotation)
    local fx, _, fz = block.get_Z(object.id, rotation)
    for dx = 0, sx - 1 do
        for dy = 0, sy - 1 do
            for dz = 0, sz - 1 do
                local px, py, pz = x + rx * dx + fx * dz, object.y + dy, z + rz * dx + fz * dz
                local id = block.get(px, py, pz)
                if id == -1 then
                    return false, "Чанк ещё не загружен"
                end
                local ox, oy, oz = block.seek_origin(px, py, pz)
                local own = id == object.id and ox == object.x and oy == object.y and oz == object.z
                if not own and not block.is_replaceable_at(px, py, pz) then
                    return false, "Недостаточно места"
                end
            end
        end
    end
    return true
end

function M.rotate(pid)
    local object = selected()
    if not object or block.get_rotation_profile(object.id) ~= "pane" then
        return
    end
    local old = block.get_rotation(object.x, object.y, object.z)
    local rotation = (old + 3) % 4
    local cx, cz = corner(object, old)
    local nx, nz = corner(object, rotation)
    local x, z = object.x + cx - nx, object.z + cz - nz
    local ok, why = can_rotate(object, x, z, rotation)
    if not ok then
        Hover.message = why;
        return
    end
    Hover.message = nil
    clear_flows()
    if x == object.x and z == object.z then
        block.set_rotation(x, object.y, z, rotation)
    else
        local controller = controllers[block.name(object.id)]
        if controller then
            controller.remove_model(object.x, object.y, object.z)
        end
        local state = block.get_states(object.x, object.y, object.z)
        block.set(object.x, object.y, object.z, block.index("core:air"), 0)
        block.place(x, object.y, z, object.id, state - old + rotation, pid)
    end
    update_belts(object, old)
    object.x, object.z = x, z
    update_belts(object, rotation)
end

return M
