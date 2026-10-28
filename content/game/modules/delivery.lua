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

function M.rate(item_name)
    local count = 0
    for _, delivery in ipairs(deliveries) do
        if delivery.item_name == item_name then
            count = count + 1
        end
    end
    return count * 2
end

function M.clear()
    totals = {}
    deliveries = {}
    ticks = 0
end

return M
