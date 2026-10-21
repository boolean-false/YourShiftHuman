local Conveyor = require("game:conveyor")
local Press = require("game:press")

function on_hud_render()
    Conveyor.render()
    Press.render()
end
