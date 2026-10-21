local M = {}
local Utils = require("game:utils")

local presses = {}
local models = {}

-- рецепты. Пока тестово
local recipes = {
    ["base:red_lamp.item"] = "base:green_lamp.item"
}

local block_name = "game:press"
M.block_name = block_name

local function origin(x, y, z)
    return block.seek_origin(x, y, z)
end

function M.port(x, y, z, output)
    x, y, z = origin(x, y, z)
    if block.get(x, y, z) ~= block.index(block_name) then
        return nil
    end
    local right_x, _, right_z = block.get_X(x, y, z)
    local dx, dz = Utils.direction(x, y, z)
    return x + right_x + (output and dx or 0), y,
    z + right_z + (output and dz or 0)
end

function M.is_output(x, y, z, dx, dz)
    local px, py, pz = M.port(x, y, z, true)
    local ox, oy, oz = origin(x, y, z)
    return x == px and y == py and z == pz and Utils.same_direction(ox, oy, oz, dx, dz)
end

-- пресс принимает один исходный предмет сзади
function M.can_accept(x, y, z, dx, dz, item_name)
    local ox, oy, oz = origin(x, y, z)
    local px, py, pz = M.port(x, y, z, false)
    if x ~= px or y ~= py or z ~= pz or presses[Utils.key(ox, oy, oz)] or not recipes[item_name] then
        return false
    end

    return Utils.same_direction(ox, oy, oz, dx, dz)
end

-- Сохраняем предмет внутри пресса и начинаем обработку.
function M.accept(x, y, z, item_name)
    x, y, z = origin(x, y, z)
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

-- Объединитель учитывает пресс в очереди только после завершения обработки.
function M.has_output(x, y, z)
    local px, py, pz = M.port(x, y, z, true)
    local ox, oy, oz = origin(x, y, z)
    local press = presses[Utils.key(ox, oy, oz)]
    return x == px and y == py and z == pz and press ~= nil and press.ticks == process_ticks
end

-- Создаём одну модель на весь станок, а не на каждый его сегмент.
function M.register(x, y, z)
    if block.get(x, y, z) ~= block.index(block_name) or block.is_segment(x, y, z) then
        return
    end
    local key = Utils.key(x, y, z)
    if not models[key] then
        models[key] = { x = x, y = y, z = z }
    end
end

-- Убираем модель при удалении блока или выгрузке чанка.
function M.remove_model(x, y, z)
    local key = Utils.key(x, y, z)
    local model = models[key]
    if model and model.entity and entities.exists(model.entity:get_uid()) then
        model.entity:despawn()
    end
    models[key] = nil
end

-- Обрабатываем предмет и ждём свободную ленту
function M.tick()
    -- Получаем модуль здесь, чтобы конвеер и пресс не дергали друг друга по кругу)))
    local Conveyor = require("game:conveyor")
    for _, model in pairs(models) do
        if block.get(model.x, model.y, model.z) ~= block.index(block_name) then
            M.remove_model(model.x, model.y, model.z)
        end
    end
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
                local px, py, pz = M.port(x, y, z, true)
                -- Готовый предмет ждёт внутри, пока выход не освободится
                if Conveyor.feed(px + dx, py, pz + dz, dx, dz, press.item_name) then
                    presses[position] = nil
                end
            end
        end
    end
end

-- Рендерим
function M.render()
    for key, model in pairs(models) do
        local x, y, z = model.x, model.y, model.z
        if block.get(x, y, z) == block.index(block_name) then
            local right_x, _, right_z = block.get_X(x, y, z)
            local dx, dz = Utils.direction(x, y, z)
            local position = { x + .5 + (right_x + dx) / 2, y + .5, z + .5 + (right_z + dz) / 2 }
            if not model.entity or not entities.exists(model.entity:get_uid()) then
                model.entity = entities.spawn("game:press_visual", position)
                model.entity.skeleton:set_interpolated(false)
            end
            model.entity.transform:set_pos(position)

            model.entity.transform:set_rot(mat4.rotate(
                    { 0, 1, 0 },
                    block.get_rotation(x, y, z) * 90 - 90
            ))
            model.entity.skeleton:reset_pose()
            local press = presses[key]
        end
    end
end

-- Пока не сохраняем предметы и обработку между входами в мир.
function M.clear()
    for _, model in pairs(models) do
        M.remove_model(model.x, model.y, model.z)
    end
    models = {}
    presses = {}
end

return M
