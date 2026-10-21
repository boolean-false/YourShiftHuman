local M = {}
local Utils = require("game:utils")
local models = {}
local block_name = "game:assembler"

function M.register(x, y, z)
    if block.get(x, y, z) ~= block.index(block_name) or block.is_segment(x, y, z) then
        return
    end
    local key = Utils.key(x, y, z)
    if not models[key] then
        models[key] = { x = x, y = y, z = z }
    end
end

-- Убираем сущность вместе с блоком
function M.remove_model(x, y, z)
    local key = Utils.key(x, y, z)
    local model = models[key]
    if model and model.entity and entities.exists(model.entity:get_uid()) then
        model.entity:despawn()
    end
    models[key] = nil
end

function M.render()
    for _, model in pairs(models) do
        local x, y, z = model.x, model.y, model.z
        if block.get(x, y, z) ~= block.index(block_name) then
            M.remove_model(x, y, z)
        else
            local right_x, _, right_z = block.get_X(x, y, z)
            local dx, dz = Utils.direction(x, y, z)
            local position = { x + .5 + (right_x + dx) / 2, y + .5, z + .5 + (right_z + dz) / 2 }
            if not model.entity or not entities.exists(model.entity:get_uid()) then
                model.entity = entities.spawn("game:assembler_visual", position)
                model.entity.skeleton:set_interpolated(false)
            end
            model.entity.transform:set_pos(position)
            model.entity.transform:set_rot(mat4.rotate({ 0, 1, 0 }, block.get_rotation(x, y, z) * 90 - 90))
        end
    end
end

function M.clear()
    for _, model in pairs(models) do
        M.remove_model(model.x, model.y, model.z)
    end
    models = {}
end

return M
