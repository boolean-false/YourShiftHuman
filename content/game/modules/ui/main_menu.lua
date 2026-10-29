local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Session = require("game:session")

return K.component(function()
    local editor = K.poll(function()
        return Session.menu_page == "editor" and pack.is_installed("editor")
    end)
    local busy = K.poll(function()
        return Session.busy
    end)
    K.Box({ modifier = K.M:fill_max_size(), align = "center" }, function()
        UI.Panel({ title = editor and "Редактор уровней" or "Your Shift, Human", width = 420 }, function()
            K.Column({ spacing = 8 }, function()
                if editor then
                    require("editor:ui/level_list")()
                else
                    local ready = K.poll(function()
                        return Session.can_continue()
                    end)
                    local progress = K.poll(function()
                        return Session.has_progress()
                    end)
                    UI.Button({
                        text = progress and "Продолжить" or "Играть",
                        enabled = not busy and ready,
                        modifier = K.M:fill_max_width(),
                        on_click = function()
                            Session.queue("continue")
                        end
                    })
                    if progress then
                        UI.Button({
                            text = "Новая игра",
                            enabled = not busy and Session.has_level(1),
                            modifier = K.M:fill_max_width(),
                            on_click = function()
                                Session.queue("play", 1)
                            end
                        })
                    end
                    if not ready then
                        K.Text("Уровни ещё не готовы")
                    end
                    if pack.is_installed("editor") then
                        UI.Button({
                            text = "Редактор",
                            enabled = not busy,
                            modifier = K.M:fill_max_width(),
                            on_click = function()
                                Session.menu_page = "editor"
                            end
                        })
                    end
                    UI.Button({
                        text = "Выход",
                        enabled = not busy,
                        modifier = K.M:fill_max_width(),
                        on_click = function()
                            Session.queue("quit")
                        end
                    })
                end
                K.Text(K.poll(function()
                    return Session.message or ""
                end))
            end)
        end)
    end)
end)
