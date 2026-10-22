local Conveyor = require("game:conveyor")
local Press = require("game:press")
local Assembler = require("game:assembler")
local Smelter = require("game:smelter")
local Source = require("game:source")

-- Обновляем модели продукции и оборудования каждый кадр.
function on_hud_render()
    Conveyor.render()
    Press.render()
    Assembler.render()
    Smelter.render()
    Source.render()
end
