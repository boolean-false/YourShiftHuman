local Machine = require("game:machine")

return Machine.create({
    block_name = "game:press",
    entity_name = "game:press_visual",
    recipes = { ingot = "gear" },
    process_ticks = 10,
    animation = "press_work"
})
