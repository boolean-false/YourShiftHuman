local K = require "kompot:kompot"
local T = require "kompot:ui/tokens"
local Common = require "kompot:ui/components/common"
local M = K.M

return function(Button, Menu, MenuItem)
    -- Выбор значения из списка; selected меняет владелец.
    -- props: options, selected, on_select(value), label, hint, read_only, error,
    --   enabled, width, max_height, surface, tooltip, modifier
    return K.component(function(props)
        props = T.props("Select", props)
        local th = T.current()
        local open = K.state(false)
        local geometry = K.remember(function()
            return {}
        end)
        local enabled = props.enabled ~= false and props.read_only ~= true
        K.effect(function()
            if not enabled then
                open.value = false
            end
        end, enabled)
        local options, selected, focus_index, available = {}, nil, 1, 0
        for i, option in ipairs(props.options or {}) do
            local o
            if type(option) == "table" then
                local value = option.value
                if value == nil then
                    value = option[1]
                end
                o = {
                    value = value,
                    text = option.text or option[2] or tostring(value),
                    icon = option.icon,
                    enabled = option.enabled ~= false,
                }
            else
                o = {
                    value = option,
                    text = tostring(option),
                    enabled = true,
                }
            end
            options[i] = o
            if o.enabled then
                available = available + 1
            end
            if o.value == props.selected then
                selected = o
                if o.enabled then
                    focus_index = available
                end
            end
        end
        K.Column({
            modifier = (props.modifier or M):fill_max_width(),
            spacing = 4,
        }, function()
            if props.label then
                K.Text(props.label, {
                    style = th.type.body,
                    color = th.colors.muted,
                })
            end
            K.Box({
                modifier = M:fill_max_width():on_size(function(w)
                    geometry.width = w
                end),
            }, function()
                local trigger = M:fill_max_width():tag("select_trigger")
                if props.error then
                    trigger = trigger:border(1, th.colors.error, th.shapes.field)
                end
                Button({
                    text = selected and selected.text
                        or props.hint
                        or "Выберите значение",
                    icon = selected and selected.icon,
                    align = "start",
                    enabled = enabled and available > 0,
                    focusable = true,
                    modifier = trigger,
                    on_click = function()
                        open.value = not open:peek()
                    end,
                }, function()
                    K.Text(
                        selected and selected.text
                            or props.hint
                            or "Выберите значение",
                        {
                            style = th.type.body,
                            wrap = false,
                            modifier = M:weight(1),
                        }
                    )
                    Common.any_icon("chevron_down", 16, K.LocalContentColor:get())
                end)
                Menu({
                    expanded = enabled and open.value,
                    width = props.width or geometry.width or 240,
                    max_height = props.max_height,
                    focus_index = focus_index,
                    on_dismiss = function()
                        open.value = false
                    end,
                }, function()
                    for i, o in ipairs(options) do
                        K.key(i, function()
                            MenuItem({
                                text = o.text,
                                icon = o.icon,
                                enabled = o.enabled,
                                selected = o.value == props.selected,
                                modifier = M:tag("select_option_" .. i),
                                on_click = function()
                                    open.value = false
                                    if props.on_select then
                                        props.on_select(o.value)
                                    end
                                end,
                            })
                        end)
                    end
                end)
            end)
            if type(props.error) == "string" then
                K.Text(props.error, {
                    style = th.type.caption,
                    color = th.colors.error,
                })
            end
        end)
    end)
end
