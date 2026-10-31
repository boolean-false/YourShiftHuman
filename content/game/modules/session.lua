local Missions = require("game:missions")
local M = { managed = false, editing = false, index = 1, busy = false }
local work_name = "yourshifthuman_play"
local work_folder = "user:worlds/" .. work_name
local menu_name = "yourshifthuman_menu"
local menu_folder = "user:worlds/" .. menu_name

local function read_json(path)
    if not file.isfile(path) then
        return nil
    end
    local ok, data = pcall(function()
        return json.parse(file.read(path))
    end)
    if ok and type(data) == "table" then
        return data
    end
end

local function valid_index(index)
    return type(index) == "number" and Missions[index] ~= nil
end

local function author_folder(index)
    return "user:worlds/" .. index
end

function M.has_level(index)
    return valid_index(index) and (file.isfile(author_folder(index) .. "/world.json") or
            file.isfile("game:levels/" .. index .. ".zip"))
end

-- Копируем весь мир, а не только чанки. У блоков есть состояния и индексы
local function copy_folder(source, target)
    file.mkdirs(target)
    for _, path in ipairs(file.list(source)) do
        local destination = file.join(target, file.name(path))
        if file.isdir(path) then
            copy_folder(path, destination)
        else
            file.write_bytes(destination, file.read_bytes(path))
        end
    end
end

local function profile_path()
    return pack.shared_file("game", "campaign.json")
end

local function write_profile(index, completed)
    local profile = read_json(profile_path()) or {}
    profile.version, profile.index, profile.completed = 1, index, completed
    if not completed then
        profile.done = false
    end
    profile.records = profile.records or {}
    profile.unlocked = math.max(profile.unlocked or 1, index)
    if completed then
        profile.records[tostring(index)] = true
        profile.unlocked = math.max(profile.unlocked, math.min(index + 1, #Missions))
    end
    file.write(profile_path(), json.tostring(profile))
end

function M.progress()
    local profile = read_json(profile_path()) or {}
    profile.records = profile.records or {}
    profile.unlocked = profile.unlocked or profile.index or 1
    if profile.completed and valid_index(profile.index) then
        profile.records[tostring(profile.index)] = true
        profile.unlocked = math.max(profile.unlocked, math.min(profile.index + 1, #Missions))
    end
    return profile
end

function M.finish_campaign()
    local profile = M.progress()
    profile.done = true
    file.write(profile_path(), json.tostring(profile))
end

function M.save_progress(index, completed)
    if not M.managed or M.editing or M.preview then
        return
    end
    write_profile(index, completed)
end

function M.open()
    M.busy, M.request, M.message = false, nil, nil
    M.menu_open, M.had_world, M.pause_open = false, true, false
    M.menu_blocked = false
    M.managed = world.get_generator() == "game:room"
    M.editing = M.managed and pack.is_installed("editor")
    M.preview = read_json("world:data/game/menu.json") ~= nil
    if M.preview then
        M.editing = false
    end
    M.index = valid_index(world.get_seed()) and world.get_seed() or 1
    local marker = read_json("world:data/game/play.json")
    if marker and marker.version == 1 and valid_index(marker.index) then
        M.managed = true
        M.index = marker.index
        M.editing = false
    end
end

function M.queue(action, index)
    if M.busy or (world.is_open() and not M.managed) then
        return false
    end
    index = index or M.index
    if not valid_index(index) then
        return false
    end
    if action ~= "new" and action ~= "play" and action ~= "edit" and action ~= "export" and action ~= "continue" and
            action ~= "menu" and action ~= "editor_menu" and action ~= "quit" and action ~= "save" then
        return false
    end
    if (action == "export" or action == "save") and (not M.editing or index ~= M.index) then
        return false
    end
    if (action == "edit" or action == "editor_menu" or action == "export" or action == "save") and
            not pack.is_installed("editor") then
        return false
    end
    if (action == "play" or action == "new") and not M.has_level(index) then
        M.message = "Уровень ещё не сохранён"
        return false
    end
    M.busy = true
    M.request = { action = action, index = index }
    require("game:production").paused = true
    return true
end

local function close_world(app)
    if not world.is_open() then
        return
    end
    if M.editing then
        require("editor:editor").close()
    else
        require("game:view").close()
    end
    app.close_world(not M.preview)
    -- При выходе движок выгружает контент. Меню тоже нужны наши модули и Kompot.
    if not app.is_content_loaded() then
        app.load_content()
    end
end

local function pause_layout()
    return M.editing and "editor:menu" or "game:pause_menu"
end

function M.show_pause()
    local layout = pause_layout()
    if M.busy or hud.is_open(layout) then
        return
    end
    local Production = require("game:production")
    M.pause_restore = Production.paused
    Production.paused = true
    M.pause_open, M.pause_time = true, 0
    require("game:ui/state").reset()
    M.save_requested = true
    hud.show_overlay(layout, false)
end

function M.close_pause()
    M.pause_open = false
end

function M.update_pause()
    local layout = pause_layout()
    M.menu_blocked = hud.is_open(layout)
    if not M.menu_blocked then
        return
    end
    if not M.pause_open then
        M.pause_time = M.pause_time + time.delta()
        if M.pause_time >= .2 then
            hud.close(layout)
        end
    end
end

function M.resume()
    if not M.busy then
        require("game:production").paused = M.pause_restore
    end
    M.pause_open = false
end

function M.copy_level(index, destination)
    local source = author_folder(index)
    if file.isfile(source .. "/world.json") then
        copy_folder(source, destination)
        return
    end
    local mount = file.mount("game:levels/" .. index .. ".zip")
    local ok, err = pcall(function()
        copy_folder(mount .. ":", destination)
    end)
    file.unmount(mount)
    if not ok then
        error(err)
    end
end

-- В игровой копии редактор не нужен, даже если исходник сохраняли вместе с ним.
function M.strip_editor(folder)
    local path = file.join(folder, "packs.list")
    local packs = {}
    for _, id in ipairs(file.readlines(path)) do
        if not id:match("^%s*editor%s*$") then
            packs[#packs + 1] = id
        end
    end
    file.write(path, table.concat(packs, "\n") .. "\n")
end

local function start_level(app, index, intro)
    if file.isdir(work_folder) then
        local marker = read_json(work_folder .. "/data/game/play.json")
        if not marker or marker.version ~= 1 or not valid_index(marker.index) then
            error("Нет метки игровой копии: " .. work_folder)
        end
        file.remove_tree(work_folder)
    end
    M.copy_level(index, work_folder)
    M.strip_editor(work_folder)
    file.mkdirs(work_folder .. "/data/game")
    file.write(work_folder .. "/data/game/play.json", json.tostring({ version = 1, index = index }))
    file.write(work_folder .. "/data/game/mission.json", json.tostring({
        version = 1, index = index, completed = false
    }))
    write_profile(index, false)
    app.open_world(work_name)
    require("game:briefing").open(intro and "intro" or "briefing")
end

local function resume_level(app)
    local profile = read_json(profile_path())
    local index = profile and profile.version == 1 and valid_index(profile.index) and profile.index or 1
    local marker = read_json(work_folder .. "/data/game/play.json")
    if marker and marker.version == 1 and marker.index == index and file.isfile(work_folder .. "/world.json") then
        M.strip_editor(work_folder)
        app.open_world(work_name)
    elseif M.has_level(index) then
        start_level(app, index)
    else
        M.message = "Уровень не готов"
        M.start(app)
    end
end

function M.can_continue()
    local profile = read_json(profile_path())
    local index = profile and profile.version == 1 and valid_index(profile.index) and profile.index or 1
    local marker = read_json(work_folder .. "/data/game/play.json")
    return (marker and marker.version == 1 and marker.index == index and
            file.isfile(work_folder .. "/world.json")) or M.has_level(index)
end

function M.has_progress()
    local profile = read_json(profile_path())
    local marker = read_json(work_folder .. "/data/game/play.json")
    return profile and profile.version == 1 and valid_index(profile.index) and marker and
            marker.version == 1 and marker.index == profile.index and file.isfile(work_folder .. "/world.json") or false
end

local function open_menu_world(app)
    if not M.has_level(1) then
        return
    end
    if file.isdir(menu_folder) then
        local marker = read_json(menu_folder .. "/data/game/menu.json")
        if not marker or marker.version ~= 1 then
            return
        end
        file.remove_tree(menu_folder)
    end
    M.copy_level(1, menu_folder)
    M.strip_editor(menu_folder)
    file.mkdirs(menu_folder .. "/data/game")
    file.write(menu_folder .. "/data/game/menu.json", json.tostring({ version = 1 }))
    app.open_world(menu_name)
end

function M.start(app)
    if not app.is_content_loaded() then
        app.load_content()
    end
    -- Фоном служит отдельная копия первого цеха. Исходник не сохраняем и не меняем.
    if not world.is_open() then
        open_menu_world(app)
    end
    local current = require("game:session")
    current.menu_open, current.had_world = true, world.is_open()
    current.managed, current.editing, current.busy = current.preview == true, false, false
    current.menu_page = "main"
    require("game:ui/state").reset()
    menu:reset()
    menu.page = "shift_main"
    menu.visible = true
    gui.set_active_frame("core:main")
end

function M.update(app)
    if M.save_requested and world.is_open() then
        M.save_requested = false
        app.save_world()
    end
    local request = M.request
    if not request then
        if M.had_world and not world.is_open() then
            M.start(app)
        end
        return
    end
    M.request = nil
    if request.action == "save" then
        app.save_world()
        M.message, M.busy = "Сохранено", false
        return
    end
    if request.action == "export" then
        close_world(app)
        require("editor:worlds").export(request.index)
        require("editor:worlds").open(app, request.index)
        require("game:session").message = "Сохранено в export/levels/" .. request.index .. ".zip"
        return
    end
    close_world(app)
    M.had_world = false
    if request.action == "menu" or request.action == "editor_menu" then
        M.start(app)
        if request.action == "editor_menu" then
            require("game:session").menu_page = "editor"
        end
        return
    elseif request.action == "quit" then
        app.quit()
        return
    end
    M.menu_open = false
    gui.close_menu()
    if request.action == "continue" then
        resume_level(app)
    elseif request.action == "edit" then
        require("editor:worlds").open(app, request.index)
    elseif request.action == "new" then
        file.write(profile_path(), json.tostring({ version = 1, index = 1, completed = false, unlocked = 1, records = {} }))
        start_level(app, 1, true)
    else
        start_level(app, request.index)
    end
end

return M
