local Conveyor = require("game:conveyor")
local Press = require("game:press")
local Assembler = require("game:assembler")
local Smelter = require("game:smelter")

function on_world_open()
    Smelter.clear()
    Assembler.clear()
    Conveyor.clear()
    Press.clear()
end

function on_world_tick()
    Press.tick()
    Conveyor.tick()
end

function on_world_quit()
    Smelter.clear()
    Assembler.clear()
    Conveyor.clear()
    Press.clear()
end
