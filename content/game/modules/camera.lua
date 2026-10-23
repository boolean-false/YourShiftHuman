local M = {}

local MIN_DISTANCE = 17
local MAX_DISTANCE = 65
local ROTATE_SPEED = 1.6
local MOUSE_SENSITIVITY = 0.008
local SMOOTH_SPEED = 9

local camera
local smooth_x, smooth_z

M.x, M.y, M.z = 0, 0, 0
M.yaw = math.rad(45) -- Поворот по горизонтали
M.pitch = math.rad(55) -- Наклон камеры
M.distance = 38 -- Расстояние до цели

-- Проверка на удержание кнопы
local function key(name)
    return input.is_pressed("key:" .. name) and 1 or 0
end

local function clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

function M.open(x, y, z)
    M.x, M.y, M.z = x, y, z
    M.yaw = math.rad(45)
    M.distance = 38

    smooth_x, smooth_z = x, z

    camera = cameras.get("game:factory")
    camera:set_perspective(true)
    camera:set_fov(39)

    return camera:get_index()
end

-- Направления движения относительно поворота камеры
-- rx, rz - вправо
-- fx, fz - вперёд
function M.axes()
    local s = math.sin(M.yaw)
    local c = math.cos(M.yaw)

    return c, -s, -s, -c
end

function M.update(dt, allow_pointer)
    local rx, rz, fx, fz = M.axes()

    -- q, e поворот
    M.yaw = (M.yaw + (key("e") - key("q")) * ROTATE_SPEED * dt) % (2 * math.pi)
    -- wasd
    local dx = key("d") - key("a")
    local dz = key("w") - key("s")
    local speed = M.distance * 0.4 * dt

    M.x = M.x + (rx * dx + fx * dz) * speed
    M.z = M.z + (rz * dx + fz * dz) * speed

    if allow_pointer then
        -- зум на колесико
        M.distance = clamp(
                M.distance - input.get_mouse_scroll() * 2,
                MIN_DISTANCE,
                MAX_DISTANCE
        )

        -- смещение при зажатом колесике
        if input.is_pressed("mouse:middle") then
            local delta = input.get_mouse_delta()
            local shift = key("left-shift") == 1 or key("right-shift") == 1

            if shift then
                -- шифт скм
                M.yaw = (M.yaw - delta[1] * MOUSE_SENSITIVITY)
                        % (2 * math.pi)
            else
                -- скм перемещение
                local scale = M.distance / gui.get_viewport()[2]

                M.x = M.x - (rx * delta[1] - fx * delta[2]) * scale
                M.z = M.z - (rz * delta[1] - fz * delta[2]) * scale
            end
        end
    end

    local t = 1 - math.exp(-SMOOTH_SPEED * dt)

    smooth_x = smooth_x + (M.x - smooth_x) * t
    smooth_z = smooth_z + (M.z - smooth_z) * t

    local flat = M.distance * math.cos(M.pitch)

    camera:set_pos({
        smooth_x + math.sin(M.yaw) * flat,
        M.y + math.sin(M.pitch) * M.distance,
        smooth_z + math.cos(M.yaw) * flat
    })

    camera:look_at({ smooth_x, M.y + 0.6, smooth_z })
end

return M