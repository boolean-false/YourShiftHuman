local K = require("kompot:kompot")
local State = require("game:ui/state")
local Session = require("game:session")
local Hover = require("game:hover")
local Camera = require("game:camera")
local Press = require("game:press")
local Smelter = require("game:smelter")
local Assembler = require("game:assembler")
local Source = require("game:source")
local Sink = require("game:sink")
local Build = require("game:build")
local Badge = require("game:ui/port_badge")
local C = require("game:ui/theme").colors
local machines = {
    ["game:press"] = Press,
    ["game:smelter"] = Smelter,
    ["game:assembler"] = Assembler
}

local function label(x, y, z, text, color, width)
    local px, py = Camera.project(x, y, z)
    local view = gui.get_viewport()
    width = width or 40
    if not px then
        return
    end
    if px < width / 2 or px > view[1] - width / 2 then
        return
    end
    if py < 130 or py > view[2] - 160 then
        return
    end
    K.Box({ modifier = K.M:offset(px - width / 2, py) }, function()
        Badge({ text = text, color = color, width = width })
    end)
end

-- Сдвигаем подпись от центра клетки к нужному краю.
local function port_label(x, y, z, dx, dz, text, color)
    local label_x = x + .5 + dx * .47
    local label_z = z + .5 + dz * .47
    label(label_x, y + .3, label_z, text, color)
end

local function machine_ports(machine, x, y, z)
    local dx, _, dz = block.get_Z(x, y, z)
    local input_x, input_y, input_z = machine.port(x, y, z, false)
    port_label(input_x, input_y, input_z, -dx, -dz, "ВХ", C.green)

    local output_x, output_y, output_z = machine.port(x, y, z, true)
    port_label(output_x, output_y, output_z, dx, dz, "ВЫХ", C.blue)

    if machine == Assembler then
        local second_x, second_y, second_z = machine.port(x, y, z, false, true)
        port_label(second_x, second_y, second_z, -dx, -dz, "ВХ", C.green)
    end
end

return K.component(function()
    local frame = K.poll(function()
        return { State.clock, Hover.selected, Session.editing }
    end)
    if Session.editing or Session.pause_open or State.page ~= "" then
        return
    end
    for _, source in pairs(Source.locations()) do
        if block.get(source.x, source.y, source.z) == block.index("game:source") then
            label(source.x + .5, source.y + 2.5, source.z + .5, "ПОДАЧА / " .. Source.caption(Source.get_type(source.x, source.y, source.z)), nil, 170)
        end
    end
    for _, sink in pairs(Sink.locations()) do
        if block.get(sink.x, sink.y, sink.z) == block.index("game:sink") then
            local index = Sink.get_type(sink.x, sink.y, sink.z)
            local caption = index == 1 and "ПРИЁМКА ПРОДУКЦИИ" or "ПРИЁМКА / " .. Sink.caption(index)
            label(sink.x + .5, sink.y + 2.5, sink.z + .5, caption, nil, 170)
        end
    end
    if Build.tool then
        for _, controller in ipairs({ Press, Smelter, Assembler }) do
            for _, machine in pairs(controller.locations()) do
                local x, y, z = machine.x, machine.y, machine.z
                if block.get(x, y, z) == block.index(controller.block_name) then
                    machine_ports(controller, x, y, z)
                end
            end
        end
    end
    local object = Hover.selected
    if not object then
        return
    end
    local x, y, z = object.x, object.y, object.z
    local name = block.name(object.id)
    local machine = machines[name]
    local size = machine and 2 or 1
    if name ~= "game:source" and name ~= "game:sink" then
        -- Центр станка зависит от того, куда он повёрнут.
        local right_x, _, right_z = block.get_X(x, y, z)
        local forward_x, _, forward_z = block.get_Z(x, y, z)
        local half = (size - 1) / 2
        local center_x = x + .5 + (right_x + forward_x) * half
        local center_z = z + .5 + (right_z + forward_z) * half
        label(center_x, y + 2.5, center_z, block.caption(object.id), nil, 170)
    end
    local dx, _, dz = block.get_Z(x, y, z)
    if machine then
        machine_ports(machine, x, y, z)
    elseif name == "game:splitter" or name == "game:filter" then
        port_label(x, y, z, -dx, -dz, "ВХ", C.green)
        port_label(x, y, z, dz, -dx, "П", C.blue)
        port_label(x, y, z, -dz, dx, "Л", C.green)
    end
end)
