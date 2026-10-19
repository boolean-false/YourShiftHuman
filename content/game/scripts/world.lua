local Conveyor = require("game:conveyor")
local Press = require("game:press")

function on_world_open()
    Conveyor.clear()
    Press.clear()
end

function on_world_tick()
    Press.tick()
    Conveyor.tick()
end

function on_world_quit()
    Conveyor.clear()
    Press.clear()
end
