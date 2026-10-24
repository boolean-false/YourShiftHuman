local M = {}
local Camera = require("game:camera")
local cursor

local sizes = {
    ["game:source"] = 1,
    ["game:conveyor"] = 1,
    ["game:sink"] = 1,
    ["game:splitter"] = 1,
    ["game:merger"] = 1,
    ["game:filter"] = 1,
    ["game:press"] = 2,
    ["game:smelter"] = 2,
    ["game:assembler"] = 2
}

local function object_at(x, y, z)
    local id = block.get(x, y, z)
    if id == -1 or not sizes[block.name(id)] then
        return nil
    end
    x, y, z = block.seek_origin(x, y, z)
    return {
        x = x,
        y = y,
        z = z,
        id = id
    }
end

function M.clear_selection()
    M.selected = nil
    M.message = nil
end

function M.caption()
    local caption = M.selected and block.caption(M.selected.id) or "Ничего не выбрано"
    return caption .. (M.message and " · " .. M.message or "")
end

function M.hide()
    M.cell = nil
    if cursor and entities.exists(cursor:get_uid()) then
        cursor.skeleton:set_visible(false)
    end
end

-- Наводимся на клетку пола
function M.update(clicked)
    if M.selected and block.get(M.selected.x, M.selected.y, M.selected.z) ~= M.selected.id then
        M.clear_selection()
    end
    local mouse = input.get_mouse_pos()
    local x, z = Camera.ray(mouse[1], mouse[2], .23)
    if not x then
        M.hide();
        return
    end
    x, z = math.floor(x), math.floor(z)
    local y = Camera.y
    local id = block.get(x, y, z)
    if id == -1 then
        M.hide();
        return
    end
    M.cell = { x = x, y = y, z = z }

    if clicked then
        M.message = nil
        M.selected = object_at(x, y, z)
    end
    if M.selected then
        x, y, z = M.selected.x, M.selected.y, M.selected.z
        id = M.selected.id
    end

    local size, rotation = 1, 0
    if block.name(id):sub(1, 5) == "game:" then
        x, y, z = block.seek_origin(x, y, z)
        size = sizes[block.name(id)] or 1
        rotation = block.get_rotation(x, y, z)
    end
    local right_x, _, right_z = block.get_X(x, y, z)
    local dx, _, dz = block.get_Z(x, y, z)
    local half = (size - 1) / 2
    local position = { x + .5 + (right_x + dx) * half, Camera.y + .8, z + .5 + (right_z + dz) * half }
    if not cursor or not entities.exists(cursor:get_uid()) then
        cursor = entities.spawn("game:build_cursor", position)
        cursor.skeleton:set_interpolated(false)
        cursor.skeleton:set_color({ .5, 1.8, 1.4 })
    end
    cursor.skeleton:set_visible(true)
    cursor.transform:set_pos(position)
    cursor.transform:set_size({ size, 1, size })
    cursor.transform:set_rot(mat4.rotate({ 0, 1, 0 }, rotation * 90 - 90))
end

function M.close()
    if cursor and entities.exists(cursor:get_uid()) then
        cursor:despawn()
    end
    cursor = nil
    M.cell = nil
    M.clear_selection()
end

return M
