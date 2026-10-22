local Conveyor = require("game:conveyor")

-- Подбираем текстуру при установке, загрузке и изменении соседних блоков
function on_placed(x, y, z) Conveyor.update_nearby(x, y, z) end
function on_block_present(x, y, z) Conveyor.update_nearby(x, y, z) end
function on_update(x, y, z) Conveyor.update_shape(x, y, z) end
