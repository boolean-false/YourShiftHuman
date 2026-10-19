local M = {}

local presses = {}

local function key(x, y, z)
    return string.format("%d:%d:%d", x, y, z)
end

-- рецепты. Пока тестово
local recipes = {
    ["base:red_lamp.item"] = "base:green_lamp.item"
}

local block_name = "game:press"
M.block_name = block_name

-- пресс принимает один исходный предмет сзади
function M.can_accept(x, y, z, dx, dz, item_name)
    if not recipes[item_name] then
        return false
    end

    local press_dx, _, press_dz = block.get_Z(x, y, z)
    return press_dx == dx and press_dz == dz
end

-- Сохраняем предмет внутри пресса и начинаем обработку.
function M.accept(x, y, z, item_name)
    presses[key(x, y, z)] = {
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
            entities.spawn("base:drop", {x + .5, y + .5, z + .5}, {
                base__drop = {item = press.item_name, count = 1}
            })
            presses[position] = nil
        else
            if press.ticks < process_ticks then
                press.ticks = press.ticks + 1
                if press.ticks == process_ticks then
                    press.item_name = press.output
                end
            end
            if press.ticks == process_ticks then
                local dx, _, dz = block.get_Z(x, y, z)
                local nx, nz = x + dx, z + dz
                if block.get(nx, y, nz) == block.index("game:conveyor") then
                    local next_dx, _, next_dz = block.get_Z(nx, y, nz)
                    -- Готовый предмет ждёт внутри, пока выходная лента не освободится.
                    if not (next_dx == -dx and next_dz == -dz) and
                            Conveyor.insert(nx, y, nz, press.item_name) then
                        presses[position] = nil
                    end
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
