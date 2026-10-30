local M = {}
local Camera = require("game:camera")
local Hover = require("game:hover")
local Actions = require("game:selection_actions")
local Build = require("game:build")
local Production = require("game:production")
local Mission = require("game:mission")
local UIState = require("game:ui/state")
local Session = require("game:session")
local Room = require("game:room")
local disabled_bindings = {}
local tool_keys = {}

local function floor_at(x, y, z)
    for py = math.floor(y), math.max(0, math.floor(y) - 64), -1 do
        local id = block.get(math.floor(x), py, math.floor(z))
        if id == -1 then
            break
        end
        if block.is_solid_at(math.floor(x), py, math.floor(z)) and block.name(id):sub(1, 5) ~= "game:" then
            return py + 1
        end
        if id == block.index("game:build_floor") then
            return py + 1
        end
    end
    return math.floor(y)
end

local function hide_player()
    local avatar = entities.get(player.get_entity(M.pid))
    if avatar then
        avatar.rigidbody:set_enabled(false)
        avatar.skeleton:set_visible(false)
    end
end

-- Включаем вид сверху из текущей позиции обычного игрока.
local function enter()
    Build.cancel()
    Hover.close()
    M.left_down = input.is_pressed("mouse:left")
    M.right_down = input.is_pressed("mouse:right")
    M.rotate_down = input.is_pressed("key:r")
    M.delete_down = input.is_pressed("key:delete")
    M.backspace_down = input.is_pressed("key:backspace")
    M.space_down = input.is_pressed("key:space")
    for i = 1, #Build.tools do
        tool_keys[i] = input.is_pressed("key:" .. i)
    end

    local pid = M.pid
    local x, y, z = player.get_pos(pid)
    M.position = { x, y, z }
    M.previous_camera = player.get_camera(pid)
    local avatar = entities.get(player.get_entity(pid))
    if avatar then
        M.body_enabled = avatar.rigidbody:is_enabled()
        M.body_visible = avatar.skeleton:is_visible()
    end
    M.camera = Camera.open(x, floor_at(x, y, z), z)

    if M.previous_camera == nil or M.previous_camera == M.camera then
        M.previous_camera = cameras.get("core:first-person"):get_index()
    end
    player.set_camera(pid, M.camera)
    Camera.update(0, false)
    hide_player()
    for _, name in ipairs(input.get_bindings()) do
        if name:match("^movement%.") or name:match("^player%.") or name:match("^camera%.") or
                name == "hud.inventory" or name == "hud.chat" or name == "kompot.gallery" then
            input.set_enabled(name, false)
            disabled_bindings[#disabled_bindings + 1] = name
        end
    end
    local bar = gui.root["hud.hotbar"]
    if bar.exists then
        M.hotbar_parent = bar.parent
        gui.root.root:add("<container id=\"game_hidden\" visible=\"false\" size=\"0,0\"/>")
        bar:moveInto(gui.root.game_hidden)
    end
    M.opened = true
    hud.show_overlay("game:view_input", false)
    hud.open_permanent("game:view")
    if menu.page ~= "" then
        gui.close_menu()
    end
    gui.set_active_frame("core:main")
end

function M.update()
    local left = input.is_pressed("mouse:left")
    local right = input.is_pressed("mouse:right")
    local clicked = left and not M.left_down
    local cancel = right and not M.right_down
    M.left_down, M.right_down = left, right
    local rotate = input.is_pressed("key:r")
    local delete = input.is_pressed("key:delete")
    local backspace = input.is_pressed("key:backspace")
    local rotate_pressed = rotate and not M.rotate_down
    local delete_pressed = (delete and not M.delete_down) or (backspace and not M.backspace_down)
    M.rotate_down, M.delete_down, M.backspace_down = rotate, delete, backspace
    local space = input.is_pressed("key:space")
    local space_pressed = space and not M.space_down
    M.space_down = space
    local tool_pressed
    local erase = input.is_pressed("key:x")
    local erase_pressed = erase and not M.erase_down
    M.erase_down = erase
    for i = 1, #Build.tools do
        local down = input.is_pressed("key:" .. i)
        if down and not tool_keys[i] then
            tool_pressed = i
        end
        tool_keys[i] = down
    end

    if not M.opened or UIState.page ~= "" or Session.menu_blocked or Session.busy or hud.is_paused() or menu.page ~= "" then
        Build.cancel_path()
        Hover.hide()
        return
    end
    if not hud.is_open("game:view_input") then
        if hud.is_inventory_open() then
            Build.cancel_path()
            Hover.hide()
            return
        end
        hud.show_overlay("game:view_input", false)
    end

    hide_player()

    if Mission.completed then
        Build.cancel()
        Hover.clear_selection()
        Hover.hide()
        return
    end

    if Hover.dialog_closed then
        Hover.dialog_closed = false
        Hover.hide()
        return
    end
    if Hover.dialog_open then
        local object = Hover.selected
        if not object or block.get(object.x, object.y, object.z) ~= object.id then
            Hover.clear_selection()
        elseif cancel then
            Hover.close_dialog()
        end
    end

    if space_pressed then
        Production.toggle()
    end
    if tool_pressed then
        Build.choose(tool_pressed)
    end
    if erase_pressed then
        Build.choose_erase()
    end
    if cancel then
        Build.cancel()
        Hover.clear_selection()
    end
    if delete_pressed and not Build.tool then
        Actions.remove()
    elseif rotate_pressed then
        if Build.tool then
            Build.rotate()
        else
            Actions.rotate(M.pid)
        end
    end

    local mouse = input.get_mouse_pos()
    local over_ui = Build.ui_handle and Build.ui_handle:is_over(mouse[1], mouse[2]) or false
    Camera.update(math.min(.1, time.delta()), not over_ui)
    local view = gui.get_viewport()
    if over_ui or mouse[1] < 0 or mouse[2] < 0 or mouse[1] >= view[1] or mouse[2] >= view[2] then
        Build.pointer(nil, left, true, M.pid)
        Hover.hide()
    else
        Hover.update(clicked and not right and not Build.tool and not Build.erase and not Build.moving)
        Build.pointer(Hover.cell, left and not right, Hover.cell == nil, M.pid)
        Build.preview(Hover.cell)
    end
    player.set_pos(M.pid, Camera.x, Camera.y + 2, Camera.z)
    player.set_camera(M.pid, M.camera)
end

local function leave()
    if not M.opened then
        return
    end
    M.opened = false
    Production.paused = true
    Build.cancel()
    Hover.close()
    hud.close("game:view")
    hud.close("game:view_input")
    if M.hotbar_parent and M.hotbar_parent.exists then
        local bar = gui.root["hud.hotbar"]
        if bar.exists then
            bar:moveInto(M.hotbar_parent)
        end
    end
    if gui.root.game_hidden.exists then
        gui.root.game_hidden:destruct()
    end
    M.hotbar_parent = nil
    local avatar = entities.get(player.get_entity(M.pid))
    if avatar then
        avatar.rigidbody:set_enabled(M.body_enabled ~= false)
        avatar.skeleton:set_visible(M.body_visible ~= false)
    end
    player.set_camera(M.pid, M.previous_camera)
    player.set_pos(M.pid, unpack(M.position))
    for _, name in ipairs(disabled_bindings) do
        input.set_enabled(name, true)
    end
    disabled_bindings = {}
end

function M.open(pid)
    M.pid = pid
    M.active = true
    -- У сохранённого исходника мог остаться вид сверху. Возвращаем обычного игрока.
    if Session.managed then
        local avatar = entities.get(player.get_entity(pid))
        if avatar then
            avatar.rigidbody:set_enabled(true)
            avatar.skeleton:set_visible(true)
        end
        player.set_camera(pid, cameras.get("core:first-person"):get_index())
    end
    enter()
    if Session.managed then
        local area = Room.area()
        M.camera = Camera.open(area.width / 2, Room.floor + 1, area.depth / 2)
        Camera.distance = area.width > 26 and 58 or area.width >= 22 and 44 or 38
        Camera.update(0, false)
        player.set_pos(pid, Camera.x, Camera.y + 2, Camera.z)
    end

    input.add_callback("key:escape", function()
        if not M.active or not M.opened or Session.preview then
            return false
        end
        if UIState.page ~= "" then
            UIState.close()
        elseif hud.is_open("game:pause_menu") then
            Session.close_pause()
        elseif hud.is_paused() then
            hud.resume()
        elseif Hover.dialog_open then
            Hover.close_dialog()
        elseif Build.tool or Build.erase or Build.moving or Hover.selected then
            Build.cancel()
            Hover.clear_selection()
        else
            Session.show_pause()
        end
        return true
    end, nil, true)
end

function M.close()
    M.active = false
    if hud.is_open("game:pause_menu") then
        hud.close("game:pause_menu")
    end
    leave()
end

return M
