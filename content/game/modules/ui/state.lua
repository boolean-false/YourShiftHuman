local M = { page = "", back = "", clock = 0 }

function M.open(page)
    M.back = M.page
    M.page = page
    local Production = require("game:production")
    if M.restore == nil then
        M.restore = Production.paused
    end
    Production.paused = true
    require("game:build").cancel()
end

function M.close()
    M.page = ""
    if M.restore ~= nil then
        require("game:production").paused = M.restore
    end
    M.restore = nil
end

function M.reset()
    M.page, M.back, M.restore = "", "", nil
end

function M.update(dt)
    M.clock = M.clock + math.min(.1, dt)
    local space = input.is_pressed("key:space")
    local enter = input.is_pressed("key:enter")
    local one = input.is_pressed("key:1")
    local two = input.is_pressed("key:2")
    if M.page == "curator" then
        local Briefing = require("game:briefing")
        Briefing.update(dt)
        if space and not M.space or enter and not M.enter or one and not M.one then
            Briefing.choose(1)
        end
        if two and not M.two then
            Briefing.choose(2)
        end
    end
    M.space, M.enter, M.one, M.two = space, enter, one, two
end

return M
