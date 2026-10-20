local M = {}
local Utils = require("game:utils")

local presses = {}

-- рецепты. Пока тестово
local recipes = {
    ["base:red_lamp.item"] = "base:green_lamp.item"
}

local block_name = "game:press"
M.block_name = block_name

-- пресс принимает один исходный предмет сзади
function M.can_accept(x, y, z, dx, dz, item_name)
    if presses[Utils.key(x, y, z)] or not recipes[item_name] then
        return false
    end

    return Utils.same_direction(x, y, z, dx, dz)
end

-- Сохраняем предмет внутри пресса и начинаем обработку.
function M.accept(x, y, z, item_name)
    presses[Utils.key(x, y, z)] = {
        x = x,
        y = y,
        z = z,
        item_name = item_name,
        output = recipes[item_name],
        ticks = 0
    }
end

local process_ticks = 40 -- Обработка 40 тиков ~ 2 сек
function M.tick()
    -- Получаем модуль здесь, чтобы конвеер и пресс не дергали друг друга по кругу)))
    local Conveyor = require("game:conveyor")
    for position, press in pairs(presses) do
        local x, y, z = press.x, press.y, press.z
        local id = block.get(x, y, z)
        if id == -1 then
            -- Чанк выгружен
        elseif id ~= block.index(block_name) then
            -- При сносе возвращаем предмет, который находился внутри.
            Utils.drop_item(x, y, z, press.item_name)
            presses[position] = nil
        else
            if press.ticks < process_ticks then
                press.ticks = press.ticks + 1
                if press.ticks == process_ticks then
                    press.item_name = press.output
                end
            end
            if press.ticks == process_ticks then
                local dx, dz = Utils.direction(x, y, z)
                local nx, nz = x + dx, z + dz
                -- Готовый предмет ждёт внутри, пока выход не освободится
                if Conveyor.feed(nx, y, nz, dx, dz, press.item_name) then
                    presses[position] = nil
                end
            end
        end
    end
end

-- Пока не сохраняем предметы и обработку между входами в мир.
function M.clear()
    presses = {}
end

return M
