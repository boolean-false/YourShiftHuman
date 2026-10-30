local Sink = require("game:sink")

function on_placed(x, y, z)
    Sink.register(x, y, z)
end
function on_block_present(x, y, z)
    Sink.register(x, y, z)
end
function on_block_removed(x, y, z)
    Sink.remove(x, y, z)
end

function on_interact(x, y, z)
    return events.emit("game:block_settings", x, y, z) or false
end
