local K = require("kompot:kompot")
local Session = require("game:session")
local Missions = require("game:missions")
local Buttons = require("editor:ui/level_buttons")
return K.component(function()
    local busy = K.poll(function()
        return Session.busy
    end)
    Buttons({ levels = Missions, busy = busy,
              on_select = function(index)
                  Session.queue("edit", index)
              end,
              on_back = function()
                  Session.queue("menu")
              end })
end)
