local Conveyor = require "game:conveyor"


function on_interact(x, y, z, player_id)
    -- при нажатии пкм с котролом - вращяем по часовой
    if input.is_pressed("key:left-ctrl") then
        local rot = (block.get_rotation(x, y, z) + 1) % 4
        block.set_rotation(x, y, z, rot)
        return true
    end

    Conveyor.insert(x, y, z)
    return true
end
