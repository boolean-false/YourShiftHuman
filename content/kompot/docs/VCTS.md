# TypeScript и VCTS

Kompot поставляет собственные декларации для [VCTS](https://github.com/boolean-false/VCTS). Дополнительный
TypeScript-слой во время исполнения не нужен: код вызывает тот же Lua API.

## Подключение

Из каталога VCTS-проекта выполните:

```sh
vcts add /path/to/content/kompot
npm run check
npm run build
```

VCTS читает `types/vcts.json`, подключает декларации в редакторе и при сборке,
добавляет зависимость пака и фиксирует версии. После обновления Kompot проверьте
изменения API и повторите `vcts add` для обновления фиксации версий.
Исходники Kompot в вашу сборку не копируются; в игре нужен установленный пак.
Для HUD и экранов используйте клиентский профиль VCTS SDK.

Если проект раньше использовал ручные типы из `vendor/external/kompot`,
удалите старые переопределения `dependencies[].types` для Kompot в
`vcts.config.json`, затем повторите `vcts add` с актуальным паком.
VCTS сохраняет ручные переопределения при повторном подключении.

## Пример

```typescript
import * as K from "kompot:kompot";
import * as UI from "kompot:ui";

export const Screen = K.component(() => {
    const count = K.state(0);
    const quality = K.state("medium");

    UI.Panel({
        title: "Настройки",
        width: 360,
    }, () => {
        UI.Button({
            text: "Нажатий: " + count.value,
            on_click: () => count.update(value => value + 1),
        });
        UI.Select({
            options: ["low", "medium", "high"],
            selected: quality.value,
            on_select: value => {
                quality.value = value;
            },
        });
    });
});

K.preview("Настройки", {
    width: 400,
    height: 300,
    theme: UI.theme,
}, Screen);

// Вызывайте при открытии экрана в клиентском коде с готовым HUD.
export function open(this: void): K.MountHandle {
    return K.mount({
        content: Screen,
        theme: UI.theme(),
    });
}
```

При закрытии экрана вызывайте `handle.dispose()`. Декларации передают методы
объектов через `self`, а функции модулей и обработчики событий вызываются без него.
Нужный способ вызова выбирает компилятор; двоеточия в TypeScript не нужны.

## Типы и индексы

Типы доступны через пространства имён импортов: `K.State<number>`,
`K.Modifier`, `K.TransitionState<boolean>`, `UI.ButtonProps`,
`UI.ThemeOptions`, `UI.SelectProps<string>`. Они удаляются при сборке.

У `state`, `new_state`, `form`, `remember`, `component`, `poll`, анимаций
и переходов сохраняются типы значений и параметров. `current_state`, `is_idle`
и `completion` перехода доступны только для чтения. События изменения видимости
и наблюдение за завершением перехода работают так же, как в Lua.

Функции, возвращающие несколько Lua-значений, используют `LuaMultiReturn` из
VCTS SDK. Например:

```typescript
const [fraction, visible] = scroll.fraction();
const [hue, saturation, lightness] = K.color.to_hsl(K.hex("#30BEB3"));
```

Обычные позиционные Lua-таблицы описаны tuple-типами: `source_size: [32, 32]`,
`pivot: [0.5, 0.5]`, варианты Choice `[[1, "Первый"]]`.
При доступе к массиву TypeScript использует индексы от 0 и сам переводит их
в Lua. Числа, которые передаёт API Kompot, остаются индексами Lua от 1:
`Tabs.selected`, `Segmented.selected`, индексы ленивых списков и ячеек инвентаря.
Чтобы прочитать соответствующий элемент TS-массива, используйте `items[index - 1]`.
У Select и Choice `selected` содержит значение варианта, а не индекс.

В `UI.theme().components` допустимы частичные свойства компонентов. `surfaces`,
состояния, варианты, текстуры, формы и `draw` типизированы. Свои расширения темы
и общего контракта `K.ui()` можно описать дополнительными TS-интерфейсами.
Непрозрачные объекты движка представлены `unknown`; перед использованием
требуется их конкретный контракт, а не отключение проверки через `any`.

## Публичные модули

| Импорт | Содержимое |
|---|---|
| `kompot:kompot` | Ядро, модификаторы, состояние, эффекты, анимации, темы, текст, холст и монтирование |
| `kompot:ui` | Полный Kompot UI, включая игровые компоненты и оформление |
| `kompot:kompot/core/scroll` | `new_scroll`, `new_lazy` вне композиции; сохранён прямой импорт прежних проектов |
| `kompot:kompot/backend/inventory_lock` | Аренда блокировки инвентаря для собственного хоста; сохранён прямой импорт прежних проектов |

Остальные внутренние модули не являются обещанием публичного TS API.

## Обновление и проверка

Источники деклараций: `annotations/kompot.lua`, `annotations/ui.lua`,
уточнения `types/refinements.d.ts` и `tools/build_vcts_types.py`.
Генератор сохраняет русские пояснения, проверяет неизвестный синтаксис и
не подменяет пропущенный тип на `any`.

```sh
python3 tools/build_vcts_types.py
python3 tools/build_vcts_types.py --check
node tools/check_vcts_types.cjs --vcts /path/to/vcts
python3 tools/build_ai_guide.py
```

Проверка создаёт временный проект через VCTS, выполняет `add`, проверяет
корректные и ошибочные TS-вызовы, собирает Lua и запускает его с настоящим
Kompot. Сверяются фактические экспорты, методы, колбэки, множественные возвраты,
состояние, эффекты, переходы и холст. Нужны Node.js, зависимости VCTS и Lua;
путь к интерпретатору можно передать через `--lua`.
Она не проверяет графическое монтирование HUD в движке.
