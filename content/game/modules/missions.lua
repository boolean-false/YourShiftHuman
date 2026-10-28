local transport = {
    ["game:conveyor"] = true,
    ["game:splitter"] = true,
    ["game:merger"] = true
}

return {
    {
        title = "Тестовое задание 1",
        goals = { gear = 60 },
        allowed = transport
    },
    {
        title = "Тестовое задание 2",
        goals = { rod = 60 },
        allowed = transport
    },
    {
        title = "Тестовое задание 3",
        goals = { gearbox = 30 },
        allowed = transport
    }
}
