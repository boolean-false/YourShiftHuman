local Machine = require("game:machine")

return Machine.create({
    block_name = "game:smelter",
    entity_name = "game:smelter_visual",
    recipes = { ore = "ingot" },
    process_ticks = 20,
    animation = "smelter_work"
})
