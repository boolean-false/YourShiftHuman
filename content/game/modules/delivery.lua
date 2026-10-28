local M = {}
local totals = {}

-- Учитываем только после передачи в приёмку
function M.receive(item_name)
    totals[item_name] = (totals[item_name] or 0) + 1
end


function M.total(item_name)
    return totals[item_name] or 0
end


function M.clear()
    totals = {}
end

return M
