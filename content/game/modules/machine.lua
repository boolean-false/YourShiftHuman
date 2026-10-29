local Utils = require("game:utils")
local Room = require("game:room")
local M = {}

function M.create(config)
    local machine = { block_name = config.block_name }
    local models = {}
    local processing = {}
    local size = config.size or 2
    local recipes = config.recipes or {}
    local process_ticks = config.process_ticks or 20
    local function state_at(x, y, z)
        if config.get_process then
            return config.get_process(x, y, z)
        end
        return processing[Utils.key(x, y, z)]
    end

    -- Координаты порта считаем от главного блока с учётом поворота
    function machine.port(x, y, z, output, second)
        x, y, z = block.seek_origin(x, y, z)
        if block.get(x, y, z) ~= block.index(config.block_name) then
            return nil
        end
        local right_x, _, right_z = block.get_X(x, y, z)
        local dx, dz = Utils.direction(x, y, z)
        local side = second and 0 or size - 1
        local forward = output and size - 1 or 0
        return x + right_x * side + dx * forward, y, z + right_z * side + dz * forward
    end

    function machine.is_input(x, y, z, dx, dz)
        local ox, oy, oz = block.seek_origin(x, y, z)

        if not Utils.same_direction(ox, oy, oz, dx, dz) then
            return false
        end

        local px, py, pz = machine.port(x, y, z, false)

        if x == px and y == py and z == pz then
            return true
        end

        if config.two_inputs then
            px, py, pz = machine.port(x, y, z, false, true)
            return x == px and
                    y == py and
                    z == pz
        end

        return false
    end

    function machine.is_output(x, y, z, dx, dz)
        local px, py, pz = machine.port(x, y, z, true)
        local ox, oy, oz = block.seek_origin(x, y, z)
        return x == px and y == py and z == pz and Utils.same_direction(ox, oy, oz, dx, dz)
    end

    function machine.can_accept(x, y, z, dx, dz, item_name)
        local ox, oy, oz = block.seek_origin(x, y, z)
        if not Room.contains(ox, oy, oz) then
            return false
        end
        local px, py, pz = machine.port(x, y, z, false)
        local state = processing[Utils.key(ox, oy, oz)]
        return x == px and y == py and z == pz and recipes[item_name] ~= nil and
                (not state or (state.stock[item_name] or 0) < 4) and Utils.same_direction(ox, oy, oz, dx, dz)
    end

    function machine.accept(x, y, z, item_name)
        x, y, z = block.seek_origin(x, y, z)
        local key = Utils.key(x, y, z)
        local state = processing[key]
        if not state then
            state = { x = x, y = y, z = z, stock = {}, ticks = 0 }
            processing[key] = state
        end
        state.stock[item_name] = (state.stock[item_name] or 0) + 1
    end

    function machine.has_output(x, y, z)
        local px, py, pz = machine.port(x, y, z, true)
        local ox, oy, oz = block.seek_origin(x, y, z)
        local state = processing[Utils.key(ox, oy, oz)]
        return x == px and y == py and z == pz and state ~= nil and state.output ~= nil
    end

    function machine.register(x, y, z)
        if block.get(x, y, z) ~= block.index(config.block_name) or block.is_segment(x, y, z) then
            return
        end
        local key = Utils.key(x, y, z)
        if not models[key] then
            models[key] = { x = x, y = y, z = z }
        end
    end

    function machine.remove_model(x, y, z)
        local key = Utils.key(x, y, z)
        local model = models[key]
        if model and model.entity and entities.exists(model.entity:get_uid()) then
            model.entity:despawn()
        end
        models[key] = nil
    end

    function machine.tick()
        local Conveyor = require("game:conveyor")
        for key, state in pairs(processing) do
            local x, y, z = state.x, state.y, state.z
            local id = block.get(x, y, z)
            if not Room.contains(x, y, z) then
                -- Соседние площадки
            elseif id == -1 then
                -- В выгруженном чанке обработка стоит.
            elseif id ~= block.index(config.block_name) then
                processing[key] = nil
            else
                if not state.output then
                    if not state.input then
                        for item_name in pairs(recipes) do
                            if (state.stock[item_name] or 0) > 0 then
                                state.input = item_name
                                break
                            end
                        end
                    end
                    if state.input then
                        state.ticks = state.ticks + 1
                        if state.ticks == process_ticks then
                            state.stock[state.input] = state.stock[state.input] - 1
                            state.output = config.get_output and config.get_output(x, y, z, state.input) or recipes[state.input]
                            state.input = nil
                        end
                    end
                end
                -- Готовая деталь ждёт выхода, а сырьё пока может копиться до четырёх.
                if state.output then
                    local px, py, pz = machine.port(x, y, z, true)
                    local dx, dz = Utils.direction(x, y, z)
                    if Conveyor.feed(px + dx, py, pz + dz, dx, dz, state.output) then
                        state.output = nil
                        state.ticks = 0
                    end
                end
            end
        end
    end

    function machine.render()
        for key, model in pairs(models) do
            local x, y, z = model.x, model.y, model.z
            if block.get(x, y, z) ~= block.index(config.block_name) then
                machine.remove_model(x, y, z)
            else
                local right_x, _, right_z = block.get_X(x, y, z)
                local dx, dz = Utils.direction(x, y, z)
                local half = (size - 1) / 2
                local position = { x + .5 + (right_x + dx) * half, y + .5, z + .5 + (right_z + dz) * half }
                if not model.entity or not entities.exists(model.entity:get_uid()) then
                    model.entity = entities.spawn(config.entity_name, position)
                    model.entity.skeleton:set_interpolated(false)
                end
                model.entity.transform:set_pos(position)
                model.entity.transform:set_rot(mat4.rotate({ 0, 1, 0 }, block.get_rotation(x, y, z) * 90 - 90))
                model.entity.skeleton:reset_pose()
                local state = state_at(x, y, z)
                local track = config.animation and animation.get_track(config.animation)
                if state and state.ticks > 0 and state.ticks < process_ticks and track then
                    track.func(model.entity.skeleton, (state.ticks / 20) % track.duration)
                end
            end
        end
    end

    function machine.clear_process()
        processing = {}
    end

    function machine.clear()
        for _, model in pairs(models) do
            machine.remove_model(model.x, model.y, model.z)
        end
        models = {}
        processing = {}
    end

    return machine
end

return M
