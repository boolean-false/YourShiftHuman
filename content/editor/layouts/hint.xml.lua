local K = require("kompot:kompot")
local Theme = require("game:ui/theme")
local Session = require("game:session")
local Hint = require("editor:ui/hint")
local handle
function on_open()
    handle = K.mount({ target = document.root, theme = Theme.theme, interactive = false,
                       content = function()
                           Hint({ index = Session.index })
                       end })
end
function on_close()
    if handle then
        handle:dispose();
        handle = nil
    end
end
