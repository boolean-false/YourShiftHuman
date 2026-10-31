local Products = require("game:products")
local M = {}

function M.create(item_name, belt_item, x, z)
    return {
        item_name = item_name, entity = belt_item and belt_item.entity,
        x = belt_item and belt_item.x or x,
        z = belt_item and belt_item.z or z, age = 0
    }
end

function M.move(item, x, z)
    local dx, dz = x - item.x, z - item.z
    local distance = math.sqrt(dx * dx + dz * dz)
    if distance > 0 then
        local step = math.min(1, .2 / distance)
        item.x, item.z = item.x + dx * step, item.z + dz * step
    end
    item.age = item.age + 1
end

function M.render(item, y, visible)
    local position = { item.x, y + .25, item.z }
    if not item.entity or not entities.exists(item.entity:get_uid()) then
        item.entity = entities.spawn("game:belt_item", position)
    end
    item.entity.skeleton:set_visible(visible)
    item.entity.skeleton:set_model(0, Products[item.item_name].model)
    item.entity.transform:set_pos(position)
end

function M.remove(item)
    if item and item.entity and entities.exists(item.entity:get_uid()) then
        item.entity:despawn()
    end
end

function M.clear(state)
    M.remove(state.item)
    for _, item in ipairs(state.queue or {}) do M.remove(item) end
end

return M
