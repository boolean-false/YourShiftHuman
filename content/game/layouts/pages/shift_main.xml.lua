local K = require("kompot:kompot")
local Theme = require("game:ui/theme")
local Session = require("game:session")
local MainMenu = require("game:ui/main_menu")
local handle

function on_open()
    document.root.size = gui.get_viewport()
    document.root.color = Session.preview and
            { 0, 0, 0, 0 } or
            { 23, 38, 43, 255 }

    handle = K.mount({ target = document.root, theme = Theme.theme, interactive = true, content = MainMenu })
    input.add_callback("key:escape", function()
        require("game:ui/state").close()
        Session.menu_page = "main"
        return true
    end, document.root, true)
end

function on_close()
    if handle then
        handle:dispose();
        handle = nil
    end
end
