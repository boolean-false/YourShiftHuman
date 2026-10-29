local Hover = require("game:hover")
local Conveyor = require("game:conveyor")
local Actions = require("game:selection_actions")
local Utils = require("game:utils")
local Mission = require("game:mission")
local Room = require("game:room")

local M = {
    rotation = 1,
    path = {}
}

M.tools = {
    "game:conveyor",
    "game:splitter",
    "game:merger",
    "game:filter"
}

local rotations = { 1, 0, 3, 2 }

function M.cancel_path()
    M.path = {}
    M.reason = nil
    M.down = input.is_pressed("mouse:left")
end

function M.cancel()
    M.tool = nil
    M.message = nil
    M.cancel_path()
end

function M.choose(index)
    if hud.is_paused() or menu.page ~= "" then
        return
    end
    if not Mission.available(M.tools[index]) then
        Hover.message = "Этот транспорт недоступен в задании"
        return
    end
    if M.tool == index then
        M.tool = nil
    else
        M.tool = index
    end
    M.message = nil
    M.cancel_path()
    Hover.clear_selection()
end

function M.rotate()
    M.rotation = (M.rotation + 3) % 4
    M.cancel_path()
end

function M.caption()
    if not M.tool then
        return ""
    end
    local caption = block.caption(block.index(M.tools[M.tool]))
    local message = M.message or M.reason
    if message then
        caption = caption .. " · " .. message
    end
    return caption
end

-- Проверяем весь путь до изменения мира, чтоб не строить его частично
local function can_place(cells)
    if not Mission.available(M.tools[M.tool]) then
        return false, "Этот транспорт недоступен в задании"
    end
    local belt = block.index(M.tools[1])
    local seen = {}
    for i, cell in ipairs(cells) do
        if not Room.contains(cell.x, cell.y, cell.z) then
            return false, "За пределами"
        end
        local key = Utils.key(cell.x, cell.y, cell.z)
        if seen[key] then
            return false, "Маршрут пересекает сам себя"
        end
        seen[key] = true

        if i > 1 then
            local previous = cells[i - 1]
            if cell.y ~= previous.y or math.abs(cell.x - previous.x) + math.abs(cell.z - previous.z) ~= 1 then
                return false, "Лента должна быть непрерывной"
            end
        end
        local id = block.get(cell.x, cell.y, cell.z)
        local floor = block.get(cell.x, cell.y - 1, cell.z)
        if id == -1 or floor == -1 then
            return false, "Чанк ещё не загружен"
        end
        if not block.is_solid_at(cell.x, cell.y - 1, cell.z) then
            return false, "Под блоком нужен пол"
        end
        local existing_belt = M.tool == 1 and id == belt
        if not existing_belt and not block.is_replaceable_at(cell.x, cell.y, cell.z) then
            return false, "Место занято оборудованием"
        end
    end
    return true
end

-- Каждая секция смотрит к следующей. Последняя ищет вход станка.
local function path_rotations(cells)
    local result = {}
    local belt = block.index(M.tools[1])
    for i, cell in ipairs(cells) do
        local next_cell = cells[i + 1]
        local previous = cells[i - 1]
        local existing = block.get(cell.x, cell.y, cell.z) == belt
        local rotation = M.rotation
        local dx, dz = 0, 0
        if next_cell then
            dx, dz = next_cell.x - cell.x, next_cell.z - cell.z
        elseif existing then
            rotation = block.get_rotation(cell.x, cell.y, cell.z)
        elseif previous then
            dx, dz = cell.x - previous.x, cell.z - previous.z
        end
        if dx > 0 then
            rotation = 1
        elseif dx < 0 then
            rotation = 3
        elseif dz > 0 then
            rotation = 0
        elseif dz < 0 then
            rotation = 2
        end

        if not next_cell and not existing then
            local count, port_rotation = 0, rotation
            for _, turn in ipairs(rotations) do
                local fx, _, fz = block.get_Z(belt, turn)
                if Conveyor.is_input(cell.x + fx, cell.y, cell.z + fz, fx, fz) then
                    count = count + 1
                    port_rotation = turn
                end
            end
            if count == 1 then
                rotation = port_rotation
            end
        end
        result[i] = rotation
    end
    return result
end

local function commit(cells, pid)
    local ok, why = can_place(cells)
    if not ok then
        M.message = why;
        return
    end
    local id = block.index(M.tools[M.tool])
    local turns = M.tool == 1 and path_rotations(cells) or { M.rotation }
    local changed = false
    for i, cell in ipairs(cells) do
        if block.get(cell.x, cell.y, cell.z) ~= id or block.get_rotation(cell.x, cell.y, cell.z) ~= turns[i] then
            changed = true
            break
        end
    end
    if not changed then
        return
    end
    Actions.clear_flows()
    for i, cell in ipairs(cells) do
        if block.get(cell.x, cell.y, cell.z) == id then
            block.set_rotation(cell.x, cell.y, cell.z, turns[i])
        else
            block.place(cell.x, cell.y, cell.z, id, turns[i], pid)
        end
    end

    for _, cell in ipairs(cells) do
        Conveyor.update_nearby(cell.x, cell.y, cell.z)
    end
    M.message = nil
end

local function extend(cell)
    local last = M.path[#M.path]
    if not last then
        M.path[1] = { x = cell.x, y = cell.y, z = cell.z }
        return
    end
    local steps = 0
    while (last.x ~= cell.x or last.z ~= cell.z) and steps < 64 do
        steps = steps + 1
        local x, z = last.x, last.z
        if math.abs(cell.x - x) >= math.abs(cell.z - z) then
            x = x + (cell.x > x and 1 or -1)
        else
            z = z + (cell.z > z and 1 or -1)
        end
        local previous = M.path[#M.path - 1]
        if previous and previous.x == x and previous.z == z then
            table.remove(M.path)
        else
            M.path[#M.path + 1] = { x = x, y = cell.y, z = z }
        end
        last = M.path[#M.path]
    end
end

function M.pointer(cell, down, blocked, pid)
    local clicked = down and not M.down
    local released = not down and M.down
    M.down = down
    if not M.tool then
        return
    end
    if not blocked and cell then
        if M.tool == 1 then
            if clicked then
                M.message = nil;
                M.cancel_path()
            end
            if down and (clicked or #M.path > 0) then
                extend(cell)
            end
        elseif clicked then
            M.message = nil
            commit({ cell }, pid)
        end
    end
    if released and #M.path > 0 then
        if not blocked then
            commit(M.path, pid)
        end
        M.cancel_path()
    end
end

function M.preview(cell)
    if not M.tool or not cell then
        return
    end
    local cells = #M.path > 0 and M.path or { cell }
    local ok, why = can_place(cells)
    M.reason = why
    Hover.preview(cells, M.rotation, ok)
end

return M
