-- Нативное поле хранит весь код, Kompot прокручивает видимую область
local K = require "kompot:kompot"
local T = require "kompot:ui/tokens"
local Skin = require "kompot:ui/skin"
local Common = require "kompot:ui/components/common"
local Scrollbar = require "kompot:ui/components/scrollbar"
local M = K.M
local max, min, floor = math.max, math.min, math.floor

local Viewer = K.component(function(props)
    local code = props.code
    local count = 1
    for _ in code:gmatch("\n") do
        count = count + 1
    end
    local theme, rt = T.current(), K.runtime()
    local font = props.font
    if font == nil then
        font = theme.type.mono.font
    end
    if font == false then
        font = "normal"
    end

    -- Метрики шрифта готовы после первой отрисовки
    local lh = K.poll(function()
        return K.text.field_line_height(rt.measurer, font)
    end)
    local pad = theme.metrics.field_pad
    local viewport = K.poll(function()
        return rt.height
    end)
    local own_height = K.state(nil)
    local resized = props.height_state or own_height
    local scroll = K.scroll_state()
    local interaction = K.interaction()
    local focused = K.state(false)

    -- Ограничиваем высоту размером экрана.
    local lo = props.min_height or 120
    local hi = max(lo, props.max_height or floor(viewport * 0.7))
    local natural = props.height or max(2, props.lines or count) * lh + pad * 2
    local height = resized.value or natural
    if props.resizable then
        height = max(lo, min(hi, height))
    end
    local native_height = max(2, count) * lh + pad * 2
    local tail = props.scroll_past_end ~= false and lh or 0
    local extra = max(0, count * lh + pad * 2 + tail - native_height)
    scroll.step = lh * 3

    K.Column({
        modifier = props.modifier or M:fill_max_width(),
        spacing = 6,
    }, function()
        if props.title then
            K.Text(props.title, {
                style = theme.type.body,
                color = theme.colors.muted,
            })
        end
        K.Box({
            modifier = M:fill_max_width():height(height):tag("lua_viewport"),
        }, function()
            Skin.Surface(Common.surface("code", "inset", props, nil, {
                skin = false,
                color = theme.colors.sunken,
                focused = focused.value,
                border_width = 1,
                border_color = focused.value and theme.colors.accent or theme.colors.outline,
            }))
            K.Column({
                modifier = M:fill_max_size():vertical_scroll(scroll):padding(0, 0, 12, 0),
            }, function()
                K.BasicTextField({
                    value = code,
                    syntax = "lua",
                    editable = false,
                    wrap = false,
                    on_focus = function()
                        focused.value = true
                    end,
                    on_defocus = function()
                        focused.value = false
                    end,
                    line_numbers = props.line_numbers == true,
                    font = font,
                    color = theme.colors.text,
                    presentation = props.presentation,
                    lines = max(2, count),
                    pad = pad,
                    scroll_state = scroll,
                    modifier = M:fill_max_width():height(native_height):tag("lua_source"),
                })
                if extra > 0 then
                    K.Spacer(M:height(extra))
                end
            end)
            Scrollbar({
                state = scroll,
            })
        end)
        if props.resizable then
            local function change(delta)
                resized.value = max(lo, min(hi, height + delta))
            end
            Common.with_tooltip(
                "Потяните, чтобы изменить высоту. В фокусе работают стрелки вверх и вниз.",
                function()
                    K.Box({
                        modifier = M:fill_max_width()
                            :height(16)
                            :tag("lua_resize")
                            :hoverable(interaction)
                            :draggable({
                                axis = 2,
                                cursor = "ns-resize",
                                interaction = interaction,
                                on_event = function(e)
                                    if e.type == "move" then
                                        change(e.parent_dy)
                                    end
                                end,
                            })
                            :focusable(function(key)
                                if key == "up" then
                                    change(-lh)
                                elseif key == "down" then
                                    change(lh)
                                end
                            end, {
                                interaction = interaction,
                            }),
                        align = "center",
                    }, function()
                        K.Box({
                            modifier = M:size(48, 2):background(
                                interaction.hovered.value and theme.colors.text
                                    or theme.colors.outline
                            ),
                        })
                    end)
                end
            )
        end
    end)
end)

-- Просмотр Lua с подсветкой и прокруткой; поддерживает строку или таблицу свойств.
-- props: code, title, font, line_numbers, lines, height, height_state, scroll_past_end,
--   resizable, min_height, max_height, presentation, surface, modifier
return function(code, props)
    if type(code) == "table" then
        props, code = code, code.code
    end
    local p = K.copy(props or {})
    p.code = tostring(code or "")
    Viewer(p)
end
