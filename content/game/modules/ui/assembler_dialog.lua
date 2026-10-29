local MachineDialog = require("game:ui/machine_dialog")
local Assembler = require("game:assembler")

return function()
    MachineDialog({ machine = Assembler, title = "Сборщик" })
end
