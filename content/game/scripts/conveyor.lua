local Conveyor = require("game:conveyor")
local Utils = require("game:utils")

-- Подбираем текстуру при установке, загрузке и изменении соседних блоков
function on_placed(x, y, z) Conveyor.update_nearby(x, y, z) end
function on_block_present(x, y, z) Conveyor.update_nearby(x, y, z) end
function on_update(x, y, z) Conveyor.update_shape(x, y, z) end

function on_interact(x, y, z, player_id)
    -- при нажатии пкм с котролом - вращяем по часовой
    if Utils.rotate_on_ctrl(x, y, z) then
        return true
    end

    Conveyor.insert(x, y, z, "base:red_lamp.item")
    return true
end
