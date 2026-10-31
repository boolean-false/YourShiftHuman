local M = {}
local Press = require("game:press")
local Smelter = require("game:smelter")
local Assembler = require("game:assembler")
local Source = require("game:source")
local Products = require("game:products")
local Delivery = require("game:delivery")
local Room = require("game:room")
local Utils = require("game:utils")
local Splitter = require("game:splitter")
local Merger = require("game:merger")
local Filter = require("game:filter")
local Sink = require("game:sink")
local items = {}
local speed = 4 -- Блоков в сек

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

-- У каждой секции свой предмет, соседнюю заранее не занимаем
local function is_busy(x, y, z, except)
    for _, belt_item in ipairs(items) do
        if belt_item ~= except and belt_item.y == y then
            if belt_item.x == x and belt_item.z == z then
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
        return Source.is_output(x, y, z, dx, dz) and Source.has_output(x, y, z)
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
            return belt_item.p >= 1
        end
    end
    return false
end

local function can_receive(x, y, z, dx, dz, item_name, except)
    if not Room.contains(x, y, z) then
        return false
    end
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
        return Merger.can_accept(x, y, z, dx, dz, function(offset_x, offset_z)
            return input_ready(x + offset_x, y, z + offset_z, -offset_x, -offset_z)
        end)
    end
    local processor = processor_at(x, y, z)
    if processor then
        return processor.can_accept(x, y, z, dx, dz, item_name)
    end
    return id == block.index("game:sink") and Sink.can_accept(x, y, z, item_name)
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
        dz = 0, -- dx, dz - направление заезда на эту секцию
        p = 1, -- путь от предыдущей секции до центра этой
    }

    return true
end

-- Доставка и станки подают продукцию на свободную ленту.
function M.feed(x, y, z, dx, dz, item_name, visual)
    if not is_transport(x, y, z) or not can_receive(x, y, z, dx, dz, item_name) then
        return false
    end
    local inserted = M.insert(x, y, z, item_name)
    if inserted then
        local belt_item = items[#items]
        belt_item.dx, belt_item.dz, belt_item.p = dx, dz, 0
        if visual then
            belt_item.entity = visual.entity
            belt_item.start_x, belt_item.start_z = visual.x, visual.z
        end
    end
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

-- Сначала все доезжают до центра своих секций
function M.tick()
    for i = #items, 1, -1 do
        local belt_item = items[i]
        local x, y, z = belt_item.x, belt_item.y, belt_item.z
        local id = block.get(x, y, z)
        if id ~= -1 and not is_transport(x, y, z) then
            remove_visual(belt_item)
            table.remove(items, i)
        elseif id ~= -1 and Room.contains(x, y, z) then
            belt_item.p = math.min(1, belt_item.p + speed / 20)
        end
    end

    -- Решаем передачи вместе, чтобы порядок предметов не менял темп линии
    local moves, reserved = {}, {}
    for _, belt_item in ipairs(items) do
        local x, y, z = belt_item.x, belt_item.y, belt_item.z
        if belt_item.p >= 1 and Room.contains(x, y, z) and is_transport(x, y, z) then
            local function can_send(dx, dz)
                return not reserved[Utils.key(x + dx, y, z + dz)] and
                    can_receive(x + dx, y, z + dz, dx, dz, belt_item.item_name, belt_item)
            end
            local id = block.get(x, y, z)
            local dx, dz, slot
            local from_splitter = id == block.index("game:splitter")
            if from_splitter then
                dx, dz, slot = Splitter.choose_output(x, y, z, can_send)
            elseif id == block.index("game:filter") then
                dx, dz = Filter.output(x, y, z, belt_item.item_name)
            else
                dx, dz = Utils.direction(x, y, z)
            end
            if dx and can_send(dx, dz) then
                local nx, nz = x + dx, z + dz
                reserved[Utils.key(nx, y, nz)] = true
                moves[#moves + 1] = {
                    item = belt_item, x = nx, y = y, z = nz, dx = dx, dz = dz,
                    splitter = from_splitter, slot = slot
                }
            end
        end
    end

    for _, move in ipairs(moves) do
        local belt_item = move.item
        local x, y, z = move.x, move.y, move.z
        local processor = processor_at(x, y, z)
        -- Два входа сборщика могут одновременно принести один и тот же ресурс
        if not processor or processor.can_accept(x, y, z, move.dx, move.dz, belt_item.item_name) then
            if move.splitter then
                Splitter.sent(belt_item.x, belt_item.y, belt_item.z, move.slot)
            end
            if block.get(x, y, z) == block.index("game:merger") then
                Merger.received(x, y, z, move.dx, move.dz)
            end
            if processor then
                if processor.accept(x, y, z, belt_item.item_name, belt_item) then
                    belt_item.entity = nil
                end
                belt_item.delivered = true
            elseif block.get(x, y, z) == block.index("game:sink") then
                Delivery.receive(belt_item.item_name)
                belt_item.delivered = true
            else
                belt_item.x, belt_item.z, belt_item.p = x, z, 0
                belt_item.start_x, belt_item.start_z = nil, nil
                belt_item.dx, belt_item.dz = move.dx, move.dz
            end
        end
    end
    for i = #items, 1, -1 do
        if items[i].delivered then
            remove_visual(items[i])
            table.remove(items, i)
        end
    end
end

-- рендер предметов на конвеере
function M.render()
    for _, belt_item in ipairs(items) do
        if is_transport(belt_item.x, belt_item.y, belt_item.z) then
            local position = {
                -- Экспорт VCM уже содержит сдвиг центра на .5 по X и Z.
                belt_item.x - belt_item.dx * (1 - belt_item.p),
                belt_item.y + .25,
                belt_item.z - belt_item.dz * (1 - belt_item.p)
            }
            if belt_item.start_x then
                position[1] = belt_item.start_x + (belt_item.x - belt_item.start_x) * belt_item.p
                position[3] = belt_item.start_z + (belt_item.z - belt_item.start_z) * belt_item.p
            end
            if not belt_item.entity or not entities.exists(belt_item.entity:get_uid()) then
                -- Если модель есть, то просто меняем её позицию. Иначе создаем модельку
                belt_item.entity = entities.spawn("game:belt_item", position)
            end
            belt_item.entity.skeleton:set_visible(true)
            belt_item.entity.skeleton:set_model(0, Products[belt_item.item_name].model)
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
