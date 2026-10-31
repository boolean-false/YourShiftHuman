local K = require("kompot:kompot")
local State = require("game:ui/state")
local Session = require("game:session")
local Missions = require("game:missions")
local Cases = require("game:ui/cases_screen")
local Help = require("game:ui/help_screen")
local Confirm = require("game:ui/confirm_dialog")
local Curator = require("game:ui/curator_screen")
local Briefing = require("game:briefing")
local Sound = require("game:sound")

return K.component(function(p)
    local frame = K.poll(function()
        return { State.page, State.clock, State.pending, Session.busy }
    end)
    local page = State.page
    if page == "help" then
        Help({ w = p.w, h = p.h, on_back = State.close })
    elseif page == "cases" then
        local profile = Session.progress()
        local levels = {}
        for i, level in ipairs(Missions) do
            levels[i] = { title = level.title, unlocked = i <= profile.unlocked,
                          completed = profile.records[tostring(i)] == true, available = i <= profile.unlocked and Session.has_level(i) }
        end
        Cases({ w = p.w, h = p.h, levels = levels, busy = Session.busy, on_back = State.close,
                on_select = function(index)
                    State.pending = index;
                    State.page = "case-confirm"
                end })
    elseif page == "curator" then
        local view = Briefing.view()
        view.w, view.h, view.time = p.w, p.h, State.clock
        view.on_choose, view.on_skip, view.on_reveal = Briefing.choose, Briefing.skip, Briefing.reveal
        view.sound, view.on_sound = Sound.sound, Sound.toggle_sound
        Curator(view)
    end
    Confirm({ visible = page == "case-confirm", w = p.w, h = p.h, busy = Session.busy,
              title = "Открыть цех " .. (State.pending or 1) .. "?",
              text = "Этот цех откроется с исходной схемой. Текущая схема будет потеряна. Отметки о пройденных цехах сохранятся.",
              confirm = "ОТКРЫТЬ ЦЕХ", cancel = "НАЗАД К СПИСКУ",
              on_confirm = function()
                  Session.queue("play", State.pending)
              end,
              on_cancel = function()
                  State.page = "cases"
              end })
end)
