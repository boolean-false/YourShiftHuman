local UI = require("kompot:ui")
local M = {}

M.colors = {
    background = "#17262B", paper = "#F7F3E8", white = "#FFFFFF",
    ink = "#292B35", blue = "#3054DF", blue_dark = "#203AA4",
    muted = "#777B82", line = "#D5D3CB", yellow = "#FFD552", quiet = "#E8E5DC",
    red = "#DE543E", green = "#32745C", pale = "#E8EDFC"
}

local C = M.colors
M.theme = UI.theme({
    name = "Your Shift, Human",
    dark = false,
    colors = {
        background = C.background, surface = C.paper, surface_raised = C.quiet,
        on_surface = C.ink, primary = C.blue, on_primary = C.white,
        muted = C.muted, outline = C.line, panel_bg = C.paper
    },
    type = {
        body = { font = "kompot_14", size = 14 },
        caption = { font = "kompot_mono_11", size = 11 },
        label = { font = "kompot_sb_14", size = 14 },
        title = { font = "kompot_sb_20", size = 20 },
        heading = { font = "kompot_sb_32", size = 32 },
        display = { font = "kompot_sb_44", size = 44 },
        mono = { font = "kompot_mono_14", size = 14 }
    },
    shapes = { control = 8, panel = 12, card = 12, field = 8 },
    metrics = { control = 44, press_offset = 0, button_pad = 13 },
    components = { Button = { align = "start", text_style = "label", variant = "secondary" } },
    surfaces = {
        default = { skin = false, border_width = 0 },
        button = {
            color = C.quiet, content_color = C.ink,
            states = {
                hovered = { color = "#D9D9D3" },
                pressed = { color = "#CECEC7" },
                disabled = { color = "#E2E0D9", content_color = "#A1A19C" }
            },
            variants = {
                yellow = {
                    color = C.yellow, content_color = C.ink,
                    states = { hovered = { color = "#FFE483" }, pressed = { color = "#E9BD37" } }
                },
                danger = {
                    color = C.red, content_color = C.white,
                    states = { hovered = { color = "#C74331" }, pressed = { color = "#AD3829" } }
                },
                primary = {
                    color = C.blue, content_color = C.white,
                    states = {
                        hovered = { color = C.blue_dark },
                        pressed = { color = "#182C82" }
                    }
                }
            }
        }
    }
})

return M
