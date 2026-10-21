local Conveyor = require("game:conveyor")
local Press = require("game:press")
local Assembler = require("game:assembler")

-- Обновляем модели предметов и анимацию пресса каждый кадр.
function on_hud_render()
    Conveyor.render()
    Press.render()
    Assembler.render()
end
