# Законченные рецепты

Каждый большой блок ниже - отдельный Lua-модуль `modules/<name>.lua`.
Он регистрирует превью Lens и возвращает функции владельца HUD. Вызывать
`open` можно в клиентском коде после открытия HUD, `close` - при закрытии
владельца. Запись превью сама не открывает интерфейс в игре.

Примеры не записывают настройки на диск и не изменяют игровую модель
за пределами показанного состояния. Для подключения файлов и клавиши
открытия используйте [первый экран](QUICKSTART.md).

## Настройки с управляемой моделью

Модель живёт на уровне модуля и сохраняется между открытиями. При нажатии
«Применить» сохраняется снимок, поэтому последующий ввод не меняет его.
Валидация находится у владельца, а не внутри Button или Select.

```lua
local K = require "kompot:kompot"
local UI = require "kompot:ui"
local App = {}
local player = K.new_state("Игрок")
local quality = K.new_state("medium")
local saved = K.new_state("Пока не сохранено")
local handle

local Screen = K.component(function()
    local error = player.value == "" and "Введите имя" or nil
    UI.Panel({
        title = "Настройки",
        width = 360,
    }, function()
        UI.TextField({
            state = player,
            label = "Имя",
            error = error,
        })
        UI.Select({
            options = {
                {
                    value = "low",
                    text = "Низкое",
                },
                {
                    value = "medium",
                    text = "Среднее",
                },
                {
                    value = "high",
                    text = "Высокое",
                },
            },
            selected = quality.value,
            label = "Качество",
            on_select = function(value)
                quality.value = value
            end,
        })
        UI.Button({
            text = "Применить",
            enabled = not error,
            on_click = function()
                saved.value = player:peek() .. ": " .. quality:peek()
            end,
        })
        UI.Hint(saved.value)
    end)
end)

function App.open()
    if not handle or handle.disposed then
        handle = K.mount({
            theme = UI.theme(),
            content = Screen,
            keyboard_navigation = true,
        })
    end
end

function App.close()
    if handle then
        handle:dispose()
        handle = nil
    end
end

K.preview("Рецепт: настройки", {
    width = 420,
    height = 420,
    theme = UI.theme(),
    keyboard_navigation = true,
}, Screen)
return App
```

Для состояния только на время одного открытия используйте `K.state` внутри
Screen вместо `new_state` на уровне модуля. Выделение и историю ввода обычная
строка модели не хранит; для текста и выделения вместе нужен `editor_state`.

## Диалог и действие после анимации выхода

Обработчики только меняют цель. Диалог вызывается каждый раз, включая выход;
эффект наблюдает `completion`. Здесь после закрытия меняется сообщение модели.
Отключение всего HUD после выхода можно выполнить в таком эффекте у владельца,
проверяя ту же пару `is_idle` и `current_state`.

```lua
local K = require "kompot:kompot"
local UI = require "kompot:ui"
local App = {}
local handle

local Screen = K.component(function()
    local visible = K.transition_state(false)
    local status = K.state("Диалог ещё не закрывали")
    K.effect(function()
        if visible.completion > 0 and visible.is_idle and not visible.current_state then
            status.value = "Выход завершён"
        end
    end, visible.completion)
    K.Column({
        spacing = 12,
    }, function()
        UI.Button({
            text = "Открыть подтверждение",
            on_click = function()
                visible.target_state = true
            end,
        })
        UI.Hint(status.value)
    end)
    UI.Dialog({
        visible_state = visible,
        title = "Подтверждение",
        text = "Применить изменения?",
        on_close = function()
            visible.target_state = false
        end,
        confirm = {
            text = "Применить",
            on_click = function()
                status.value = "Изменения приняты; закрываем"
                visible.target_state = false
            end,
        },
        dismiss = {
            text = "Отмена",
        },
    })
end)

function App.open()
    if not handle or handle.disposed then
        handle = K.mount({
            theme = UI.theme(),
            content = Screen,
        })
    end
end
function App.close()
    if handle then
        handle:dispose()
        handle = nil
    end
end
K.preview("Рецепт: диалог", {
    width = 600,
    height = 400,
    theme = UI.theme(),
}, Screen)
return App
```

`confirm` не закрывает окно автоматически: здесь это сделано явно.
`dismiss` вызывает запрос отмены; при отсутствии `on_dismiss` используется
`on_close`. Условие `if visible.target_state then UI.Dialog(...) end` удалило
бы компонент до завершения выхода и нарушило бы замысел примера.

## Большой список со стабильными ключами

Фильтрация строит новый видимый набор, но ID записей остаются прежними.
`remember` пересчитывает фильтр только при изменении запроса или исходных данных;
`LazyColumn` создаёт содержимое нужной части списка.

```lua
local K = require "kompot:kompot"
local UI = require "kompot:ui"
local M = K.M
local App = {}
local handle

local Screen = K.component(function()
    local query = K.state("")
    local selected = K.state(nil)
    local items = K.remember(function()
        local result = {}
        for i = 1, 10000 do
            result[i] = {
                id = i,
                name = "Запись " .. i,
            }
        end
        return result
    end)
    local text = query.value
    local visible = K.remember(function()
        local result = {}
        for _, item in ipairs(items) do
            if text == "" or item.name:find(text, 1, true) then
                result[#result + 1] = item
            end
        end
        return result
    end, text)
    local scroll = K.lazy_state()
    K.Column({
        modifier = M:fill_max_size(),
        spacing = 8,
    }, function()
        UI.TextField({
            state = query,
            label = "Поиск",
        })
        UI.Hint("Найдено: " .. #visible)
        K.LazyColumn({
            modifier = M:fill_max_width():weight(1),
            state = scroll,
            count = #visible,
            key_of = function(index)
                return visible[index].id
            end,
            item = function(index)
                local item = visible[index]
                UI.Button({
                    text = item.name,
                    selected = selected.value == item.id,
                    on_click = function()
                        selected.value = item.id
                    end,
                })
            end,
        })
    end)
end)

function App.open()
    if not handle or handle.disposed then
        handle = K.mount({
            theme = UI.theme(),
            content = Screen,
        })
    end
end
function App.close()
    if handle then
        handle:dispose()
        handle = nil
    end
end
K.preview("Рецепт: список", {
    width = 480,
    height = 500,
    theme = UI.theme(),
}, Screen)
return App
```

Поиск здесь буквальный и чувствительный к регистру; это намеренно простой
контракт. `count` относится к видимому набору, `key_of` - к ID модели.
Если в данных нет устойчивых ID, сначала определите их у владельца.

## Другие законченные сценарии

| Сценарий | Где смотреть | Существенное ограничение |
|---|---|---|
| Фоновая иллюстрация с cover | [Изображения и скины](SKINS.md#картинка-фоном-на-весь-экран) | Нужны загруженный ресурс и source_size |
| Перенос предметов между ячейками | [Игровые компоненты](GAME_UI.md#простая-сетка-инвентаря) | Модель проверяет и выполняет перенос |
| Окно с изменяемыми bounds | [Окна](UI.md#перемещение-и-изменение-размеров-окон) | При внешних bounds обновляйте их через событие |
| Действие после нескольких анимаций | [Переходы](MOTION.md#состояние-перехода-и-действия-после-анимации) | Каналы относятся к одной группе и области |
| Собственное оформление Button | [Поверхности](UI.md#оформление-компонентов) | draw меняет рисунок, а не поведение и ввод |
| Модель текста и выделения | [Текстовый ввод](TEXT_INPUT.md#состояние-редактора-и-собственная-отрисовка) | Нужен совместимый нативный textbox |
| Свой шрифт | [Шрифты](FONTS.md#как-подключить-свой-шрифт) | Зарегистрируйте ресурсы всех используемых размеров |
