local Intro = require("game:dialogues")
local Products = require("game:products")
local M = {}

local function length(text)
    local _, count = text:gsub("[^\128-\191]", "")
    return count
end

local function slice(text, count)
    local index, chars = 1, 0
    while index <= #text and chars < count do
        local byte = text:byte(index)
        index = index + (byte < 128 and 1 or byte < 224 and 2 or byte < 240 and 3 or 4)
        chars = chars + 1
    end
    return text:sub(1, index - 1)
end

function M.open(mode)
    M.mode, M.step, M.elapsed, M.reply = mode or "intro", 1, 0, nil
    require("game:ui/state").open("curator")
    require("game:sound").talk("ai_connect")
end

function M.view()
    local mission = require("game:mission").current()
    local node = M.mode == "intro" and Intro[M.step]
    if not node then
        local goals = {}
        for _, part in ipairs({ "gear", "rod", "gearbox" }) do
            if mission.goals[part] then
                goals[#goals + 1] = Products[part].caption .. " " .. mission.goals[part] .. "/мин"
            end
        end
        node = { title = mission.title, text = mission.text or "Проследите путь от подачи до приёмки. Переложите транспорт так, чтобы линия держала указанный выпуск.",
                 choices = { { label = "Приступить к работе" } } }
        node.text = node.text .. "\n\n" .. table.concat(goals, " · ")
    end
    local body = (M.reply and M.reply .. "\n\n" or "") .. node.text
    local count = math.floor((M.elapsed or 0) * 64)
    return { title = node.title, text = slice(body, count), ready = count >= length(body),
             choices = node.choices, step = M.step, total = M.mode == "intro" and #Intro + 1 or 1,
             assignment = not (M.mode == "intro" and Intro[M.step]) }
end

function M.update(dt)
    M.elapsed = (M.elapsed or 0) + math.min(.1, dt)
    if not M.view().ready then
        require("game:sound").syllable(M.elapsed)
    end
end

function M.choose(index)
    local view = M.view()
    if not view.ready then
        M.elapsed = 10000;
        return
    end
    local choice = view.choices[index]
    if not choice then
        return
    end
    require("game:sound").talk("ai_reply")
    if view.assignment then
        require("game:ui/state").close();
        return
    end
    M.reply = choice.reply
    M.step, M.elapsed = M.step + 1, 0
end

function M.skip()
    M.step, M.elapsed, M.reply = #Intro + 1, 0, nil
end

function M.reveal()
    M.elapsed = 10000
end

function M.snapshot()
    if require("game:ui/state").page ~= "curator" then
        return nil
    end
    return { mode = M.mode, step = M.step, elapsed = M.elapsed, reply = M.reply }
end

function M.restore(data)
    if type(data) ~= "table" or (data.mode ~= "intro" and data.mode ~= "briefing") or
            type(data.step) ~= "number" or data.step < 1 or data.step > #Intro + 1 then
        return
    end
    M.mode, M.step = data.mode, data.step
    M.elapsed, M.reply = tonumber(data.elapsed) or 0, type(data.reply) == "string" and data.reply or nil
    require("game:ui/state").open("curator")
end
return M
