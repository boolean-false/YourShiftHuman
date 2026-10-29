local M = json.parse(file.read("game:room.json"))
local Session = require("game:session")

function M.area()
    return M.areas[Session.index] or M
end

function M.contains(x, y, z)
    if world.get_generator() ~= "game:room" then
        return true
    end
    local area = M.area()
    return y == M.floor + 1 and
            x >= 0 and x < area.width and
            z >= 0 and z < area.depth
end

return M
