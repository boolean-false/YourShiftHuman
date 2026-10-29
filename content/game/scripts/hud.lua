local Conveyor = require("game:conveyor")
local Press = require("game:press")
local Assembler = require("game:assembler")
local Smelter = require("game:smelter")
local Source = require("game:source")
local View = require("game:view")
local Session = require("game:session")

function on_hud_open()
    if not Session.editing then View.open(hud.get_player()) end
end

-- Обновляем модели продукции и оборудования каждый кадр.
function on_hud_render()
    if not Session.editing then
        Session.update_pause()
        View.update()
    end
    Conveyor.render()
    Press.render()
    Assembler.render()
    Smelter.render()
    Source.render()
end

function on_hud_close()
    if not Session.editing then View.close() end
end
