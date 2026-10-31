app.set_title("Your Shift, Human.")
app.load_content()
require("game:environment").configure(app)
require("game:session").start(app)
local music = { volume = 0 }

while true do
    app.tick()
    if not app.is_content_loaded() then
        app.load_content()
        require("game:session").start(app)
    end
    require("game:ui/state").update(time.delta())
    require("game:sound").update(music, time.delta())
    require("game:session").update(app)
end
