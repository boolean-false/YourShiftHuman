local M = {}
local Press = require("game:press")
local Utils = require("game:utils")
local items = {}
local speed = 1.5 -- Блоков в сек
local item_size = .5 -- Видимый размер предмета в блоках.

-- Проверяем, что в этой клетке уже конвеер
local function is_belt(x, y, z)
    return block.get(x, y, z) == block.index("game:conveyor")
end

-- Проверяем, подаёт ли сосед предметы в эту секцию.
local function feeds_from(x, y, z, offset_x, offset_z)
    local nx, nz = x + offset_x, z + offset_z
    local id = block.get(nx, y, nz)
    if id == -1 then return nil end
    if id ~= block.index("game:conveyor") and
            id ~= block.index("game:source") and
            id ~= block.index(Press.block_name) then
        return false
    end
    return Utils.same_direction(nx, y, nz, -offset_x, -offset_z)
end

-- Вариант 0 - прямая, 1 - поворот налево, 2 0 направо.
function M.update_shape(x, y, z)
    if not is_belt(x, y, z) then return end
    local dx, dz = Utils.direction(x, y, z)
    local right_x, right_z = dz, -dx
    local behind = feeds_from(x, y, z, -dx, -dz)
    local right = feeds_from(x, y, z, right_x, right_z)
    local left = feeds_from(x, y, z, -right_x, -right_z)

    -- Не меняем сохранённую форму, пока соседний чанк ещё загружается
    if behind == nil or right == nil or left == nil then return end

    local variant = 0
    if not behind then
        -- Вход справа поворачивает поток налево, вход слева 0 направо
        if right and not left then variant = 1 end
        if left and not right then variant = 2 end
    end
    if block.get_variant(x, y, z) ~= variant then block.set_variant(x, y, z, variant) end
end

-- После поворота обновляем также секции, которые соединены с этим блоком
function M.update_nearby(x, y, z)
    M.update_shape(x, y, z)
    M.update_shape(x + 1, y, z)
    M.update_shape(x - 1, y, z)
    M.update_shape(x, y, z + 1)
    M.update_shape(x, y, z - 1)
end

-- Пока предмет едет, обе секции считаем занятыми
local function is_busy(x, y, z, except)
    for _, belt_item in ipairs(items) do
        if belt_item ~= except and belt_item.y == y then
            if belt_item.x == x and belt_item.z == z then
                return true
            end

            if belt_item.p > 0 and belt_item.x + belt_item.dx == x and belt_item.z + belt_item.dz == z then
                return true
            end
        end
    end
    return false
end

-- Добавляем предмет, если секция свободна
function M.insert(x, y, z, item_name)
    if not is_belt(x, y, z) or is_busy(x, y, z) then
        return false
    end

    items[#items + 1] = {
        x = x,
        y = y,
        z = z,
        item_name = item_name,
        dx = 0,
        dz = 0, -- dx, dz - направление движения к след секции
        p = 0, -- путь от центра секции до следующей от 0 до 1
    }

    return true
end

local function remove_visual(belt_item)
    if belt_item.entity and entities.exists(belt_item.entity:get_uid()) then
        belt_item.entity:despawn()
    end
    belt_item.entity = nil
end

-- Двигаем предметы ТПС у нас 20, поэтому вызывается 20 раз в сек
function M.tick()
    for i = #items, 1, -1 do
        local belt_item = items[i]
        local x, y, z = belt_item.x, belt_item.y, belt_item.z
        local id = block.get(x, y, z)
        if id == -1 then
            -- при -1 чанк выгружен, поэтому стоим и не рыпаемся
        elseif not is_belt(x, y, z) then
            -- отлавливаем, что конвеер сломан и дропнем предмет
            Utils.drop_item(x, y, z, belt_item.item_name)
            remove_visual(belt_item)
            table.remove(items, i)
        else
            local dx, dz = Utils.direction(x, y, z)
            if dx ~= belt_item.dx or dz ~= belt_item.dz then
                -- После поворота секции начинаем движение от центра
                belt_item.p = 0
            end
            belt_item.dx, belt_item.dz = dx, dz
            local nx, nz = x + dx, z + dz

            if block.get(nx, y, nz) ~= -1 then
                local is_sink = block.get(nx, y, nz) == block.index("game:sink")
                local is_press = block.get(nx, y, nz) == block.index(Press.block_name)

                -- приемщик забирает предмет с любой стороны, лента передаёт дальше TODO костылище (временно)
                local can_move = (is_belt(nx, y, nz) or is_sink or is_press) and not is_busy(nx, y, nz, belt_item)

                if can_move and is_press then
                    can_move = Press.can_accept(nx, y, nz, dx, dz, belt_item.item_name)
                elseif can_move and not is_sink then
                    -- след секция принимает предмет сзади или сбоку
                    can_move = not Utils.opposite_direction(nx, y, nz, dx, dz)
                end
                if can_move then
                    belt_item.p = belt_item.p + speed / 20 -- Расстояние за один тик
                    if belt_item.p >= 1 then
                        if is_sink or is_press then -- TODO костылище (временно)
                            if is_press then Press.accept(nx, y, nz, belt_item.item_name) end
                            remove_visual(belt_item)
                            table.remove(items, i)
                        else
                            -- доводим до центра следующей секции, затем следуем по её направлению
                            belt_item.x, belt_item.z, belt_item.p = nx, nz, 0
                        end
                    end
                else
                    belt_item.p = 0
                end
            end
        end
    end
end

-- рендер предметов на конвеере
function M.render()
    for _, belt_item in ipairs(items) do
        if is_belt(belt_item.x, belt_item.y, belt_item.z) then
            local position = {
                belt_item.x + .5 + belt_item.dx * belt_item.p,
                belt_item.y + .25 + item_size / 2,
                belt_item.z + .5 + belt_item.dz * belt_item.p
            }
            if not belt_item.entity or not entities.exists(belt_item.entity:get_uid()) then
                -- Если модель есть, то просто меняем её позицию. Иначе создаем модельку
                belt_item.entity = entities.spawn("game:belt_item", position)
                belt_item.entity.skeleton:set_model(0, item.model_name(item.index(belt_item.item_name)))
                local scale = item_size / .2
                belt_item.entity.transform:set_size({ scale, scale, scale })
            end
            belt_item.entity.transform:set_pos(position)
        else
            remove_visual(belt_item)
        end
    end
end

-- Пока что чистим просто при выходе из мира всю инфу и визуал
function M.clear()
    for _, belt_item in ipairs(items) do
        remove_visual(belt_item)
    end
    items = {}
end

return M
