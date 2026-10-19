local Conveyor = require("game:conveyor")

-- Нужно только для обновления модели предметов каждый кадр
function on_hud_render() Conveyor.render() end
