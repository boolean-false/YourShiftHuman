local Machine = require("game:machine")

-- 0 - шестерёнка, 1 - вал.
local function product(x, y, z)
    if block.get_user_bits(x, y, z, 0, 1) == 1 then
        return "rod"
    end
    return "gear"
end

local M = Machine.create({
    block_name = "game:press",
    entity_name = "game:press_visual",
    recipes = { ingot = "gear" },
    get_output = product,
    process_ticks = 10,
    animation = "press_work"
})

function M.get_recipe(x, y, z)
    x, y, z = block.seek_origin(x, y, z)
    if block.get(x, y, z) ~= block.index(M.block_name) then
        return nil
    end
    return product(x, y, z)
end

function M.set_recipe(x, y, z, recipe)
    if recipe ~= "gear" and recipe ~= "rod" then
        return false
    end
    x, y, z = block.seek_origin(x, y, z)
    if block.get(x, y, z) ~= block.index(M.block_name) then
        return false
    end
    if product(x, y, z) == recipe then
        return false
    end
    block.set_user_bits(x, y, z, 0, 1, recipe == "rod" and 1 or 0)
    return true
end

return M
