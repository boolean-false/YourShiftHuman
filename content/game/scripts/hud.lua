local Conveyor = require("game:conveyor")
local Press = require("game:press")
local Assembler = require("game:assembler")
local Smelter = require("game:smelter")
local Source = require("game:source")
local View = require("game:view")

function on_hud_open()
    View.open(hud.get_player())
end

-- Обновляем модели продукции и оборудования каждый кадр.
function on_hud_render()
    View.update()
    Conveyor.render()
    Press.render()
    Assembler.render()
    Smelter.render()
    Source.render()
end

function on_hud_close()
    View.close()
end
