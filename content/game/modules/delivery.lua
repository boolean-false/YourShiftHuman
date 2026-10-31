local M = {}
local totals = {}
local deliveries = {}
local ticks = 0
local window_ticks = 30 * 20

-- Учитываем только после передачи в приёмку
function M.receive(item_name)
    totals[item_name] = (totals[item_name] or 0) + 1
    deliveries[#deliveries + 1] = { item_name = item_name, tick = ticks }
end

function M.tick()
    ticks = ticks + 1
    while deliveries[1] and deliveries[1].tick <= ticks - window_ticks do
        table.remove(deliveries, 1)
    end
end

function M.total(item_name)
    return totals[item_name] or 0
end

function M.rate(item_name, seconds)
    seconds = seconds or 6
    local count = 0
    for _, delivery in ipairs(deliveries) do
        if delivery.item_name == item_name and delivery.tick > ticks - seconds * 20 then
            count = count + 1
        end
    end
    return count * 60 / seconds
end

function M.has_tempo(goals)
    for part, goal in pairs(goals) do
        local arrivals = {}
        for i = #deliveries, 1, -1 do
            if deliveries[i].item_name == part then
                arrivals[#arrivals + 1] = deliveries[i].tick
                if #arrivals == 3 then
                    break
                end
            end
        end
        if #arrivals < 3 then
            return false
        end

        local interval = 60 * 20 / goal
        if ticks - arrivals[1] > interval + 2 or
                arrivals[1] - arrivals[3] > interval * 2 + 2 then
            return false
        end
    end
    return true
end

function M.clear()
    totals = {}
    deliveries = {}
    ticks = 0
end

return M
