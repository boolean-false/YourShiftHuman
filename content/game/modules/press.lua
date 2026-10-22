local Machine = require("game:machine")

return Machine.create({
    block_name = "game:press",
    entity_name = "game:press_visual",
    recipes = { ["base:red_lamp.item"] = "base:green_lamp.item" },
    process_ticks = 40,
    animation = "press_work"
})
