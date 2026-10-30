local M = { music = true, sound = true }
local loaded, stream, speaking = false, nil, -1

local function path()
    return pack.shared_file("game", "settings.json")
end

function M.load()
    if loaded then
        return
    end
    loaded = true
    if not file.isfile(path()) then
        return
    end
    local ok, data = pcall(function()
        return json.parse(file.read(path()))
    end)
    if ok and type(data) == "table" then
        M.music, M.sound = data.music ~= false, data.sound ~= false
    end
end

local function save()
    file.write(path(), json.tostring({ music = M.music, sound = M.sound }))
end

function M.toggle_music()
    M.music = not M.music;
    save()
end
function M.toggle_sound()
    M.sound = not M.sound;
    save()
end

function M.talk(name)
    M.load()
    if M.sound then
        audio.play_sound_2d("ysh/" .. name, .14, 1, "ui")
    end
end

function M.syllable(elapsed)
    local tick = math.floor(elapsed * 12)
    if tick ~= speaking then
        speaking = tick;
        M.talk("ai_syllable")
    end
end

function M.update()
    M.load()
    local Session = require("game:session")
    local State = require("game:ui/state")
    local active = M.music and world.is_open() and not Session.preview and not Session.editing and
            not Session.pause_open and State.page == "" and not require("game:production").paused
    if active and not stream then
        stream = audio.play_stream_2d("game:sounds/shift.wav", .2, 1, "music", true)
    elseif not active and stream then
        audio.stop(stream);
        stream = nil
    end
end
return M
