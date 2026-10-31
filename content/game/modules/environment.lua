local M = {}

function M.configure(app)
    app.set_setting("graphics.enable-fog", false)
end

function M.open()
    world.set_day_time(.5)
    world.set_day_time_speed(0)
end

function M.apply(gfx)
    local weather = {
        sky_tint = { .14, .19, .21 },
        clouds = 0,
        fog_opacity = 0,
        min_sky_light = { 1, 1, 1 }
    }
    -- Меняем оба состояния, чтобы на паузе не осталось старое небо
    gfx.weather.change(weather, 0)
    gfx.weather.change(weather, 0)
end

return M
