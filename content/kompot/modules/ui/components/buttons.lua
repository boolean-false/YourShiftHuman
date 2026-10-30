local K = require "kompot:kompot"
local T = require "kompot:ui/tokens"
local Common = require "kompot:ui/components/common"
local Skin = require "kompot:ui/skin"
local M = K.M
local C = {}
local sizes = {
    sm = "control_sm",
    md = "control",
    lg = "control_lg",
}
-- Кнопка со своим оформлением; фон не меняет область нажатия.
-- props: text, icon, on_click, on_right_click, variant ("default"|"primary"|"secondary"|"danger"|"ghost"|"toggle"),
--   enabled, selected, focusable, size ("sm"|"md"|"lg"), align ("start"|"center"),
--   trailing, compact, min_width, press_offset, padding, spacing, text_style,
--   icon_size, radius, surface, tooltip, modifier
C.Button = K.component(function(p, content)
    p = T.props("Button", p)
    local t, inter = T.current(), K.interaction()
    local c, mt = t.colors, t.metrics
    local enabled, selected = p.enabled ~= false, p.selected
    local base, hover, pressed = Common.variant_colors(c, p.variant, selected)
    if not enabled then
        base = c.disabled_bg
    end
    local bg = Common.state_color(base, hover, pressed, inter, enabled)
    local fg = not enabled and c.disabled_fg or c.text
    if enabled and (p.variant == "primary" or selected) then
        fg = K.color.on(bg, c.shadow, c.bright)
    end
    local down = enabled and inter.pressed.value
    local surface = Skin.resolve({
        role = "button",
        kind = "button",
        variant = p.variant,
        color = bg,
        content_color = fg,
        shape = t.shapes.control,
        shape_override = p.radius,
        hovered = inter.hovered.value,
        pressed = down,
        focused = inter.focused.value,
        selected = selected,
        enabled = enabled,
        edge = c.primary,
        surface = p.surface,
    })
    fg = surface.content_color or fg
    local shift = p.press_offset or surface.press_offset or mt.press_offset

    Common.with_tooltip(p.tooltip, function()
        K.Box({
            modifier = (p.modifier or M)
                :height(
                    type(p.size) == "number" and p.size or mt[sizes[p.size or "md"]] or mt.control
                )
                :width_in(p.min_width or 0, 100000)
                :clickable(p.on_click, {
                    interaction = inter,
                    enabled = enabled,
                    focusable = p.focusable,
                    on_right_click = p.on_right_click,
                    focus_color = surface.focus_color or c.primary,
                    focus_shape = surface.shape,
                }),
            align = p.align == "start" and "center_start" or "center",
        }, function()
            surface.resolved = true
            Skin.Surface(surface)
            K.Row({
                modifier = M:fill_max_height()
                    :offset(0, down and shift or 0)
                    :padding(p.padding or (p.compact and 6 or mt.button_pad), 0),
                spacing = p.spacing or mt.gap,
                align = "center",
                arrangement = p.align == "start" and "start" or "center",
            }, function()
                K.ContentColor(fg, function()
                    if p.icon then
                        Common.any_icon(p.icon, p.icon_size or 16, fg)
                    end
                    if content then
                        content()
                    elseif p.text then
                        K.Text(p.text, {
                            style = surface.text_style or p.text_style or t.type.body,
                            color = fg,
                            wrap = false,
                            modifier = p.trailing and M:weight(1) or nil,
                        })
                    end
                    if p.trailing then
                        K.Text(p.trailing, {
                            style = t.type.caption,
                            color = fg,
                            wrap = false,
                        })
                    end
                end)
            end)
        end)
    end)
end)
return C
