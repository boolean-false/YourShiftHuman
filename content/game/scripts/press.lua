local Utils = require("game:utils")

-- Поворачиваем пресс так же, как источник и конвейер.
function on_interact(x, y, z, player_id)
    return Utils.rotate_on_ctrl(x, y, z)
end
