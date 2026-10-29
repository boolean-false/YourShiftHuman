local Editor = require("editor:editor")
local Session = require("game:session")

function on_hud_open()
    if Session.editing then
        Editor.open(hud.get_player())
    end
end

function on_hud_render()
    if not Session.editing then
        return
    end
    Session.update_pause()
    Editor.update()
end

function on_hud_close()
    if Session.editing then
        Editor.close()
    end
end
