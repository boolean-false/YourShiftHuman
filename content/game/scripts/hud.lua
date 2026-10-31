local Conveyor = require("game:conveyor")
local Press = require("game:press")
local Assembler = require("game:assembler")
local Smelter = require("game:smelter")
local Source = require("game:source")
local Sink = require("game:sink")
local View = require("game:view")
local Session = require("game:session")

function on_hud_open()
    require("game:belt_animation").open()
    require("game:environment").apply(gfx)
    if not Session.editing then
        if not Session.preview then
            local dialogue = require("game:mission").saved_dialogue
            if dialogue then
                require("game:briefing").restore(dialogue)
            end
        end
        View.open(hud.get_player())
        if Session.preview then
            hud.close("game:view")
            hud.close("game:view_input")
        end
    end
end

-- Обновляем модели продукции и оборудования каждый кадр.
function on_hud_render()
    require("game:belt_animation").render()
    if not Session.editing and not Session.preview then
        Session.update_pause()
        View.update()
    end
    Conveyor.render()
    Press.render()
    Assembler.render()
    Smelter.render()
    Source.render()
    Sink.render()
end

function on_hud_close()
    require("game:belt_animation").close()
    if not Session.editing then
        View.close()
    end
end
