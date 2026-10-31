local Missions = require("game:missions")
local Delivery = require("game:delivery")
local Production = require("game:production")
local Session = require("game:session")

local M = {
    index = 1,
    completed = false,
    ticks = 0,
    windows = 0,
    checking = false,
    accelerating = false,
    boost = 1,
}

local window_seconds = 6
local window_ticks = window_seconds * 20

local last = {}

local fixed = {
    ["game:source"] = true,
    ["game:sink"] = true,
    ["game:smelter"] = true,
    ["game:press"] = true,
    ["game:assembler"] = true
}

function M.current()
    return Missions[M.index]
end

function M.available(block_name)
    return not M.completed and M.current().allowed[block_name] == true
end

-- После изменения схемы начинаем замеры заново
function M.reset_check()
    M.completed = false
    M.ticks = 0
    M.windows = 0
    M.checking = false
    M.accelerating = false
    M.boost = 1
    last = {}
end

function M.open()
    M.saved_dialogue = nil
    M.index = Session.managed and Session.index or 1
    M.reset_check()
    if Session.editing or Session.preview then
        return
    end

    local path = pack.data_file("game", "mission.json")
    if not file.isfile(path) then
        return
    end
    local ok, data = pcall(function()
        return json.parse(file.read(path))
    end)
    if not ok or type(data) ~= "table" or data.version ~= 1 then
        return
    end
    if type(data.index) ~= "number" or not Missions[data.index] or
            type(data.completed) ~= "boolean" then
        return
    end
    if Session.managed and data.index ~= Session.index then
        return
    end
    M.index = data.index
    M.completed = data.completed
    M.saved_dialogue = data.dialogue
end

-- Сохраняем задание, результат и незаконченный разговор.
function M.save()
    if Session.preview then
        return
    end
    local path = pack.data_file("game", "mission.json")
    file.write(path, json.tostring({
        version = 1,
        index = M.index,
        completed = M.completed,
        dialogue = require("game:briefing").snapshot()
    }))
    Session.save_progress(M.index, M.completed)
end

function M.is_last()
    return M.index == #Missions
end

function M.advance()
    if not M.completed then
        return false
    end
    if M.is_last() then
        return Session.queue("menu")
    end
    return Session.queue("play", M.index + 1)
end

-- Увидели нормальную подачу в приёмку, дальше не заставляем ждать
function M.update_speed()
    if not M.accelerating and Delivery.has_tempo(M.current().goals) then
        M.accelerating = true
        M.boost = Production.speed
    end
    if M.accelerating then
        M.boost = math.min(16, M.boost + 1)
    end
end

function M.speed()
    return M.accelerating and M.boost or Production.speed
end

function M.tick()
    if M.completed or Session.editing then
        return
    end
    M.ticks = M.ticks + 1
    if not M.checking then
        local flowing = true
        for part in pairs(M.current().goals) do
            if Delivery.total(part) == 0 then
                flowing = false
            end
        end
        if flowing then
            M.checking = true
            M.ticks = 0
            for part in pairs(M.current().goals) do
                last[part] = Delivery.total(part)
            end
        end
        return
    end
    if M.ticks % window_ticks ~= 0 then
        return
    end

    local passed = true
    for part, goal in pairs(M.current().goals) do
        local total = Delivery.total(part)
        local required = math.ceil(goal * window_seconds / 60 - .000001)
        if total - last[part] < required then
            passed = false
        end
        last[part] = total
    end
    M.windows = passed and M.windows + 1 or 0
    if not passed then
        M.accelerating = false
        M.boost = 1
    end
    if M.windows == 3 then
        M.completed = true
        Production.paused = true
        M.save()
    end
end

function M.progress()
    if M.completed then
        return 1
    end
    if not M.checking then
        return 0
    end
    return (M.windows + M.ticks % window_ticks / window_ticks) / 3
end

function M.locked(block_name)
    return fixed[block_name] == true
end

return M
