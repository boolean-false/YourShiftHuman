local K = require("kompot:kompot")
local Session = require("game:session")
local State = require("game:ui/state")
local Pause = require("game:ui/pause_screen")
local Confirm = require("game:ui/confirm_dialog")
local Screens = require("game:ui/screens")
local Sound = require("game:sound")

return K.component(function()
    local data = K.poll(function()
        return { Session.pause_open, Session.busy, State.page, Sound.music }
    end)
    local viewport = K.poll(function()
        return gui.get_viewport()
    end)
    local w, h = viewport[1], viewport[2]
    Pause({ visible = Session.pause_open and State.page == "", w = w, h = h, busy = Session.busy,
            on_resume = Session.close_pause, on_menu = function()
            Session.queue("menu")
        end,
            on_restart = function()
                State.page = "restart"
            end,
            music = Sound.music, on_music = Sound.toggle_music,
            on_cases = function()
                State.page = "cases"
            end, on_help = function()
            State.page = "help"
        end })
    Screens({ w = w, h = h })
    Confirm({ visible = State.page == "restart", w = w, h = h, busy = Session.busy,
              title = "Вернуть исходную схему?", text = "Все изменения в этом цехе будут отменены. Сданные заказы останутся в истории.",
              confirm = "ВЕРНУТЬ ИСХОДНУЮ СХЕМУ", cancel = "ОСТАВИТЬ МОЮ СХЕМУ",
              on_confirm = function()
                  Session.queue("play", Session.index)
              end, on_cancel = function()
            State.page = ""
        end })
end)
