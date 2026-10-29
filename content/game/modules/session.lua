local Missions = require("game:missions")
local M = { managed = false, editing = false, index = 1, busy = false }
local work_name = "yourshifthuman_play"
local work_folder = "user:worlds/" .. work_name

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
    file.write(profile_path(), json.tostring({ version = 1, index = index, completed = completed }))
end

function M.save_progress(index, completed)
    if not M.managed or M.editing then
        return
    end
    write_profile(index, completed)
end

function M.open()
    M.busy, M.request, M.message = false, nil, nil
    M.managed = world.get_generator() == "game:room"
    M.editing = M.managed
    M.index = valid_index(world.get_seed()) and world.get_seed() or 1
    local marker = read_json("world:data/game/play.json")
    if marker and marker.version == 1 and valid_index(marker.index) then
        M.managed = true
        M.index = marker.index
        M.editing = false
    end
end

function M.queue(action, index)
    if M.busy or not M.managed then
        return false
    end
    if not valid_index(index) then
        return false
    end
    if action ~= "play" and action ~= "edit" and action ~= "export" then
        return false
    end
    if action == "export" and (not M.editing or index ~= M.index) then
        return false
    end
    if action == "play" and not M.has_level(index) then
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
    require("game:view").close()
    app.close_world(true)
end

local function copy_level(index, destination)
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

local function open_editor(app, index)
    local name = tostring(index)
    if file.isfile(author_folder(index) .. "/world.json") then
        app.open_world(name)
    elseif file.isfile("game:levels/" .. index .. ".zip") then
        copy_level(index, author_folder(index))
        app.open_world(name)
    else
        app.new_world(name, name, "game:room")
        app.save_world()
    end
end

local function start_level(app, index)
    if file.isdir(work_folder) then
        local marker = read_json(work_folder .. "/data/game/play.json")
        if not marker or marker.version ~= 1 or not valid_index(marker.index) then
            error("Нет метки игровой копии: " .. work_folder)
        end
        file.remove_tree(work_folder)
    end
    copy_level(index, work_folder)
    file.mkdirs(work_folder .. "/data/game")
    file.write(work_folder .. "/data/game/play.json", json.tostring({ version = 1, index = index }))
    file.write(work_folder .. "/data/game/mission.json", json.tostring({
        version = 1, index = index, completed = false
    }))
    write_profile(index, false)
    app.open_world(work_name)
end

function M.start(app)
    local profile = read_json(profile_path())
    local index = profile and profile.version == 1 and valid_index(profile.index) and profile.index or 1
    local marker = read_json(work_folder .. "/data/game/play.json")
    if marker and marker.version == 1 and marker.index == index and file.isfile(work_folder .. "/world.json") then
        app.open_world(work_name)
    elseif M.has_level(index) then
        start_level(app, index)
    else
        open_editor(app, index)
    end
end

function M.update(app)
    local request = M.request
    if not request then
        return
    end
    M.request = nil
    if request.action == "export" then
        close_world(app)
        file.mkdirs("export:levels")
        file.create_zip(author_folder(request.index), "export:levels/" .. request.index .. ".zip")
        open_editor(app, request.index)
        require("game:session").message = "Сохранено в export/levels/" .. request.index .. ".zip"
        return
    end
    close_world(app)
    if request.action == "edit" then
        open_editor(app, request.index)
    else
        start_level(app, request.index)
    end
end

return M
