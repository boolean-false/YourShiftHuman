-- Набор всяхит утилит, полезных в проекте

local M = {}

-- Ключ для хранения данных по координатам блока
function M.key(x, y, z)
    return string.format("%d:%d:%d", x, y, z)
end

-- Горизонтальное направление выхода блока с учётом поворота
function M.direction(x, y, z)
    local dx, _, dz = block.get_Z(x, y, z)
    return dx, dz
end

-- Выход блока смотрит вдоль движения предмета
function M.same_direction(x, y, z, dx, dz)
    local block_dx, block_dz = M.direction(x, y, z)
    return block_dx == dx and block_dz == dz
end

-- Выход блока смотрит навстречу предмету
function M.opposite_direction(x, y, z, dx, dz)
    return M.same_direction(x, y, z, -dx, -dz)
end

return M
