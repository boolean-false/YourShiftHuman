local Missions = require("game:missions")
local Delivery = require("game:delivery")
local Production = require("game:production")
local Session = require("game:session")

local M = {
    index = 1,
    completed = false,
    ticks = 0,
    windows = 0,
}

local warmup_ticks = 60 * 20
local window_ticks = 30 * 20

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
    last = {}
end

function M.open()
    M.index = Session.managed and Session.index or 1
    M.reset_check()
    if Session.editing then
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
end

-- Сохраняем только задание и результат
function M.save()
    local path = pack.data_file("game", "mission.json")
    file.write(path, json.tostring({
        version = 1,
        index = M.index,
        completed = M.completed
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

function M.tick()
    if M.completed or Session.editing then
        return
    end
    M.ticks = M.ticks + 1
    if M.ticks < warmup_ticks then
        return
    end
    if (M.ticks - warmup_ticks) % window_ticks ~= 0 then
        return
    end

    local passed = true
    for part, goal in pairs(M.current().goals) do
        local total = Delivery.total(part)
        if M.ticks > warmup_ticks and (total - last[part]) * 2 < goal then
            passed = false
        end
        last[part] = total
    end
    if M.ticks == warmup_ticks then
        return
    end

    M.windows = passed and M.windows + 1 or 0
    if M.windows == 3 then
        M.completed = true
        Production.paused = true
        M.save()
    end
end

function M.status()
    if Session.editing then
        return "Редактор"
    end
    if M.completed then
        return M.is_last() and "Все задания выполнены" or "Выполнено"
    end
    if M.ticks < warmup_ticks then
        return "Разгон: " .. math.ceil((warmup_ticks - M.ticks) / 20) .. " с"
    end
    return "Проверка: " .. M.windows .. "/3"
end

function M.locked(block_name)
    return fixed[block_name] == true
end

return M
