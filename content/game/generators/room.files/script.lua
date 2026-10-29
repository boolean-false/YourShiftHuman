local room = json.parse(file.read("game:room.json"))
local area = room.areas[SEED] or room

-- Тут только коробка без крыши
function place_structures(x, z, w, d)
    local result = {}
    local floor = block.index("game:build_floor")
    local wall = block.index("game:build_wall")
    local locked = block.index("game:build_locked")
    for bx = math.max(x, -1), math.min(x + w - 1, room.width) do
        for bz = math.max(z, -1), math.min(z + d - 1, room.depth) do
            local edge = bx == -1 or bx == room.width or bz == -1 or bz == room.depth
            local open = bx >= 0 and bx < area.width and bz >= 0 and bz < area.depth
            local tile = edge and wall or open and floor or locked
            result[#result + 1] = { ":block", tile, { bx, room.floor, bz } }
            if bz == -1 then
                for y = 1, room.wall_height do
                    result[#result + 1] = { ":block", wall, { bx, room.floor + y, bz } }
                end
            end
        end
    end
    return result
end
