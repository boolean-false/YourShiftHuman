local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Session = require("game:session")
local PauseMenu = require("game:ui/pause_menu")
local handle

function on_open()
    handle = K.mount({
        target = document.root,
        theme = UI.DEFAULT,
        interactive = true,
        content = PauseMenu,
    })
end

function on_close()
    if handle then
        handle:dispose();
        handle = nil
    end
    Session.resume()
end
