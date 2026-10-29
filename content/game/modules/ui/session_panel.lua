local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Session = require("game:session")
local Missions = require("game:missions")

return K.component(function()
    if not Session.managed then
        return
    end
    local expanded = K.state(false)
    local busy = K.poll(function()
        return Session.busy
    end)
    UI.Panel({ title = Session.editing and "Редактор" or "Уровень " .. Session.index, width = 340 }, function()
        K.Column({ spacing = 4 }, function()
            UI.Button({
                text = Session.editing and "Играть" or "Заново",
                enabled = not busy,
                on_click = function()
                    if not input.is_pressed("key:space") then
                        Session.queue("play", Session.index)
                    end
                end
            })
            UI.Button({
                text = "Редактор",
                enabled = not busy,
                on_click = function()
                    expanded.value = not expanded.value
                end
            })
            if expanded.value then
                K.Row({ spacing = 4 }, function()
                    for i = 1, #Missions do
                        local index = i
                        UI.Button({
                            text = tostring(index),
                            enabled = not busy,
                            on_click = function()
                                if not input.is_pressed("key:space") then
                                    Session.queue("edit", index)
                                end
                            end
                        })
                    end
                end)
                if Session.editing then
                    UI.Button({
                        text = "Экспорт уровня",
                        enabled = not busy,
                        on_click = function()
                            if not input.is_pressed("key:space") then
                                Session.queue("export", Session.index)
                            end
                        end
                    })
                end
            end
            K.Text(K.poll(function()
                return Session.message or ""
            end))
        end)
    end)
end)
