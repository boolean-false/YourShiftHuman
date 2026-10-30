-- Общие функции для групп компонентов Kompot UI.

local K = require "kompot:kompot"
local T = require "kompot:ui/tokens"

local Skin = require "kompot:ui/skin"
local M = K.M
local color = K.color
local Box, Text, Image = K.Box, K.Text, K.Image

local Common = {}

function Common.mods(props)
    return props.modifier or M
end

function Common.state_color(base, hover, pressed, inter, enabled)
    local target = base
    if enabled ~= false and inter then
        if inter.pressed.value then
            target = pressed or hover
        elseif inter.hovered.value then
            target = hover
        end
    end
    return target
end

-- Общий снимок оформления не меняет размеры и обработчики компонента.
function Common.surface(role, kind, props, inter, params)
    local p, theme = params or {}, T.current()
    props = props or {}
    p.role, p.kind = role, kind
    p.surface = props.surface
    p.variant = props.variant
    p.shape_override = props.radius
    if p.enabled == nil then
        p.enabled = props.enabled ~= false
    end
    if p.selected == nil then
        p.selected = props.selected
    end
    if p.error == nil then
        p.error = not not props.error
    end
    if p.shape == nil then
        local shapes = {
            panel = "panel",
            card = "card",
            field = "field",
            code = "field",
            menu = "panel",
            tooltip = "panel",
            toast = "panel",
            slot = "field",
        }
        p.shape = theme.shapes[shapes[role] or "control"]
    end
    if inter then
        p.hovered = p.enabled and inter.hovered.value
        p.pressed = p.enabled and inter.pressed.value
        p.dragged = p.enabled and inter.dragged.value
        p.focused = inter.focused.value
    end
    return Skin.resolve(p)
end

function Common.any_icon(src, size, tint)
    if src:find(":", 1, true) then
        Image(src, {
            size = size,
            color = tint,
        })
    else
        Skin.Icon(src, size, tint)
    end
end

Common.Tooltip = K.component(function(props, content)
    props = T.props("Tooltip", props)
    local c = T.current().colors
    local inter = K.interaction()
    local hovered = inter.hovered.value
    local ready = K.after(props.delay or 0.45, hovered and "on" or "off")
    local show = not props.suppressed and hovered and ready and props.text and props.text ~= ""
    Box({
        modifier = Common.mods(props):hoverable(inter),
    }, function()
        content()
        if show then
            K.Popup({
                placement = props.placement or "below",
                gap = 4,
                z = 30,
            }, function()
                Box({
                    modifier = M:width_in(0, props.max_width or 360),
                }, function()
                    Skin.Surface(Common.surface("tooltip", "panel", props, nil, {
                        color = c.toast_bg,
                    }))
                    Text(props.text, {
                        style = T.current().type.caption,
                        color = c.text,
                        markup = "md",
                        modifier = M:padding(10, 8),
                    })
                end)
            end)
        end
    end)
end)

function Common.with_tooltip(tip, content)
    if tip and tip ~= "" then
        Common.Tooltip({
            text = tip,
        }, content)
    else
        content()
    end
end

function Common.variant_colors(c, variant, selected)
    if selected then
        return c.action, c.action_hover, c.pressed
    elseif variant == "primary" then
        return c.action, c.action_hover, c.pressed
    elseif variant == "danger" then
        return c.danger, c.danger_hover, c.danger
    elseif variant == "toggle" then
        return c.control, c.hover, c.pressed
    elseif variant == "ghost" then
        return color.with_alpha(c.control, 0), c.hover, c.pressed
    end
    return c.control, c.hover, c.pressed
end

return Common
