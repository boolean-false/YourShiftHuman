local K = require("kompot:kompot")
local UI = require("kompot:ui")
local handle

function on_open()
    handle = K.mount({
        target = document.root,
        theme = UI.DEFAULT,
        content = function()
            K.Column({ modifier = K.M:padding(8) }, function()
                UI.Panel({ title = "Пам Пам Пам", width = 340 }, function()
                end)
            end)
        end
    })
end

function on_close()
    if handle then handle:dispose(); handle = nil end
end
