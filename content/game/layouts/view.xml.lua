local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Hover = require("game:hover")
local Build = require("game:build")
local Production = require("game:production")
local Press = require("game:press")
local Actions = require("game:selection_actions")
local handle

function on_open()
    handle = K.mount({
        target = document.root,
        theme = UI.DEFAULT,
        interactive = true,
        content = function()

            local recipe = K.poll(function()
                local object = Hover.selected
                if Hover.press_open and object and object.id == block.index(Press.block_name) and
                        block.get(object.x, object.y, object.z) == object.id then
                    return Press.get_recipe(object.x, object.y, object.z) or ""
                end
                return ""
            end)

            K.Column({ modifier = K.M:padding(8) }, function()
                UI.Panel({ title = "Пам Пам Пам", width = 340 }, function()
                    local tool = K.poll(function()
                        return Build.tool or 0
                    end)
                    local paused = K.poll(function()
                        return Production.paused
                    end)
                    K.Column({ spacing = 4 }, function()
                        if paused then
                            K.Text("ПАЗУЗА")
                        end
                        for i, block_name in ipairs(Build.tools) do
                            local index = i
                            UI.Button({
                                text = i .. " " .. block.caption(block.index(block_name)),
                                selected = tool == i,
                                modifier = K.M:fill_max_width(),
                                on_click = function()
                                    if not input.is_pressed("key:space") then
                                        Build.choose(index)
                                    end
                                end
                            })
                        end
                        K.Text(K.poll(function()
                            return Build.tool and Build.caption() or Hover.caption()
                        end))
                    end)
                end)
            end)

            if recipe ~= "" then
                UI.Dialog({
                    visible = true,
                    title = "Пресс",
                    text = "Выберите изделие",
                    on_dismiss = Hover.close_press,
                    dismiss = { text = "Закрыть" }
                }, function()
                    K.Column({ spacing = 4 }, function()
                        UI.Button({
                            text = "Шестерёнка",
                            selected = recipe == "gear",
                            modifier = K.M:fill_max_width(),
                            on_click = function()
                                Actions.set_press_recipe("gear")
                            end
                        })
                        UI.Button({
                            text = "Вал",
                            selected = recipe == "rod",
                            modifier = K.M:fill_max_width(),
                            on_click = function()
                                Actions.set_press_recipe("rod")
                            end
                        })
                    end)
                end)
            end

        end
    })
    Build.ui_handle = handle
end

function on_close()
    Build.ui_handle = nil
    if handle then
        handle:dispose();
        handle = nil
    end
end
