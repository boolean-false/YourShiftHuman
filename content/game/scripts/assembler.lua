local Assembler = require("game:assembler")

function on_interact(x, y, z)
    return events.emit("game:block_settings", x, y, z) or false
end

function on_placed(x, y, z)
    Assembler.register(x, y, z)
end

function on_block_present(x, y, z)
    Assembler.register(x, y, z)
end

function on_block_removed(x, y, z)
    Assembler.remove_model(x, y, z)
end
