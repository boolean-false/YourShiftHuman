local Conveyor = require("game:conveyor")
local Press = require("game:press")

-- Обновляем модели предметов и анимацию пресса каждый кадр.
function on_hud_render()
    Conveyor.render()
    Press.render()
end
