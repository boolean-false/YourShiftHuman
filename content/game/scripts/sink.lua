function on_interact(x, y, z)
    return events.emit("game:block_settings", x, y, z) or false
end
