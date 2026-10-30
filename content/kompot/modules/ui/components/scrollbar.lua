local K = require "kompot:kompot"
local T = require "kompot:ui/tokens"
local Skin = require "kompot:ui/skin"
local Common = require "kompot:ui/components/common"
local M, Box, mods = K.M, K.Box, Common.mods

return K.component(function(props)
    props = T.props("Scrollbar", props)
    local c = T.current().colors
    local st = props.state
    local frac, visible = st:fraction()
    local height = K.state(100)
    local inter = K.interaction()
    local active = inter.hovered.value or inter.dragged.value
    local hh = height.value
    local thumb_h = math.max(20, math.floor(hh * visible))
    local y = math.floor((hh - thumb_h) * frac)
    if visible >= 0.999 then
        return
    end
    Box({
        modifier = mods(props):width(8):fill_max_height():align("top_end"):on_size(function(_, h)
            height.value = h
        end),
    }, function()
        Box({
            modifier = M:offset(0, y):size(8, thumb_h):draggable({
                interaction = inter,
                on_event = function(e)
                    if e.type ~= "move" then
                        return
                    end
                    local track = height:peek() - thumb_h
                    if track > 0 then
                        local range = (st.max or ((st.total or 0) - (st.view or 0)))
                        st:scroll_by(e.parent_dy / track * range)
                    end
                end,
            }),
            align = "center_end",
        }, function()
            Box({
                modifier = M:size(active and 6 or 4, thumb_h),
            }, function()
                Skin.Surface(Common.surface("scrollbar_thumb", "panel", props, inter, {
                    skin = false,
                    color = active and c.accent or c.hover,
                }))
            end)
        end)
    end)
end)
