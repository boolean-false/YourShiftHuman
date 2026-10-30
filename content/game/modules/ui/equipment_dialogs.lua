local K = require("kompot:kompot")
local Hover = require("game:hover")
local Session = require("game:session")
local Mission = require("game:mission")
local Press = require("game:press")
local Smelter = require("game:smelter")
local Assembler = require("game:assembler")
local Source = require("game:source")
local Sink = require("game:sink")
local Filter = require("game:filter")
local Splitter = require("game:splitter")
local Actions = require("game:selection_actions")
local Panel = require("game:ui/equipment_panel")
local controllers = { ["game:press"] = Press, ["game:smelter"] = Smelter, ["game:assembler"] = Assembler }

return K.component(function()
    local viewport = K.poll(function()
        return gui.get_viewport()
    end)
    local data = K.poll(function()
        local object = Hover.selected
        if not Hover.dialog_open or not object or block.get(object.x, object.y, object.z) ~= object.id then
            return false
        end
        local name = block.name(object.id)
        local p = { title = block.caption(object.id), kind = name:sub(6), visible = true, editing = Session.editing,
                    completed = Mission.completed, transport = name == "game:filter" or name == "game:splitter" or name == "game:merger" or name == "game:conveyor" }
        local x, y, z = object.x, object.y, object.z
        if controllers[name] then
            local description = controllers[name].describe(x, y, z)
            p.status, p.detail = description:match("([^\n]*)\n?(.*)")
        end
        if name == "game:press" then
            p.recipe = Press.get_recipe(x, y, z)
        elseif name == "game:splitter" then
            p.ratio = Splitter.get_ratio(x, y, z)
        elseif name == "game:filter" then
            p.product = Filter.parts[Filter.get_type(x, y, z)].name
        elseif name == "game:source" then
            p.product = Source.caption(Source.get_type(x, y, z))
        elseif name == "game:sink" then
            p.product = Sink.caption(Sink.get_type(x, y, z))
        end
        return p
    end)
    local p = data or { visible = false }
    p.w, p.h = viewport[1], viewport[2]
    p.on_close, p.on_recipe, p.on_ratio = Hover.close_dialog, Actions.set_press_recipe, Actions.set_splitter_ratio
    p.on_cycle = p.kind == "source" and Actions.cycle_source or p.kind == "sink" and Actions.cycle_sink or Actions.cycle_filter
    p.on_rotate = function()
        Actions.rotate(hud.get_player())
    end
    p.on_remove = Actions.remove
    p.on_move = Actions.move
    Panel(p)
end)
