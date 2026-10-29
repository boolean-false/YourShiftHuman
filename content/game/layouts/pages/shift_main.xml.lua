local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Session = require("game:session")
local MainMenu = require("game:ui/main_menu")
local handle

function on_open()
    handle = K.mount({ target = document.root, theme = UI.DEFAULT, interactive = true, content = MainMenu })
    input.add_callback("key:escape", function()
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
