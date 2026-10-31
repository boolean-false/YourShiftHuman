local Production = require("game:production")
local M = {}
local belts = {}

function M.open()
    belts = {}
    for _, name in ipairs({ "conveyor_line", "conveyor_turn_left", "conveyor_turn_right", "splitter", "merger", "filter" }) do
        local folder = "game:textures/blocks/belt_frames/" .. name .. "/"
        local config = json.parse(file.read(folder .. "animation.json"))
        local belt = { texture = assets.to_canvas("blocks:" .. name), frames = {}, duration = 0 }
        for _, frame in ipairs(config.frames) do
            belt.duration = belt.duration + frame[2]
            belt.frames[#belt.frames + 1] = {
                image = Canvas.decode(file.read_bytes(folder .. frame[1] .. ".png"), "png"),
                finish = belt.duration
            }
        end
        belts[#belts + 1] = belt
    end
    M.render()
end

-- У лент те же часы, что у предметов и станков
function M.render()
    for _, belt in ipairs(belts) do
        local time = Production.ticks * 50 % belt.duration
        for index, frame in ipairs(belt.frames) do
            if time < frame.finish then
                if index ~= belt.frame then
                    belt.texture:clear()
                    belt.texture:blit(frame.image, 0, 0)
                    belt.texture:update()
                    belt.frame = index
                end
                break
            end
        end
    end
end

function M.close()
    belts = {}
end

return M
