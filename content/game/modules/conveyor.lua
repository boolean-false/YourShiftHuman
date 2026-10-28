local M = {}
local Press = require("game:press")
local Smelter = require("game:smelter")
local Assembler = require("game:assembler")
local Source = require("game:source")
local Products = require("game:products")
local Delivery = require("game:delivery")
local Utils = require("game:utils")
local Splitter = require("game:splitter")
local Merger = require("game:merger")
local Filter = require("game:filter")
local items = {}
local speed = 1.5 -- Блоков в сек

-- Станки принимают продукцию через свои порты.
local function processor_at(x, y, z)
    local id = block.get(x, y, z)

    if id == block.index(Press.block_name) then
        return Press
    end

    if id == block.index(Smelter.block_name) then
        return Smelter
    end

    if id == block.index(Assembler.block_name) then
        return Assembler
    end
end

-- Проверяем, что в этой клетке уже конвеер
local function is_belt(x, y, z)
    return block.get(x, y, z) == block.index("game:conveyor")
end

-- Все транспортные блоки используют общий список предметов.
local function is_transport(x, y, z)
    local id = block.get(x, y, z)
    return id == block.index("game:conveyor") or
            id == block.index("game:splitter") or
            id == block.index("game:merger") or
            id == block.index("game:filter")
end

-- Проверяем, подаёт ли сосед предметы в эту секцию.
local function feeds_from(x, y, z, offset_x, offset_z)
    local nx, nz = x + offset_x, z + offset_z
    local id = block.get(nx, y, nz)
    if id == -1 then
        return nil
    end
    if id == block.index("game:splitter") then
        return Splitter.is_output(nx, y, nz, -offset_x, -offset_z)
    elseif id == block.index("game:filter") then
        return Filter.is_output(nx, y, nz, -offset_x, -offset_z)
    elseif id == block.index(Source.block_name) then
        return Source.is_output(nx, y, nz, -offset_x, -offset_z)
    end
    local processor = processor_at(nx, y, nz)
    if processor then
        return processor.is_output(nx, y, nz, -offset_x, -offset_z)
    end
    if id ~= block.index("game:conveyor") and
            id ~= block.index("game:merger") then
        return false
    end
    return Utils.same_direction(nx, y, nz, -offset_x, -offset_z)
end

-- Вариант 0 - прямая, 1 - поворот налево, 2 0 направо.
function M.update_shape(x, y, z)
    if not is_belt(x, y, z) then
        return
    end
    local dx, dz = Utils.direction(x, y, z)
    local right_x, right_z = dz, -dx
    local behind = feeds_from(x, y, z, -dx, -dz)
    local right = feeds_from(x, y, z, right_x, right_z)
    local left = feeds_from(x, y, z, -right_x, -right_z)

    -- Не меняем сохранённую форму, пока соседний чанк ещё загружается
    if behind == nil or right == nil or left == nil then
        return
    end

    local variant = 0
    if not behind then
        -- Вход справа поворачивает поток налево, вход слева 0 направо
        if right and not left then
            variant = 1
        end
        if left and not right then
            variant = 2
        end
    end
    if block.get_variant(x, y, z) ~= variant then
        block.set_variant(x, y, z, variant)
    end
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

-- Есть ли у соседнего блока предмет, который он может передать в указанную сторону.
local function input_ready(x, y, z, dx, dz)
    local id = block.get(x, y, z)
    if id == -1 then
        return false
    end
    local points_here = Utils.same_direction(x, y, z, dx, dz)
    if id == block.index("game:source") then
        return Source.is_output(x, y, z, dx, dz)
    end
    local processor = processor_at(x, y, z)
    if processor then
        return processor.is_output(x, y, z, dx, dz) and processor.has_output(x, y, z)
    end
    if not is_transport(x, y, z) then
        return false
    end
    if id == block.index("game:splitter") then
        points_here = Splitter.is_output(x, y, z, dx, dz)
    elseif id == block.index("game:filter") then
        points_here = Filter.is_output(x, y, z, dx, dz)
    end
    if not points_here then
        return false
    end
    for _, belt_item in ipairs(items) do
        if belt_item.x == x and belt_item.y == y and belt_item.z == z then

            if id == block.index("game:filter") and
                    not Filter.is_output(x, y, z, dx, dz, belt_item.item_name) then
                return false
            end
            return belt_item.p == 0 or (belt_item.dx == dx and belt_item.dz == dz)
        end
    end
    return false
end

local function can_receive(x, y, z, dx, dz, item_name, except)
    local id = block.get(x, y, z)
    if id == -1 or is_busy(x, y, z, except) then
        return false
    end
    if id == block.index("game:conveyor") then
        return not Utils.opposite_direction(x, y, z, dx, dz)
    elseif id == block.index("game:splitter") then
        return Utils.same_direction(x, y, z, dx, dz)
    elseif id == block.index("game:filter") then
        return Filter.can_accept(x, y, z, dx, dz, item_name)
    elseif id == block.index("game:merger") then
        if not Merger.is_input(x, y, z, dx, dz) then
            return false
        end
        -- Уже начатый переезд не прерываем появлением предмета на другом входе.
        if except and except.p > 0 and except.x + except.dx == x and
                except.y == y and except.z + except.dz == z then
            return true
        end
        return Merger.can_accept(x, y, z, dx, dz, function(offset_x, offset_z)
            return input_ready(x + offset_x, y, z + offset_z, -offset_x, -offset_z)
        end)
    end
    local processor = processor_at(x, y, z)
    if processor then
        return processor.can_accept(x, y, z, dx, dz, item_name)
    end
    return id == block.index("game:sink")
end

-- Проверяем расположение входа
function M.is_input(x, y, z, dx, dz)
    local id = block.get(x, y, z)
    if id == -1 then
        return false
    end
    if id == block.index("game:sink") then
        return true
    end
    if id == block.index("game:merger") then
        return Merger.is_input(x, y, z, dx, dz)
    end
    if id == block.index("game:splitter") or id == block.index("game:filter") then
        return Utils.same_direction(x, y, z, dx, dz)
    end
    local processor = processor_at(x, y, z)
    if processor then
        return processor.is_input(x, y, z, dx, dz)
    end
    return false
end

-- Добавляем предмет, если секция свободна
function M.insert(x, y, z, item_name)
    if not Products[item_name] or not is_transport(x, y, z) or is_busy(x, y, z) then
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

-- Доставка и станки подают продукцию на свободную ленту.
function M.feed(x, y, z, dx, dz, item_name)
    if not is_transport(x, y, z) or not can_receive(x, y, z, dx, dz, item_name) then
        return false
    end
    local inserted = M.insert(x, y, z, item_name)
    if inserted and block.get(x, y, z) == block.index("game:merger") then
        Merger.received(x, y, z, dx, dz)
    end
    return inserted
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
        elseif not is_transport(x, y, z) then
            -- При сносе ленты убираем её продукцию вместе с моделью.
            remove_visual(belt_item)
            table.remove(items, i)
        else
            local dx, dz, side
            local from_splitter = id == block.index("game:splitter")
            if from_splitter then
                dx, dz, side = Splitter.choose_output(x, y, z, function(out_x, out_z)
                    return can_receive(x + out_x, y, z + out_z, out_x, out_z, belt_item.item_name, belt_item)
                end)
            elseif id == block.index("game:filter") then
                dx, dz = Filter.output(x, y, z, belt_item.item_name)
            else
                dx, dz = Utils.direction(x, y, z)
            end

            if not dx then
                -- Нет доступного выхода. Предмет остаётся в центре
                belt_item.p = 0
            else
                if dx ~= belt_item.dx or dz ~= belt_item.dz then
                    -- После поворота секции начинаем движение от центра
                    belt_item.p = 0
                end
                belt_item.dx, belt_item.dz = dx, dz
                local nx, nz = x + dx, z + dz

                if block.get(nx, y, nz) ~= -1 then
                    local is_sink = block.get(nx, y, nz) == block.index("game:sink")
                    local processor = processor_at(nx, y, nz)
                    local can_move = can_receive(nx, y, nz, dx, dz, belt_item.item_name, belt_item)
                    if can_move then
                        belt_item.p = belt_item.p + speed / 20 -- Расстояние за один тик
                        if belt_item.p >= 1 then
                            if from_splitter then
                                Splitter.sent(x, y, z, side)
                            end
                            if block.get(nx, y, nz) == block.index("game:merger") then
                                Merger.received(nx, y, nz, dx, dz)
                            end
                            if is_sink or processor then
                                if processor then
                                    processor.accept(nx, y, nz, belt_item.item_name)
                                elseif is_sink then
                                    Delivery.receive(belt_item.item_name)
                                end
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
end

-- рендер предметов на конвеере
function M.render()
    for _, belt_item in ipairs(items) do
        if is_transport(belt_item.x, belt_item.y, belt_item.z) then
            local position = {
                -- Экспорт VCM уже содержит сдвиг центра на .5 по X и Z.
                belt_item.x + belt_item.dx * belt_item.p,
                belt_item.y + .25,
                belt_item.z + belt_item.dz * belt_item.p
            }
            if not belt_item.entity or not entities.exists(belt_item.entity:get_uid()) then
                -- Если модель есть, то просто меняем её позицию. Иначе создаем модельку
                belt_item.entity = entities.spawn("game:belt_item", position)
                belt_item.entity.skeleton:set_model(0, Products[belt_item.item_name].model)
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
    Splitter.clear()
    Merger.clear()
end

return M
