local K = require("kompot:kompot")
local Mission = require("game:mission")
local Session = require("game:session")
local Actions = require("game:selection_actions")
local Complete = require("game:ui/completion_screen")
local Result = require("game:ui/result_screen")

return K.component(function()
    local state = K.remember(function()
        return { result = Session.progress().done == true }
    end)
    local data = K.poll(function()
        return { visible = Session.managed and not Session.editing and Mission.completed, last = Mission.is_last(),
                 ready = not Session.busy and (Mission.is_last() or Session.has_level(Mission.index + 1)), result = state.result }
    end)
    local viewport = K.poll(function()
        return gui.get_viewport()
    end)
    Complete({ visible = data.visible and not data.result, w = viewport[1], h = viewport[2], last = data.last, ready = data.ready,
        verdict = Mission.current().verdict,
               on_menu = function()
                   Session.queue("menu")
               end,
               on_next = function()
                   if Mission.is_last() then
                       Session.finish_campaign();
                       state.result = true
                   else
                       Actions.next_mission()
                   end
               end })
    local count = 0
    for _ in pairs(Session.progress().records) do
        count = count + 1
    end
    Result({ visible = data.visible and data.result, w = viewport[1], h = viewport[2], count = count,
             on_close = function()
                 Session.queue("menu")
             end })
end)
