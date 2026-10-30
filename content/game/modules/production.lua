local M = {
    speed = 1,
    paused = true -- На паузе ли игра. Да ну нах..
}

function M.toggle()
    M.paused = not M.paused
end

function M.cycle_speed()
    M.speed = M.speed == 1 and 2 or M.speed == 2 and 4 or 1
end

return M
