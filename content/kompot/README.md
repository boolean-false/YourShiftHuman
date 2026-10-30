# Kompot

Декларативный UI для VoxelCore в духе Jetpack Compose. Интерфейс описывается
функциями Lua, состояние - наблюдаемыми значениями, а Kompot сам решает,
что перерисовать.

- [Документация по задачам](docs/README.md) и [первый экран](docs/QUICKSTART.md)
- [Справочник API](docs/API.md), [общие правила](docs/CONCEPTS.md) и [полные рецепты](docs/RECIPES.md)
- [Состояние, формы и диагностика хуков](docs/STATE.md)

Ядро `kompot:kompot` не загружает дизайн-систему. Из оформления в нём есть только
нейтральная базовая тема и шрифты IBM Plex; дизайн-система может заменить и то и другое.
В том же паке поставляется **[Kompot UI](docs/UI.md)** (`kompot:ui`) -
игровой набор готовых компонентов: пиксельные поверхности, инвентарь, устройства и HUD.

Можно полностью написать свою [дизайн-систему](docs/DESIGN_SYSTEM.md) или
подключить сторонний пак.

```lua
local K = require "kompot:kompot"
local UI = require "kompot:ui"
local M = K.M

local function Counter()
    local count = K.state(0)
    UI.Panel({
        title = "Счётчик",
    }, function()
        K.Text("Нажато: " .. count.value)
        UI.Button({
            text = "+1",
            variant = "primary",
            on_click = function()
                count.value = count.value + 1
            end,
        })
    end)
end

local ui = K.mount({
    content = Counter,
    theme = UI.theme(),
}) -- поверх экрана
-- ui:dispose()
```

## Пример подключения
```lua
-- поверх экрана (HUD, оверлей)
local ui = K.mount({
    content = App,
})

-- в элемент макета: layouts/panel.xml + panel.xml.lua
function on_open()
    ui = K.mount({
        target = document.root,
        content = App,
        theme = UI.theme(),
    })
end

function on_close()
    ui:dispose()
end
```

`K.mount(opts)` принимает `content`, `target` (контейнер; по умолчанию весь
экран), `theme`, `z_index`, `interactive` (перехват мыши), `keyboard_navigation` и `lock_inventory`.
Возвращает объект с полем `app` и методами `dispose()`, `set_content(fn)`,
`set_theme(theme)`, `is_over(x, y)` - проверкой, находится ли точка экрана над UI.
Размер интерфейса следует за размером контейнера. Кадры обновляются через
его `setInterval`. Для тестов можно подменить ввод:
`handle.fake_input = {x, y, down, wheel}`.

Обход элементов через Tab по умолчанию выключен. Для настроек, редактора
или справочника включите `keyboard_navigation = true`. Без этой опции
обычные кнопки не получают фокус, а текстовые поля и открытые списки
сохраняют своё локальное управление. В F12 навигация включена явно.

По умолчанию `hud.inventory` блокируется при вводе в нативное текстовое поле.
При включённой навигации блокировка также действует для явно заданного
`target`, а без `target` - при наведении или фокусе на интерфейсе.
`lock_inventory = true` включает эту политику блокировки независимо от
навигации, `false` полностью отключает её, например при отрисовке в текстуру.

Вызывайте `dispose()`, когда интерфейс больше не нужен. Если его контейнер
или XML-документ уничтожен без этого вызова, Kompot сам освободит ресурсы
и выполнит очистку эффектов. При обычном скрытии макета состояние сохраняется.


## Преобразования и движение

[Преобразования и движение](docs/MOTION.md): вращение и масштаб, кадровый callback,
перетаскивание и изображения на Canvas.

## Пользовательские шрифты

[Подключение своих шрифтов](docs/FONTS.md).

## Демонстрационная галерея

По дефолту на **F12** доступна встроенная галерея. Демонстрирует возможности с примерами кода

### Текстурные скины
`K.nine_patch` и `M:background_image` задают растягиваемые или повторяемые
фоны с сохранением углов. Kompot UI поставляет четыре редактируемых PNG
для панелей, кнопок и слотов; мод может заменить их через `UI.theme({skin=...})`.
`K.raster` остаётся доступен для процедурных материалов.
Размер окна не требует нового растра: [API и примеры](docs/SKINS.md).


## Лицензия

Kompot - [MPL 2.0](LICENSE).
Шрифты IBM Plex - [OFL 1.1](fonts/IBMPlex-OFL.txt).
Иконка ([SVG](art/icon.svg)) - Dagger, 2026, [CC BY 4.0](LICENSES/CC-BY-4.0.txt).

## Проверки

`python3 tests/run.py` запускает одну основную проверку в одном окне движка.
Подробные проверки выбираются по изменённому механизму; полный набор
запускается явно через `all`. Подробнее: [tests/README.md](tests/README.md).


## TypeScript и VCTS

Пак поставляет декларации API для [VCTS](https://github.com/boolean-false/VCTS). Подключите Kompot командой
`vcts add /path/to/content/kompot`, затем импортируйте `kompot:kompot` и
`kompot:ui`. Сборщик использует исходный Lua-пак без дополнительных обёрток.
Подробности и пример: [VCTS](docs/VCTS.md).
