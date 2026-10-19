local Conveyor = require("game:conveyor")

function on_world_open() Conveyor.clear() end
function on_world_tick() Conveyor.tick() end
function on_world_quit() Conveyor.clear() end
