local Conveyor = require("game:conveyor")
local Press = require("game:press")
local Assembler = require("game:assembler")
local Smelter = require("game:smelter")
local Source = require("game:source")
local Production = require("game:production")
local Delivery = require("game:delivery")
local Mission = require("game:mission")

function on_world_open()
    Mission.open()
    Delivery.clear()
    Production.paused = true
    world.set_day_time(.5)
    world.set_day_time_speed(0)

    Source.clear()
    Smelter.clear()
    Assembler.clear()
    Conveyor.clear()
    Press.clear()
end

function on_world_tick()
    if Production.paused or Mission.completed then
        return
    end
    Delivery.tick()
    Smelter.tick()
    Press.tick()
    Assembler.tick()
    Conveyor.tick()
    Mission.tick()
end

function on_world_quit()
    Delivery.clear()
    Source.clear()
    Smelter.clear()
    Assembler.clear()
    Conveyor.clear()
    Press.clear()
end
