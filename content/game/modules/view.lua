local M = {}
local Camera = require("game:camera")
local Hover = require("game:hover")
local disabled_bindings = {}

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
    Hover.close()
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
    -- Сохранение мира могло оставить активной камеру сверху.
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
    if not M.opened or hud.is_paused() or menu.page ~= "" then
        Hover.hide()
        return
    end
    if not hud.is_open("game:view_input") then
        if hud.is_inventory_open() then
            Hover.hide()
            return
        end
        hud.show_overlay("game:view_input", false)
    end
    hide_player()
    local mouse = input.get_mouse_pos()
    local over_ui = mouse[1] < 356 and mouse[2] < 160
    Camera.update(math.min(.1, time.delta()), not over_ui)
    local view = gui.get_viewport()
    if over_ui or mouse[1] < 0 or mouse[2] < 0 or mouse[1] >= view[1] or mouse[2] >= view[2] then
        Hover.hide()
    else
        Hover.update()
    end
    player.set_pos(M.pid, Camera.x, Camera.y + 2, Camera.z)
    player.set_camera(M.pid, M.camera)
end

local function leave()
    if not M.opened then
        return
    end
    M.opened = false
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
    for _, name in ipairs(disabled_bindings) do input.set_enabled(name, true) end
    disabled_bindings = {}
end

function M.open(pid)
    M.pid = pid
    M.active = true
    enter()

    input.add_callback("key:f10", function()
        time.post_runnable(function()
            if not M.active or hud.is_paused() or menu.page ~= "" then return end
            if M.opened then leave() else enter() end
        end)
        return true
    end, nil, true)

    input.add_callback("key:escape", function()
        if not M.opened then return false end
        if hud.is_paused() then hud.resume() else hud.pause() end
        return true
    end, nil, true)
end

function M.close()
    M.active = false
    leave()
end

return M
