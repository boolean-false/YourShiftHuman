local M = { music = true, sound = true }
local loaded, speaking = false, -1

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

-- Плеер живёт в start.lua и не теряется при смене мира.
function M.update(player, dt)
    M.load()
    local Session = require("game:session")
    local State = require("game:ui/state")
    local target = .16
    if State.page == "curator" then
        target = .035
    elseif Session.editing then
        target = .07
    elseif Session.menu_open or Session.pause_open or require("game:production").paused then
        target = .10
    end
    if not M.music then
        target = 0
    end

    if player.stream and not audio.is_playing(player.stream) then
        player.stream = nil
    end
    if M.music and not player.stream then
        player.volume = 0
        player.stream = audio.play_stream_2d("game:sounds/shift.wav", 0, 1, "music", true)
    end
    local blend = 1 - math.exp(-4 * math.min(dt, .1))
    player.volume = player.volume + (target - player.volume) * blend
    if player.stream then
        audio.set_volume(player.stream, player.volume)
        if target == 0 and player.volume < .001 then
            audio.stop(player.stream)
            player.stream = nil
        end
    end
end
return M