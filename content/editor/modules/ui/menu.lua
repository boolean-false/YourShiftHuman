local K = require("kompot:kompot")
local Session = require("game:session")
local Menu = require("editor:ui/menu_screen")
return K.component(function()
    local data = K.poll(function()
        return { visible = Session.pause_open, index = Session.index, busy = Session.busy, message = Session.message }
    end)
    local viewport = K.poll(function()
        return gui.get_viewport()
    end)
    data.w, data.h = viewport[1], viewport[2]
    data.on_save = function()
        Session.queue("save", Session.index)
    end
    data.on_export = function()
        Session.queue("export", Session.index)
    end
    data.on_play = function()
        Session.queue("play", Session.index)
    end
    data.on_levels = function()
        Session.queue("editor_menu")
    end
    data.on_menu = function()
        Session.queue("menu")
    end
    data.on_resume = Session.close_pause
    Menu(data)
end)
