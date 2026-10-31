local Products = require("game:products")
local Session = require("game:session")
local Machine = require("game:machine")
local M = Machine.create({
    block_name = "game:sink",
    entity_name = "game:sink_visual",
    size = 1
})

function M.remove(x, y, z)
    M.remove_model(x, y, z)
end

M.types = { "all", "ore", "ingot", "gear", "rod", "gearbox" }

function M.get_type(x, y, z)
    local index = block.get_user_bits(x, y, z, 0, 3) + 1
    return M.types[index] and index or 1
end

function M.caption(index)
    local item_name = M.types[index]
    return item_name == "all" and "Всё" or Products[item_name].caption
end

--  0 берет всё
function M.set_type(x, y, z, index)
    if not Session.editing or not M.types[index] or block.get(x, y, z) ~= block.index("game:sink") then
        return false
    end
    if M.get_type(x, y, z) == index then
        return false
    end
    block.set_user_bits(x, y, z, 0, 3, index - 1)
    return true
end

function M.can_accept(x, y, z, item_name)
    if not Products[item_name] then
        return false
    end
    local wanted = M.types[M.get_type(x, y, z)]
    return wanted == "all" or wanted == item_name
end

return M
