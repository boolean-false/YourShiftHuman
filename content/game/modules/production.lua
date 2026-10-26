local M = {
    paused = true -- На паузе ли игра. Да ну нах..
}

function M.toggle()
    M.paused = not M.paused
end

return M
