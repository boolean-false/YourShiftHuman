app.set_title("Your Shift, Human.")
app.load_content()
require("game:session").start(app)

while true do
    app.tick()
    require("game:session").update(app)
end
