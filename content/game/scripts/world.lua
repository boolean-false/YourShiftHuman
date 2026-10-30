local Conveyor = require("game:conveyor")
local Press = require("game:press")
local Assembler = require("game:assembler")
local Smelter = require("game:smelter")
local Source = require("game:source")
local Production = require("game:production")
local Delivery = require("game:delivery")
local Mission = require("game:mission")
local Session = require("game:session")
local Sink = require("game:sink")

function on_world_open()
    Session.open()
    Mission.open()
    Delivery.clear()
    Production.paused = true
    Production.speed = 1
    require("game:ui/state").reset()
    world.set_day_time(.5)
    world.set_day_time_speed(0)

    Source.clear()
    Sink.clear()
    Smelter.clear()
    Assembler.clear()
    Conveyor.clear()
    Press.clear()
end

function on_world_tick()
    if Session.editing or
            Session.preview or
            Production.paused or
            Mission.completed then
        return
    end

    -- Ускоряем весь завод
    for _ = 1, math.max(Mission.speed(), Production.speed) do
        if Production.paused or Mission.completed then
            break
        end
        Delivery.tick()
        Source.tick()
        Smelter.tick()
        Press.tick()
        Assembler.tick()
        Conveyor.tick()
        Mission.tick()
        if not Mission.checking and Production.speed == 1 then
            break
        end
    end
end

function on_world_save()
    Mission.save()
end

function on_world_quit()
    Sink.clear()
    Mission.save()
    Delivery.clear()
    Source.clear()
    Smelter.clear()
    Assembler.clear()
    Conveyor.clear()
    Press.clear()
end
