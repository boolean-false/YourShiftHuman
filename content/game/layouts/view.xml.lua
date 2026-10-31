local K = require("kompot:kompot")
local Theme = require("game:ui/theme")
local Hover = require("game:hover")
local Build = require("game:build")
local Production = require("game:production")
local Equipment = require("game:ui/equipment_dialogs")
local Completion = require("game:ui/completion_dialog")
local Hud = require("game:ui/factory_hud")
local Screens = require("game:ui/screens")
local State = require("game:ui/state")
local Session = require("game:session")
local Mission = require("game:mission")
local Delivery = require("game:delivery")
local Products = require("game:products")
local Actions = require("game:selection_actions")
local Briefing = require("game:briefing")
local PortLabels = require("game:ui/port_labels")
local handle

local function factory()
    local viewport = K.poll(function()
        return gui.get_viewport()
    end)
    local data = K.poll(function()
        local goals = {}
        for _, part in ipairs({ "gear", "rod", "gearbox" }) do
            local goal = Mission.current().goals[part]
            if goal then
                goals[#goals + 1] = Products[part].caption .. ": " .. Delivery.rate(part) .. " / " .. goal .. " в мин"
            end
        end
        local tools = {}
        for i, name in ipairs(Build.tools) do
            tools[i] = { name = block.caption(block.index(name)), available = Mission.available(name) }
        end
        return { index = Mission.index, title = Mission.current().title, goals = table.concat(goals, " · "), progress = Mission.progress(),
                 paused = Production.paused, completed = Mission.completed, speed = Mission.speed(), accelerating = Mission.accelerating,
                 tool = Build.tool, erase = Build.erase, tools = tools,
                 hint = Build.reason or Build.message or Hover.message or (Build.erase and "ЛКМ: провести по транспорту · ПКМ: отменить" or Build.moving and "Выберите новое место · ПКМ: отменить" or Build.tool and Build.caption() or "Проверьте путь от подачи до приёмки"),
                 error = Build.reason ~= nil or Build.message ~= nil }
    end)
    data.w, data.h = viewport[1], viewport[2]
    data.on_run, data.on_speed, data.on_flush = Production.toggle, Production.cycle_speed, Actions.flush
    data.on_tool, data.on_erase = Build.choose, Build.choose_erase
    data.on_curator = function()
        Briefing.open("briefing")
    end
    data.on_help = function()
        State.open("help")
    end
    Hud(data)
    PortLabels()
    Equipment()
    if not Session.pause_open then
        Screens({ w = viewport[1], h = viewport[2] })
    end
    Completion()
end

function on_open()
    handle = K.mount({ target = document.root, theme = Theme.theme, interactive = true, content = factory })
    Build.ui_handle = handle
end

function on_close()
    Build.ui_handle = nil
    if handle then
        handle:dispose();
        handle = nil
    end
end

