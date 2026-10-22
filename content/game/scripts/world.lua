local Conveyor = require("game:conveyor")
local Press = require("game:press")
local Assembler = require("game:assembler")
local Smelter = require("game:smelter")
local Source = require("game:source")

function on_world_open()
    Source.clear()
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
    Source.clear()
    Smelter.clear()
    Assembler.clear()
    Conveyor.clear()
    Press.clear()
end
