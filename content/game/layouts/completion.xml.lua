local K = require("kompot:kompot")
local Theme = require("game:ui/theme")
local Completion = require("game:ui/completion_dialog")
local handle

function on_open()
    handle = K.mount({ target = document.root, theme = Theme.theme, interactive = true, content = Completion })
end

function on_close()
    if handle then handle:dispose(); handle = nil end
end
