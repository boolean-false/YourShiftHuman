local Session = require("game:session")
local M = {}

function M.open(app, index)
    local name = tostring(index)
    local folder = "user:worlds/" .. name
    if not file.isfile(folder .. "/world.json") then
        if file.isfile("game:levels/" .. name .. ".zip") then
            Session.copy_level(index, folder)
        else
            app.new_world(name, name, "game:room")
            app.save_world()
            return
        end
    end
    local path = folder .. "/packs.list"
    local packs = file.readlines(path)
    local found = false
    for _, id in ipairs(packs) do
        if id == "editor" then
            found = true
        end
    end
    if not found then
        packs[#packs + 1] = "editor"
        file.write(path, table.concat(packs, "\n") .. "\n")
    end
    app.open_world(name)
end

function M.export(index)
    local memory = file.create_memory_device()
    local ok, err = pcall(function()
        Session.copy_level(index, memory .. ":")
        Session.strip_editor(memory .. ":")
        file.mkdirs("export:levels")
        file.create_zip(memory .. ":", "export:levels/" .. index .. ".zip")
    end)
    file.unmount(memory)
    if not ok then
        error(err)
    end
end

return M
