local Session = require("game:session")
local Hover = require("game:hover")
local Production = require("game:production")
local M = {}

function M.open_dialog(x, y, z)
    if not M.active or not Session.editing or Session.busy then
        return false
    end
    if not Hover.has_dialog(block.get(x, y, z)) or not Hover.select(x, y, z) then
        return false
    end
    M.right_down = input.is_pressed("mouse:right")
    M.close_time = 0
    time.post_runnable(function()
        if M.active and Hover.dialog_open then
            hud.show_overlay("editor:dialog", false)
        end
    end)
    return true
end

function M.open(pid)
    M.active = true
    M.right_down = input.is_pressed("mouse:right")
    Production.paused = true
    M.interact_handler = events.on("game:block_settings", M.open_dialog)
    local avatar = entities.get(player.get_entity(pid))
    if avatar then
        avatar.rigidbody:set_enabled(true)
        avatar.skeleton:set_visible(true)
    end
    player.set_camera(pid, cameras.get("core:first-person"):get_index())
    hud.open_permanent("editor:hint")
    input.add_callback("key:escape", function()
        if not M.active then
            return false
        end
        if hud.is_open("editor:menu") then
            Session.close_pause()
        elseif hud.is_open("editor:dialog") then
            Hover.close_dialog()
        elseif hud.is_inventory_open() then
            return false
        else
            Session.show_pause()
        end
        return true
    end, nil, true)
end

function M.update()
    local right = input.is_pressed("mouse:right")
    local cancel = right and not M.right_down
    M.right_down = right
    if not hud.is_open("editor:dialog") or Session.menu_blocked then
        return
    end
    local object = Hover.selected
    if cancel or not object or block.get(object.x, object.y, object.z) ~= object.id then
        Hover.close_dialog()
    end
    if not Hover.dialog_open then
        M.close_time = M.close_time + time.delta()
        if M.close_time >= .2 then
            hud.close("editor:dialog")
        end
    end
end

function M.close()
    M.active = false
    if M.interact_handler then
        events.remove("game:block_settings", M.interact_handler)
        M.interact_handler = nil
    end
    if hud.is_open("editor:dialog") then
        hud.close("editor:dialog")
    end
    if hud.is_open("editor:menu") then
        hud.close("editor:menu")
    end
    hud.close("editor:hint")
    Hover.clear_selection()
end

return M
