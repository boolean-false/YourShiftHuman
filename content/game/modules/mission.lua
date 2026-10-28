local Missions = require("game:missions")
local Delivery = require("game:delivery")
local Production = require("game:production")

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
    M.index = 1
    M.reset_check()
end

function M.is_last()
    return M.index == #Missions
end

function M.advance()
    if not M.completed or M.is_last() then
        return false
    end
    M.index = M.index + 1
    M.reset_check()
    return true
end

function M.tick()
    if M.completed then
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
    end
end

function M.status()
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
