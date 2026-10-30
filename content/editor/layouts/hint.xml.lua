local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Session = require("game:session")
local handle

function on_open()
    handle = K.mount({
        target = document.root,
        theme = UI.DEFAULT,
        interactive = false,
        content = function()
            K.Column({ spacing = 4, modifier = K.M:padding(8) }, function()
                K.Text("Редактор · уровень " .. Session.index)
                K.Text("ПКМ - настройки · Esc - меню")
            end)
        end
    })
end

function on_close()
    if handle then
        handle:dispose();
        handle = nil
    end
end
