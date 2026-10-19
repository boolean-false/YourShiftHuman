-- Поворачиваем пресс так же, как источник и конвейер.
function on_interact(x, y, z, player_id)
    if input.is_pressed("key:left-ctrl") then
        block.set_rotation(x, y, z, (block.get_rotation(x, y, z) + 1) % 4)
        return true
    end
    return false
end
