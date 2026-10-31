local K = require("kompot:kompot")
local Session = require("game:session")
local Main = require("game:ui/main_page")
local State = require("game:ui/state")
local Screens = require("game:ui/screens")
local Briefing = require("game:briefing")
local Confirm = require("game:ui/confirm_dialog")
local E = require("game:ui/components")
local Parts = require("game:ui/menu_parts")

return K.component(function()
    local data = K.poll(function()
        return { editor = Session.menu_page == "editor", progress = Session.has_progress(), ready = Session.can_continue(),
                 first_ready = Session.has_level(1), busy = Session.busy, message = Session.message or "", page = State.page }
    end)
    local viewport = K.poll(function()
        return gui.get_viewport()
    end)
    local w, h = viewport[1], viewport[2]
    K.effect(function()
        menu.size = { w, h }
    end, w, h)
    if data.editor and pack.is_installed("editor") then
        E.panel({ x = 28, y = 28, width = math.min(510, w - 56), height = math.min(660, h - 56) }, function()
            Parts.text("Редактор уровней", "heading")
            require("editor:ui/level_list")()
        end)
    elseif State.page == "" or State.page == "new" then
        data.w, data.h = w, h
        data.on_continue = function()
            Session.queue("continue")
        end
        data.on_new = function()
            if Session.has_progress() then
                State.page = "new"
            else
                Session.queue("new", 1)
            end
        end
        data.on_curator = function()
            Briefing.open("intro")
        end
        data.on_cases = function()
            State.open("cases")
        end
        data.on_help = function()
            State.open("help")
        end
        data.on_quit = function()
            Session.queue("quit")
        end
        Main(data)
    end
    Screens({ w = w, h = h })
    Confirm({ visible = State.page == "new", w = w, h = h, title = "Новая смена?",
              text = "Начать с первого цеха? Текущая схема и весь прогресс будут удалены.", confirm = "НАЧАТЬ ЗАНОВО",
              on_confirm = function()
                  Session.queue("new", 1)
              end, on_cancel = State.close })
end)
