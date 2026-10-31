local K = require("kompot:kompot")
local E = require("game:ui/components")
local Parts = require("game:ui/menu_parts")
local Theme = require("game:ui/theme")
local C = Theme.colors

local Body = K.component(function(p)
    Parts.text("ОБОРУДОВАНИЕ", "caption", C.muted)
    Parts.text(p.title, "title")
    if p.status then
        Parts.text(p.status, "body", C.blue)
    end
    if p.detail and p.detail ~= "" then
        Parts.text(p.detail, "caption", C.muted)
    end
    if p.kind == "press" then
        K.Row({ spacing = 8 }, function()
            E.button("ШЕСТЕРЁНКА", function()
                p.on_recipe("gear")
            end, 128, p.recipe == "gear" and "yellow" or "secondary", not p.completed)
            E.button("ВАЛ", function()
                p.on_recipe("rod")
            end, 128, p.recipe == "rod" and "yellow" or "secondary", not p.completed)
        end)
    elseif p.kind == "splitter" then
        Parts.text("ПОТОК / НАЛЕВО : НАПРАВО", "caption", C.muted)
        K.Row({ spacing = 6 }, function()
            for i, ratio in ipairs({ "1:1", "2:1", "1:2" }) do
                local index = i
                E.button(ratio, function()
                    p.on_ratio(index)
                end, 84, p.ratio == i and "yellow" or "secondary", not p.completed)
            end
        end)
    elseif p.kind == "filter" then
        Parts.text("Налево: выбранная деталь\nНаправо: остальные", "body", C.muted)
        E.button("НАЛЕВО: " .. p.product, p.on_cycle, nil, "yellow", not p.completed)
    elseif p.kind == "source" or p.kind == "sink" then
        if p.editing then
            E.button((p.kind == "source" and "ПОДАЧА: " or "ПРИНИМАТЬ: ") .. p.product,
                p.on_cycle, nil, "yellow")
        else
            Parts.text((p.kind == "source" and "Подаёт: " or "Принимает: ") .. p.product, "body", C.blue)
        end
    end
    if p.transport then
        K.Row({ spacing = 8 }, function()
            E.button("R / ПОВЕРНУТЬ", p.on_rotate, 128, "secondary", not p.completed)
            E.button("ПЕРЕНЕСТИ", p.on_move, 128, "secondary", not p.completed)
        end)
        E.button("УБРАТЬ", p.on_remove, nil, "danger", not p.completed)
    elseif p.kind == "press" or p.kind == "smelter" or p.kind == "assembler" then
        Parts.text("СТАНОК НЕЛЬЗЯ ПЕРЕМЕЩАТЬ", "caption", C.muted)
    end
    E.button("ЗАКРЫТЬ", p.on_close, nil, "secondary")
end)

local Equipment = K.component(function(p)
    local scroll = K.scroll_state()
    if not p.visible then
        return
    end
    if p.editing then
        E.modal({ visible = true, w = p.w, h = p.h, width = 400, height = 440 }, function()
            Body(p)
        end)
    else
        E.panel({ x = p.w - 320, y = 140, width = 300, max_height = math.max(1, p.h - 292) }, function()
            K.Column({ spacing = 10, modifier = K.M:fill_max_width():vertical_scroll(scroll) }, function()
                Body(p)
            end)
        end)
    end
end)

K.preview("Пресс", { width = 900, height = 760, padding = 0, theme = Theme.theme, group = "Оборудование" }, function()
    Equipment({ visible = true, w = 900, h = 760, title = "Пресс", kind = "press", status = "Работает", detail = "Выпуск: Шестерёнка / до 120 шт/мин\nСлиток 3/4", recipe = "gear", on_recipe = function()
    end })
end)
K.preview("Плавильня", { width = 900, height = 760, padding = 0, theme = Theme.theme, group = "Оборудование" }, function()
    Equipment({ visible = true, w = 900, h = 760, title = "Плавильня", kind = "smelter", status = "Ожидает: Руда", detail = "Выпуск: Слиток / до 60 шт/мин\nРуда 0/4" })
end)
K.preview("Сборщик", { width = 900, height = 760, padding = 0, theme = Theme.theme, group = "Оборудование" }, function()
    Equipment({ visible = true, w = 900, h = 760, title = "Сборщик", kind = "assembler", status = "Работает", detail = "Выпуск: Редуктор / до 30 шт/мин\nШестерёнка 4/4 · Вал 2/4" })
end)
K.preview("Разделитель", { width = 900, height = 760, padding = 0, theme = Theme.theme, group = "Оборудование" }, function()
    Equipment({ visible = true, w = 900, h = 760, title = "Разделитель", kind = "splitter", ratio = 1, transport = true, on_ratio = function()
    end })
end)
K.preview("Фильтр", { width = 900, height = 760, padding = 0, theme = Theme.theme, group = "Оборудование" }, function()
    Equipment({ visible = true, w = 900, h = 760, title = "Фильтр", kind = "filter", product = "Слиток", transport = true })
end)
K.preview("Подача", { width = 700, height = 600, padding = 0, theme = Theme.theme, group = "Оборудование" }, function()
    Equipment({ visible = true, editing = true, w = 700, h = 600, title = "Подача", kind = "source", product = "Руда" })
end)
K.preview("Приёмка", { width = 700, height = 600, padding = 0, theme = Theme.theme, group = "Оборудование" }, function()
    Equipment({ visible = true, editing = true, w = 700, h = 600, title = "Приёмка", kind = "sink", product = "Шестерёнка" })
end)
return Equipment
