local Missions = require("game:missions")
local M = { index = 1 }

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
    return M.current().allowed[block_name] == true
end

function M.locked(block_name)
    return fixed[block_name] == true
end

return M
