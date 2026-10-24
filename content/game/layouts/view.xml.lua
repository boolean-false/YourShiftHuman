local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Hover = require("game:hover")
local handle

function on_open()
    handle = K.mount({
        target = document.root,
        theme = UI.DEFAULT,
        content = function()
            K.Column({ modifier = K.M:padding(8) }, function()
                UI.Panel({ title = "Пам Пам Пам", width = 340 }, function()
                    local caption = K.poll(function() return Hover.caption() end)
                    K.Text(caption)
                end)
            end)
        end
    })
end

function on_close()
    if handle then handle:dispose(); handle = nil end
end
