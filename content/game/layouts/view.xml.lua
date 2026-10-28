local K = require("kompot:kompot")
local UI = require("kompot:ui")
local Hover = require("game:hover")
local Build = require("game:build")
local Production = require("game:production")
local PressDialog = require("game:ui/press_dialog")
local FilterDialog = require("game:ui/filter_dialog")
local DeliveryPanel = require("game:ui/delivery_panel")
local MissionPanel = require("game:ui/mission_panel")
local Mission = require("game:mission")
local handle

function on_open()
    handle = K.mount({
        target = document.root,
        theme = UI.DEFAULT,
        interactive = true,
        content = function()

            K.Row({ spacing = 8, modifier = K.M:padding(8) }, function()
                K.Column({ spacing = 8 }, function()
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
                                    enabled = Mission.available(block_name),
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
                    DeliveryPanel()
                end)
                MissionPanel()
            end)

            FilterDialog()
            PressDialog()

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
