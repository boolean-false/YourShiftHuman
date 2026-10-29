local MachineDialog = require("game:ui/machine_dialog")
local Smelter = require("game:smelter")

return function()
    MachineDialog({ machine = Smelter, title = "Плавильня" })
end
