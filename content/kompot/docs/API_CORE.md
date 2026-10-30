# API: Ядро и объекты Kompot

<!-- Сгенерировано tools/build_api_reference.py. Редактируйте данные и annotations/. -->

[Выбор API и навигация](API.md) · [Общие правила](CONCEPTS.md) · [Все типы](API_TYPES.md) · [Рецепты](RECIPES.md)

`?` в сигнатуре означает необязательность, а не конкретное значение по умолчанию. В таблицах сохранены имена из LuaLS. Для обёрток общий базовый тип шире фактически передаваемых свойств: ограничения карточки имеют приоритет.

## Содержание

- [Ядро](#api-K)
- [Модификаторы](#api-M)
- [Формы](#api-K-Shape)
- [Цвет](#api-K-color)
- [Шрифты](#api-K-fonts)
- [Расчёт текста](#api-K-text)
- [Объект State](#api-state)
- [Локальное значение](#api-local-value)
- [Состояние перехода](#api-transition-state)
- [Группа перехода](#api-transition)
- [Обычная прокрутка](#api-scroll)
- [Ленивая прокрутка](#api-lazy)
- [Смонтированный интерфейс](#api-handle)
- [Конструктор приложения](#api-K-App)
- [Кадровый цикл](#api-app)
- [Рисование на холсте](#api-canvas)
- [Измерение собственной раскладки](#api-measure-api)
- [Измеритель текста](#api-measurer)

<a id="api-K"></a>
## Ядро

[K.copy](#api-K-copy) · [K.rounded_corners](#api-K-rounded-corners) · [K.nine_patch](#api-K-nine-patch) · [K.raster](#api-K-raster) · [K.Box](#api-K-Box) · [K.Row](#api-K-Row) · [K.Column](#api-K-Column) · [K.FlowRow](#api-K-FlowRow) · [K.Spacer](#api-K-Spacer) · [K.Text](#api-K-Text) · [K.Image](#api-K-Image) · [K.Icon](#api-K-Icon) · [K.Canvas](#api-K-Canvas) · [K.Layout](#api-K-Layout) · [K.TextInput](#api-K-TextInput) · [K.BasicTextField](#api-K-BasicTextField) · [K.new_text_field_state](#api-K-new-text-field-state) · [K.text_field_state](#api-K-text-field-state) · [K.scroll_state](#api-K-scroll-state) · [K.lazy_state](#api-K-lazy-state) · [K.LazyColumn](#api-K-LazyColumn) · [K.LazyRow](#api-K-LazyRow) · [K.LazyGrid](#api-K-LazyGrid) · [K.Popup](#api-K-Popup) · [K.state](#api-K-state) · [K.form](#api-K-form) · [K.new_state](#api-K-new-state) · [K.remember](#api-K-remember) · [K.effect](#api-K-effect) · [K.on_dispose](#api-K-on-dispose) · [K.on_frame](#api-K-on-frame) · [K.key](#api-K-key) · [K.component](#api-K-component) · [K.provide](#api-K-provide) · [K.local_of](#api-K-local-of) · [K.untracked](#api-K-untracked) · [K.is_state](#api-K-is-state) · [K.poll](#api-K-poll) · [K.animate](#api-K-animate) · [K.transition_state](#api-K-transition-state) · [K.new_transition_state](#api-K-new-transition-state) · [K.transition](#api-K-transition) · [K.tween](#api-K-tween) · [K.spring](#api-K-spring) · [K.clock](#api-K-clock) · [K.after](#api-K-after) · [K.runtime](#api-K-runtime) · [K.interaction](#api-K-interaction) · [K.new_interaction](#api-K-new-interaction) · [K.rgb](#api-K-rgb) · [K.hex](#api-K-hex) · [K.theme](#api-K-theme) · [K.Theme](#api-K-Theme) · [K.ContentColor](#api-K-ContentColor) · [K.TextStyle](#api-K-TextStyle) · [K.style](#api-K-style) · [K.extend_theme](#api-K-extend-theme) · [K.ui](#api-K-ui) · [K.args](#api-K-args) · [K.preview](#api-K-preview) · [K.previews](#api-K-previews) · [K.mount](#api-K-mount)

| Значение | Тип | Назначение |
|---|---|---|
| `K.VERSION` | `string` | Версия ядра Kompot. Не путайте с внутренней версией дизайн-системы UI.VERSION. |
| `K.Modifier` | `KompotModifier` | Алиас K.M; не конструктор с new. |
| `K.M` | `KompotModifier` | Пустая неизменяемая цепочка Modifier, отправная точка для M:size(...). |
| `K.Shape` | `KompotShapeApi` | Конструкторы форм; точные методы перечислены ниже. |
| `K.snap` | `KompotSnap` | Готовая спецификация мгновенного перехода. Передаётся как значение, без вызова K.snap(). |
| `K.EASING` | `table<string, fun(t: number): number>` | Имена кривых: linear, in_quad, out_quad, in_out_quad, in_cubic, out_cubic, in_out_cubic, out_back, out_elastic, standard. Передаются в tween строкой. |
| `K.color` | `KompotColorApi` | Чистые вычисления цвета; rgb и hex также доступны как K.rgb и K.hex. |
| `K.fonts` | `KompotFontApi` | Реестр загруженных семейств и их метрик; не загрузчик файлов. |
| `K.BASE_THEME` | `KompotTheme` | Нейтральная тема ядра без готового контракта UI. Для встроенных компонентов задайте UI.theme(). |
| `K.LocalTheme` | `KompotLocal<KompotTheme>` | Ключ локальной текущей темы. |
| `K.LocalContentColor` | `KompotLocal<KompotColor>` | Ключ локального цвета содержимого. |
| `K.LocalTextStyle` | `KompotLocal<KompotTextStyle>` | Ключ локального текстового стиля. |
| `K.App` | `KompotApp` | Низкоуровневый конструктор приложения для собственного цикла; для HUD используйте mount. |
| `K.text` | `KompotTextApi` | Измерение и раскладка текста для ядра и внешних рендереров. |

<a id="api-K-copy"></a>
### `K.copy`

Создаёт поверхностную копию Lua-таблицы с необязательной заменой и добавлением полей. Вложенные значения остаются общими; метатаблица не переносится.

**Сигнатура:** `K.copy<T>(source: T, changes?: table): T`

**Контракт:** Чтение state.value подписывает область, state:peek() читает без подписки. Хуки вызываются в неизменном порядке; функции new_* и copy можно вызывать вне композиции.

**Руководство:** [сценарий и примеры](STATE.md).

**F12:** Обновление полей State.

<a id="api-K-rounded-corners"></a>
### `K.rounded_corners`

Копирует и проверяет радиусы отдельных углов в пикселях. Для процентов и срезанных углов используйте Shape.

**Сигнатура:** `K.rounded_corners(radius?: KompotRadius): KompotRadius`

**Контракт:** Имя texture/path обозначает текстуру, atlas:sprite - спрайт. Это не require pack:module. Ресурс должен быть загружен; source_size относится к PNG или спрайту.

**Параметры и результат:** [KompotRadius](API_TYPES.md#type-kompotradius).

**Руководство:** [сценарий и примеры](SKINS.md).

**F12:** Радиус каждого угла.

<a id="api-K-nine-patch"></a>
### `K.nine_patch`

Описывает рамку из девяти частей или повторяющуюся фактуру. Передаётся в background_image; не поддерживает fit и не заменяет Image с cover.

**Сигнатура:** `K.nine_patch(source: string|KompotRaster, opts?: KompotNinePatchOptions): KompotNinePatch`

**Начальные значения:** border=0, center="stretch", edges="stretch", scale=1; для строкового источника source_size обязателен.

**Контракт:** Имя texture/path обозначает текстуру, atlas:sprite - спрайт. Это не require pack:module. Ресурс должен быть загружен; source_size относится к PNG или спрайту.

**Параметры и результат:** [KompotNinePatch](API_TYPES.md#type-kompotninepatch), [KompotNinePatchOptions](API_TYPES.md#type-kompotninepatchoptions), [KompotRaster](API_TYPES.md#type-kompotraster).

**Руководство:** [сценарий и примеры](SKINS.md).

**F12:** Nine-patch: рамки и повторение.

<a id="api-K-raster"></a>
### `K.raster`

Описывает процедурный источник пикселей для nine-patch и Canvas:image. key идентифицирует ресурс, version меняется при изменении исходных пикселей.

**Сигнатура:** `K.raster(opts: KompotRasterOptions): KompotRaster`

**Контракт:** Имя texture/path обозначает текстуру, atlas:sprite - спрайт. Это не require pack:module. Ресурс должен быть загружен; source_size относится к PNG или спрайту.

**Параметры и результат:** [KompotRaster](API_TYPES.md#type-kompotraster), [KompotRasterOptions](API_TYPES.md#type-kompotrasteroptions).

**Руководство:** [сценарий и примеры](SKINS.md).

**F12:** Nine-patch: рамки и повторение.

<a id="api-K-Box"></a>
### `K.Box`

Накладывает детей друг на друга в порядке объявления. Подходит для фона и содержимого поверх него; обычных детей измеряет до match_parent_size.

**Сигнатура:** `K.Box(a: KompotBoxProps|KompotModifier|KompotContent, content?: KompotContent)`

**Начальные значения:** align="top_start", propagate_min=false.

**Контракт:** Строит дерево во время композиции. В on_click и других событиях меняйте состояние; не вызывайте там компоненты или хуки.

**Параметры и результат:** [KompotBoxProps](API_TYPES.md#type-kompotboxprops), [KompotContent](API_TYPES.md#type-kompotcontent), [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Выравнивание и слои.

**Свойства `KompotBoxProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `align` | `KompotAlign` | нет | Выравнивание в контексте данного элемента: у Text - текст, у Box - дети, у Row/Column - поперечная ось. |
| `propagate_min` | `boolean` | нет | Правило измерения детей. Не включает прокрутку и не создаёт бесконечную доступную область. |

<a id="api-K-Row"></a>
### `K.Row`

Размещает детей по горизонтали. Для вертикального списка используйте Column, для автоматического переноса FlowRow.

**Сигнатура:** `K.Row(a: KompotLinearProps|KompotModifier|KompotContent, content?: KompotContent)`

**Начальные значения:** arrangement="start", spacing=0, align="start"; fill_cross=false.

**Контракт:** Строит дерево во время композиции. В on_click и других событиях меняйте состояние; не вызывайте там компоненты или хуки.

**Параметры и результат:** [KompotContent](API_TYPES.md#type-kompotcontent), [KompotLinearProps](API_TYPES.md#type-kompotlinearprops), [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Row, Column и Spacer.

**Свойства `KompotLinearProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `arrangement` | `KompotArrangement` | нет | Распределение детей по основной оси; число задаёт spacing, строка выбирает алгоритм распределения. |
| `spacing` | `number` | нет | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `align` | `KompotCrossAlign` | нет | Выравнивание в контексте данного элемента: у Text - текст, у Box - дети, у Row/Column - поперечная ось. |
| `fill_cross` | `boolean` | нет | Правило измерения детей. Не включает прокрутку и не создаёт бесконечную доступную область. |

<a id="api-K-Column"></a>
### `K.Column`

Размещает детей по вертикали. Она не прокручивается сама; прокрутку задаёт модификатор со ScrollState.

**Сигнатура:** `K.Column(a: KompotLinearProps|KompotModifier|KompotContent, content?: KompotContent)`

**Начальные значения:** arrangement="start", spacing=0, align="start", fill_cross=false; без автоматической прокрутки.

**Контракт:** Строит дерево во время композиции. В on_click и других событиях меняйте состояние; не вызывайте там компоненты или хуки.

**Параметры и результат:** [KompotContent](API_TYPES.md#type-kompotcontent), [KompotLinearProps](API_TYPES.md#type-kompotlinearprops), [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Row, Column и Spacer.

**Свойства `KompotLinearProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `arrangement` | `KompotArrangement` | нет | Распределение детей по основной оси; число задаёт spacing, строка выбирает алгоритм распределения. |
| `spacing` | `number` | нет | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `align` | `KompotCrossAlign` | нет | Выравнивание в контексте данного элемента: у Text - текст, у Box - дети, у Row/Column - поперечная ось. |
| `fill_cross` | `boolean` | нет | Правило измерения детей. Не включает прокрутку и не создаёт бесконечную доступную область. |

<a id="api-K-FlowRow"></a>
### `K.FlowRow`

Переносит элементы на следующие строки, когда не хватает ограниченной ширины. Не виртуализирует содержимое.

**Сигнатура:** `K.FlowRow(a: KompotFlowProps|KompotModifier|KompotContent, content?: KompotContent)`

**Начальные значения:** spacing=0, run_spacing=0, align="start".

**Контракт:** Строит дерево во время композиции. В on_click и других событиях меняйте состояние; не вызывайте там компоненты или хуки.

**Параметры и результат:** [KompotContent](API_TYPES.md#type-kompotcontent), [KompotFlowProps](API_TYPES.md#type-kompotflowprops), [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** FlowRow и переносы.

**Свойства `KompotFlowProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `spacing` | `number` | нет | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `run_spacing` | `number` | нет | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `align` | `KompotCrossAlign` | нет | Выравнивание в контексте данного элемента: у Text - текст, у Box - дети, у Row/Column - поперечная ось. |

<a id="api-K-Spacer"></a>
### `K.Spacer`

Занимает пустое место без рисунка и ввода. Передайте число для ширины либо modifier для height/weight.

**Сигнатура:** `K.Spacer(width: number|KompotModifier, height?: number)`

**Контракт:** Строит дерево во время композиции. В on_click и других событиях меняйте состояние; не вызывайте там компоненты или хуки.

**Ограничения:** Spacer(8) задаёт квадрат 8 × 8; Spacer(8,16) - ширину и высоту; для вертикального отступа удобен M:height(8).

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Row, Column и Spacer.

<a id="api-K-Text"></a>
### `K.Text`

Рисует текст с переносами, стилем, цветом и необязательной разметкой md. Для пользовательского ввода нужен TextInput или BasicTextField.

**Сигнатура:** `K.Text(text: string|number|nil, props?: KompotTextProps)`

**Начальные значения:** wrap=true, align="start"; шрифт и цвет из локального стиля/темы; явный max_lines не задан.

**Контракт:** lines - число видимых строк, а не лимит текста. enabled=false запрещает пользовательский ввод; editable=false сохраняет выделение и копирование.

**Параметры и результат:** [KompotTextProps](API_TYPES.md#type-kompottextprops).

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

**F12:** Первый интерфейс, Типографика, Цвет и форматирование.

**Свойства `KompotTextProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `style` | `string\|KompotTextStyle` | нет | Имя или описание стиля текста; default_style задаёт fallback темы. |
| `color` | `KompotColor` | нет | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `align` | `KompotTextAlign` | нет | Выравнивание в контексте данного элемента: у Text - текст, у Box - дети, у Row/Column - поперечная ось. |
| `max_lines` | `integer` | нет | lines задаёт высоту поля в строках; max_lines ограничивает отрисовку Text. Не ограничивают длину модели текста. |
| `wrap` | `boolean` | нет | Перенос, многоточие, разметка или подсветка. Поддерживаемые значения и нативные ограничения описаны в TEXT_INPUT. |
| `ellipsis` | `boolean` | нет | Перенос, многоточие, разметка или подсветка. Поддерживаемые значения и нативные ограничения описаны в TEXT_INPUT. |
| `font` | `string` | нет | Имя загруженного ресурса шрифта, не путь к TTF. В поле font=false выбирает шрифт движка. |
| `bold_font` | `string` | нет | Имя загруженного ресурса шрифта, не путь к TTF. В поле font=false выбирает шрифт движка. |
| `markup` | `'md'` | нет | Перенос, многоточие, разметка или подсветка. Поддерживаемые значения и нативные ограничения описаны в TEXT_INPUT. |
| `spans` | `KompotTextSpan[]` | нет | Фрагменты или флаг стилизованной текстовой раскладки. |

<a id="api-K-Image"></a>
### `K.Image`

Рисует PNG или спрайт атласа. fit выбирает растяжение, вписывание или заполнение; для фона поместите Image ребёнком Box с match_parent_size.

**Сигнатура:** `K.Image(source: string, props?: KompotImageProps)`

**Начальные значения:** fit="fill"; без явного размера выбирается доступный размер по правилам измерения изображения.

**Контракт:** Имя texture/path обозначает текстуру, atlas:sprite - спрайт. Это не require pack:module. Ресурс должен быть загружен; source_size относится к PNG или спрайту.

**Параметры и результат:** [KompotImageProps](API_TYPES.md#type-kompotimageprops).

**Руководство:** [сценарий и примеры](SKINS.md).

**F12:** Картинка фоном: cover, Изображения и атласы.

**Свойства `KompotImageProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `width` | `number` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `height` | `number` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `size` | `number` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `source_size` | `{ [1]: number, [2]: number }\|{ width: number, height: number }` | нет | Размер PNG или спрайта, не всего атласа; обязателен для contain/cover. |
| `fit` | `KompotImageFit` | нет | fill растягивает, contain вписывает, cover заполняет с обрезкой; по умолчанию fill. |
| `color` | `KompotColor` | нет | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `region` | `number[]` | нет | UV-прямоугольник {u0,v0,u1,v1} в диапазоне 0..1, не экранные координаты. |

<a id="api-K-Icon"></a>
### `K.Icon`

Ищет значок в атласе icons текущей темы. Для произвольного пути текстуры используйте Image; базовая тема не обещает атлас значков.

**Сигнатура:** `K.Icon(name: string, props?: KompotIconProps)`

**Начальные значения:** size=20; имя атласа - theme.icons.

**Контракт:** Имя texture/path обозначает текстуру, atlas:sprite - спрайт. Это не require pack:module. Ресурс должен быть загружен; source_size относится к PNG или спрайту.

**Ограничения:** Явное имя atlas:sprite также допустимо и не требует theme.icons. size по умолчанию 20.

**Параметры и результат:** [KompotIconProps](API_TYPES.md#type-kompoticonprops).

**Руководство:** [сценарий и примеры](SKINS.md).

**F12:** Изображения и атласы.

**Свойства `KompotIconProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `size` | `number` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `color` | `KompotColor` | нет | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |

<a id="api-K-Canvas"></a>
### `K.Canvas`

Создаёт рисуемый холст конечного размера с callback draw(canvas,w,h). version управляет повторной отрисовкой; размер холста задаёт раскладка.

**Сигнатура:** `K.Canvas(props: KompotCanvasProps)`

**Контракт:** Имя texture/path обозначает текстуру, atlas:sprite - спрайт. Это не require pack:module. Ресурс должен быть загружен; source_size относится к PNG или спрайту.

**Ограничения:** Без version нативный холст перерисовывается при применении; стабильная version сохраняет рисунок до смены версии или размеров. Рисуйте через переданный canvas, не через глобальные координаты окна.

**Параметры и результат:** [KompotCanvasProps](API_TYPES.md#type-kompotcanvasprops).

**Руководство:** [сценарий и примеры](SKINS.md).

**F12:** Canvas.

**Свойства `KompotCanvasProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `draw` | `fun(canvas: KompotCanvas, width: number, height: number)` | да | Callback рисунка; тип определяет, получает ли он Canvas или контекст композиции поверхности. |
| `version` | `any` | нет | Версия источника или кэша; смена version сообщает, что рисунок/метрики изменились. |
| `width` | `number` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `height` | `number` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |

<a id="api-K-Layout"></a>
### `K.Layout`

Задаёт собственные измерение и размещение детей через measure и api.measure/api.place. Нужен для раскладок, которые не выражаются Row/Column/Box.

**Сигнатура:** `K.Layout(props: KompotLayoutProps, content: KompotContent)`

**Контракт:** Строит дерево во время композиции. В on_click и других событиях меняйте состояние; не вызывайте там компоненты или хуки.

**Ограничения:** measure обязан измерить и разместить детей и вернуть width,height двумя значениями. Измерение не является композицией: не вызывайте внутри хуки и компоненты.

**Параметры и результат:** [KompotContent](API_TYPES.md#type-kompotcontent), [KompotLayoutProps](API_TYPES.md#type-kompotlayoutprops).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Своя раскладка.

**Свойства `KompotLayoutProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `measure` | `fun(children: any[], min_width: number, max_width: number, min_height: number, max_height: number, api: KompotMeasureApi): number, number` | да | Callback измерения; возвращает width,height отдельными Lua-значениями. |

<a id="api-K-TextInput"></a>
### `K.TextInput`

Низкоуровневый нативный textbox движка. Даёт прямые value и события; для управляемого текста и защиты от старого value используйте BasicTextField.

**Сигнатура:** `K.TextInput(props: KompotTextInputProps)`

**Начальные значения:** lines=1; enabled=true, editable=true; подробности wrap/font в TEXT_INPUT.

**Контракт:** lines - число видимых строк, а не лимит текста. enabled=false запрещает пользовательский ввод; editable=false сохраняет выделение и копирование.

**Параметры и результат:** [KompotTextInputProps](API_TYPES.md#type-kompottextinputprops).

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

**F12:** Своё оформление поля.

**Свойства `KompotTextInputProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `value` | `string` | нет | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |
| `on_change` | `fun(text: string)` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_submit` | `fun(text: string)` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `hint` | `string` | нет | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `font` | `string\|false` | нет | Имя загруженного ресурса шрифта, не путь к TTF. В поле font=false выбирает шрифт движка. |
| `color` | `KompotColor` | нет | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `lines` | `integer` | нет | lines задаёт высоту поля в строках; max_lines ограничивает отрисовку Text. Не ограничивают длину модели текста. |
| `pad` | `number` | нет | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `width` | `number` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `focus` | `boolean` | нет | Запрос нативного фокуса либо граница области фокуса. Не включает общий обход Tab автоматически. |
| `on_focus` | `fun()` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_defocus` | `fun()` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `syntax` | `'lua'\|string` | нет | Перенос, многоточие, разметка или подсветка. Поддерживаемые значения и нативные ограничения описаны в TEXT_INPUT. |
| `line_numbers` | `boolean` | нет | Показывать номера строк. Это оформление поля, а не изменение исходного текста. |
| `enabled` | `boolean` | нет | Нельзя фокусировать, выделять или менять недоступное поле. |
| `editable` | `boolean` | нет | Политика пользовательского взаимодействия. Семантика и поддержка конкретным компонентом указаны в его карточке; эти флаги не взаимозаменяемы. |
| `wrap` | `boolean` | нет | Перенос, многоточие, разметка или подсветка. Поддерживаемые значения и нативные ограничения описаны в TEXT_INPUT. |
| `presentation` | `any` | нет | Модель текста/выделения или описание нативной текстовой отрисовки. Нужны соответствующие расширения textbox VoxelCore. |
| `editor_state` | `KompotState<KompotEditorValue>` | нет | Модель текста/выделения или описание нативной текстовой отрисовки. Нужны соответствующие расширения textbox VoxelCore. |
| `editor_value` | `KompotEditorValue` | нет | Модель текста/выделения или описание нативной текстовой отрисовки. Нужны соответствующие расширения textbox VoxelCore. |
| `on_selection_change` | `fun(anchor: number, caret: number)` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |

<a id="api-K-BasicTextField"></a>
### `K.BasicTextField`

Управляет строковым state, editor_state или value/on_change без фирменного оформления. Выбирайте один способ владения текстом.

**Сигнатура:** `K.BasicTextField(props: KompotBasicTextFieldProps)`

**Начальные значения:** Без источника текст пустой. state, editor_state и value не объединяются. lines=1, editable=true, enabled=true.

**Контракт:** lines - число видимых строк, а не лимит текста. enabled=false запрещает пользовательский ввод; editable=false сохраняет выделение и копирование.

**Параметры и результат:** [KompotBasicTextFieldProps](API_TYPES.md#type-kompotbasictextfieldprops).

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

**F12:** Своё оформление поля.

**Свойства `KompotBasicTextFieldProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `value` | `string` | нет | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |
| `on_change` | `fun(text: string)` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_submit` | `fun(text: string)` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `hint` | `string` | нет | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `font` | `string\|false` | нет | Имя загруженного ресурса шрифта, не путь к TTF. В поле font=false выбирает шрифт движка. |
| `color` | `KompotColor` | нет | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `lines` | `integer` | нет | lines задаёт высоту поля в строках; max_lines ограничивает отрисовку Text. Не ограничивают длину модели текста. |
| `pad` | `number` | нет | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `width` | `number` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `focus` | `boolean` | нет | Запрос нативного фокуса либо граница области фокуса. Не включает общий обход Tab автоматически. |
| `on_focus` | `fun()` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_defocus` | `fun()` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `syntax` | `'lua'\|string` | нет | Перенос, многоточие, разметка или подсветка. Поддерживаемые значения и нативные ограничения описаны в TEXT_INPUT. |
| `line_numbers` | `boolean` | нет | Показывать номера строк. Это оформление поля, а не изменение исходного текста. |
| `enabled` | `boolean` | нет | Нельзя фокусировать, выделять или менять недоступное поле. |
| `editable` | `boolean` | нет | Политика пользовательского взаимодействия. Семантика и поддержка конкретным компонентом указаны в его карточке; эти флаги не взаимозаменяемы. |
| `wrap` | `boolean` | нет | Перенос, многоточие, разметка или подсветка. Поддерживаемые значения и нативные ограничения описаны в TEXT_INPUT. |
| `presentation` | `any` | нет | Модель текста/выделения или описание нативной текстовой отрисовки. Нужны соответствующие расширения textbox VoxelCore. |
| `editor_state` | `KompotState<KompotEditorValue>` | нет | Модель текста/выделения или описание нативной текстовой отрисовки. Нужны соответствующие расширения textbox VoxelCore. |
| `editor_value` | `KompotEditorValue` | нет | Модель текста/выделения или описание нативной текстовой отрисовки. Нужны соответствующие расширения textbox VoxelCore. |
| `on_selection_change` | `fun(anchor: number, caret: number)` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `state` | `KompotState<string>` | нет | Состояние, принадлежащее владельцу компонента; тип определяет текстовую модель или положение прокрутки. |

<a id="api-K-new-text-field-state"></a>
### `K.new_text_field_state`

Создаёт внешний State с text, anchor и caret. Для использования editor_state нужен движок с API выделения и текстовой раскладки.

**Сигнатура:** `K.new_text_field_state(initial?: string): KompotState<KompotEditorValue>`

**Начальные значения:** initial="", anchor=0, caret=0.

**Контракт:** lines - число видимых строк, а не лимит текста. enabled=false запрещает пользовательский ввод; editable=false сохраняет выделение и копирование.

**Параметры и результат:** [KompotEditorValue](API_TYPES.md#type-kompoteditorvalue), [KompotState](API_TYPES.md#type-kompotstate).

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

**F12:** Каретка и выделение.

<a id="api-K-text-field-state"></a>
### `K.text_field_state`

Запоминает состояние текста и выделения в компоненте. Инициализация не повторяется при перекомпозиции.

**Сигнатура:** `K.text_field_state(initial?: string): KompotState<KompotEditorValue>`

**Начальные значения:** initial="", anchor=0, caret=0; состояние привязано к области композиции.

**Контракт:** lines - число видимых строк, а не лимит текста. enabled=false запрещает пользовательский ввод; editable=false сохраняет выделение и копирование.

**Параметры и результат:** [KompotEditorValue](API_TYPES.md#type-kompoteditorvalue), [KompotState](API_TYPES.md#type-kompotstate).

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

**F12:** Каретка и выделение.

<a id="api-K-scroll-state"></a>
### `K.scroll_state`

Запоминает позицию обычной прокрутки. Подходит, когда все дети уже существуют; для больших наборов используйте lazy_state и LazyColumn/Grid.

**Сигнатура:** `K.scroll_state(initial?: number): KompotScrollState`

**Контракт:** Позиции и индексы API Lua начинаются с 1. Обычная прокрутка и lazy-списки используют разные типы состояния и не взаимозаменяемы.

**Параметры и результат:** [KompotScrollState](API_TYPES.md#type-kompotscrollstate).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Обычная прокрутка.

<a id="api-K-lazy-state"></a>
### `K.lazy_state`

Запоминает позицию виртуализованного списка. Для внешней модели доступен прямой Scroll.new_lazy из модуля совместимости.

**Сигнатура:** `K.lazy_state(): KompotLazyState`

**Контракт:** Позиции и индексы API Lua начинаются с 1. Обычная прокрутка и lazy-списки используют разные типы состояния и не взаимозаменяемы.

**Параметры и результат:** [KompotLazyState](API_TYPES.md#type-kompotlazystate).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Ленивый список.

<a id="api-K-LazyColumn"></a>
### `K.LazyColumn`

Строит видимую часть вертикального списка из count и item(index). Не создавайте все элементы заранее; key_of сохраняет идентичность при перестановке.

**Сигнатура:** `K.LazyColumn(props: KompotLazyProps)`

**Начальные значения:** spacing=0, pad=0, fill_cross=true; состояние создаётся внутри, если не передано.

**Контракт:** Позиции и индексы API Lua начинаются с 1. Обычная прокрутка и lazy-списки используют разные типы состояния и не взаимозаменяемы.

**Параметры и результат:** [KompotLazyProps](API_TYPES.md#type-kompotlazyprops).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Ленивый список.

**Свойства `KompotLazyProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `count` | `integer` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `item` | `fun(index: integer)` | да | Композиция элемента по индексу Lua от 1. В lazy-списках вызывается только для нужных элементов. |
| `key_of` | `fun(index: integer): any` | нет | Возвращает стабильный ключ элемента по индексу, чтобы сохранить его состояние при перестановке. |
| `state` | `KompotLazyState` | нет | Состояние, принадлежащее владельцу компонента; тип определяет текстовую модель или положение прокрутки. |
| `spacing` | `number` | нет | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `pad` | `number` | нет | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `pad_start` | `number` | нет | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `pad_end` | `number` | нет | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `fill_cross` | `boolean` | нет | Правило измерения детей. Не включает прокрутку и не создаёт бесконечную доступную область. |

<a id="api-K-LazyRow"></a>
### `K.LazyRow`

Виртуализует горизонтальный список. Использует тот же LazyState и контракт item, что LazyColumn.

**Сигнатура:** `K.LazyRow(props: KompotLazyProps)`

**Начальные значения:** spacing=0, pad=0, fill_cross=true; состояние создаётся внутри, если не передано.

**Контракт:** Позиции и индексы API Lua начинаются с 1. Обычная прокрутка и lazy-списки используют разные типы состояния и не взаимозаменяемы.

**Параметры и результат:** [KompotLazyProps](API_TYPES.md#type-kompotlazyprops).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Ленивая сетка и строка.

**Свойства `KompotLazyProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `count` | `integer` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `item` | `fun(index: integer)` | да | Композиция элемента по индексу Lua от 1. В lazy-списках вызывается только для нужных элементов. |
| `key_of` | `fun(index: integer): any` | нет | Возвращает стабильный ключ элемента по индексу, чтобы сохранить его состояние при перестановке. |
| `state` | `KompotLazyState` | нет | Состояние, принадлежащее владельцу компонента; тип определяет текстовую модель или положение прокрутки. |
| `spacing` | `number` | нет | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `pad` | `number` | нет | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `pad_start` | `number` | нет | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `pad_end` | `number` | нет | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `fill_cross` | `boolean` | нет | Правило измерения детей. Не включает прокрутку и не создаёт бесконечную доступную область. |

<a id="api-K-LazyGrid"></a>
### `K.LazyGrid`

Виртуализует сетку с заданным числом columns. Нужна ограниченная область просмотра по оси прокрутки.

**Сигнатура:** `K.LazyGrid(props: KompotLazyGridProps)`

**Начальные значения:** columns=3; остальные значения как у LazyColumn.

**Контракт:** Позиции и индексы API Lua начинаются с 1. Обычная прокрутка и lazy-списки используют разные типы состояния и не взаимозаменяемы.

**Параметры и результат:** [KompotLazyGridProps](API_TYPES.md#type-kompotlazygridprops).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Ленивая сетка и строка.

**Свойства `KompotLazyGridProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | нет | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `count` | `integer` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `item` | `fun(index: integer)` | да | Композиция элемента по индексу Lua от 1. В lazy-списках вызывается только для нужных элементов. |
| `key_of` | `fun(index: integer): any` | нет | Возвращает стабильный ключ элемента по индексу, чтобы сохранить его состояние при перестановке. |
| `state` | `KompotLazyState` | нет | Состояние, принадлежащее владельцу компонента; тип определяет текстовую модель или положение прокрутки. |
| `spacing` | `number` | нет | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `pad` | `number` | нет | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `pad_start` | `number` | нет | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `pad_end` | `number` | нет | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `fill_cross` | `boolean` | нет | Правило измерения детей. Не включает прокрутку и не создаёт бесконечную доступную область. |
| `columns` | `integer` | нет | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |

<a id="api-K-Popup"></a>
### `K.Popup`

Рисует содержимое отдельным слоем относительно якоря с placement и z. Не добавляет закрытие, затемнение и управление состоянием - это делают Window/Menu/Dialog.

**Сигнатура:** `K.Popup(props: KompotPopupProps, content: KompotContent)`

**Начальные значения:** placement="below", gap=4, z=0, interactive=true.

**Контракт:** Позиции и индексы API Lua начинаются с 1. Обычная прокрутка и lazy-списки используют разные типы состояния и не взаимозаменяемы.

**Параметры и результат:** [KompotContent](API_TYPES.md#type-kompotcontent), [KompotPopupProps](API_TYPES.md#type-kompotpopupprops).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Всплывающий слой.

**Свойства `KompotPopupProps`** (включая базовые; ограничения обёртки выше):

| Параметр | Тип | Обязателен по типу | Описание |
|---|---|---|---|
| `interactive` | `boolean` | нет | false отключает ввод содержимого, сохраняя отрисовку. |
| `placement` | `KompotPlacement` | нет | Геометрия, слой или поведение окна/всплывающей области. Не все параметры Window применимы к Dialog. |
| `gap` | `number` | нет | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `key` | `any` | нет | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `z` | `number` | нет | Геометрия, слой или поведение окна/всплывающей области. Не все параметры Window применимы к Dialog. |

<a id="api-K-state"></a>
### `K.state`

Хранит состояние в текущей области композиции. Начальное значение или функция инициализации применяются один раз на время жизни слота.

**Сигнатура:** `K.state<T>(initial: T, eq?: fun(a: T, b: T): boolean): KompotState<T>`

**Начальные значения:** eq: обычное равенство Lua; initial применяется один раз, функция initial вызывается без аргументов.

**Контракт:** Чтение state.value подписывает область, state:peek() читает без подписки. Хуки вызываются в неизменном порядке; функции new_* и copy можно вызывать вне композиции.

**Параметры и результат:** [KompotState](API_TYPES.md#type-kompotstate).

**Руководство:** [сценарий и примеры](STATE.md).

**F12:** Настройка пружины, Ключевые кадры и перемотка, Перетаскивание с пружинным возвратом, Смена сцены в несколько фаз, Временная шкала: пауза и обратный ход, Первый интерфейс, Обычные поля, Реактивное состояние, Обновление полей State, Порядок хуков и условные области, Ключи и перестановка.

<a id="api-K-form"></a>
### `K.form`

Запоминает фиксированный набор независимых State по полям исходной таблицы. Схема не меняется после создания; для другой схемы пересоздайте поддерево с новым key.

**Сигнатура:** `K.form(initial: table): table<any, KompotState<any>>`

**Контракт:** Чтение state.value подписывает область, state:peek() читает без подписки. Хуки вызываются в неизменном порядке; функции new_* и copy можно вызывать вне композиции.

**Параметры и результат:** [KompotState](API_TYPES.md#type-kompotstate).

**Руководство:** [сценарий и примеры](STATE.md).

**F12:** Форма с независимыми полями.

<a id="api-K-new-state"></a>
### `K.new_state`

Создаёт состояние вне композиции. Подходит для модели, переживающей закрытие окна; не создавайте новое состояние на каждой перекомпозиции.

**Сигнатура:** `K.new_state<T>(initial: T, eq?: fun(a: T, b: T): boolean): KompotState<T>`

**Начальные значения:** eq: обычное равенство Lua; для таблиц это равенство ссылки.

**Контракт:** Чтение state.value подписывает область, state:peek() читает без подписки. Хуки вызываются в неизменном порядке; функции new_* и copy можно вызывать вне композиции.

**Параметры и результат:** [KompotState](API_TYPES.md#type-kompotstate).

**Руководство:** [сценарий и примеры](STATE.md).

**F12:** Реактивное состояние.

<a id="api-K-remember"></a>
### `K.remember`

Запоминает результат initial() до изменения переданных ключей. Не наблюдает внешние данные сам по себе и не запускает очистку ресурсов.

**Сигнатура:** `K.remember<T>(initial: fun(): T, ...: any): T`

**Контракт:** Чтение state.value подписывает область, state:peek() читает без подписки. Хуки вызываются в неизменном порядке; функции new_* и copy можно вызывать вне композиции.

**Руководство:** [сценарий и примеры](STATE.md).

**F12:** Реактивное состояние, Внешние данные.

<a id="api-K-effect"></a>
### `K.effect`

Выполняет побочное действие после применения кадра; результатом может быть функция очистки. Ключи определяют повторный запуск, а удаление области вызывает очистку.

**Сигнатура:** `K.effect(fn: function, ...: any)`

**Контракт:** Чтение state.value подписывает область, state:peek() читает без подписки. Хуки вызываются в неизменном порядке; функции new_* и copy можно вызывать вне композиции.

**Руководство:** [сценарий и примеры](STATE.md).

**F12:** Смена сцены в несколько фаз, Цепочка по завершению переходов, Временная шкала: пауза и обратный ход, Окна и диалоги, Эффекты и освобождение.

<a id="api-K-on-dispose"></a>
### `K.on_dispose`

Регистрирует очистку ресурса при удалении области композиции. Не означает пользовательский запрос закрытия и не ждёт анимацию выхода.

**Сигнатура:** `K.on_dispose(fn: fun())`

**Контракт:** Чтение state.value подписывает область, state:peek() читает без подписки. Хуки вызываются в неизменном порядке; функции new_* и copy можно вызывать вне композиции.

**Руководство:** [сценарий и примеры](STATE.md).

**F12:** Эффекты и освобождение.

<a id="api-K-on-frame"></a>
### `K.on_frame`

Вызывает fn(dt) каждый кадр существования области. Не создавайте здесь дерево; обновляйте модель или синхронизируйте внешний объект.

**Сигнатура:** `K.on_frame(fn: fun(dt: number))`

**Контракт:** Чтение state.value подписывает область, state:peek() читает без подписки. Хуки вызываются в неизменном порядке; функции new_* и copy можно вызывать вне композиции.

**Руководство:** [сценарий и примеры](STATE.md).

<a id="api-K-key"></a>
### `K.key`

Задаёт устойчивую идентичность поддерева. Используйте ID предмета, если его положение в списке может измениться; для намеренного сброса состояния меняйте ключ.

**Сигнатура:** `K.key(key: any, content: KompotContent)`

**Контракт:** Строит дерево во время композиции. В on_click и других событиях меняйте состояние; не вызывайте там компоненты или хуки.

**Параметры и результат:** [KompotContent](API_TYPES.md#type-kompotcontent).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Последовательность из четырёх шагов, Каскадное появление, Цикл туда и обратно, Многоэтапная загрузка, Перестановка с сохранением движения, Временная шкала: пауза и обратный ход, Перемещение и размер окон, Форма с независимыми полями, Порядок хуков и условные области, Ключи и перестановка.

<a id="api-K-component"></a>
### `K.component`

Создаёт отдельную область композиции для функции. Её хуки, подписки и очистка живут независимо от соседних компонентов.

**Сигнатура:** `K.component<T>(fn: T): T`

**Контракт:** Строит дерево во время композиции. В on_click и других событиях меняйте состояние; не вызывайте там компоненты или хуки.

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Реактивное состояние, Порядок хуков и условные области, Ключи и перестановка, Эффекты и освобождение.

<a id="api-K-provide"></a>
### `K.provide`

Предоставляет значение Local детям. Чтение local_value:get() выбирает ближайший провайдер, иначе default.

**Сигнатура:** `K.provide<T>(local_value: KompotLocal<T>, value: T, content: KompotContent)`

**Контракт:** K.Theme принимает готовую тему; UI.Theme принимает настройки встроенной дизайн-системы. Прямой UI.Button и K.ui().Button - разные точки выбора реализации.

**Параметры и результат:** [KompotContent](API_TYPES.md#type-kompotcontent), [KompotLocal](API_TYPES.md#type-kompotlocal).

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

**F12:** Локальные значения.

<a id="api-K-local-of"></a>
### `K.local_of`

Создаёт ключ локального значения с default и именем. Это ключ провайдера, а не State и не копия текущего значения.

**Сигнатура:** `K.local_of<T>(default: T, name?: string): KompotLocal<T>`

**Контракт:** K.Theme принимает готовую тему; UI.Theme принимает настройки встроенной дизайн-системы. Прямой UI.Button и K.ui().Button - разные точки выбора реализации.

**Параметры и результат:** [KompotLocal](API_TYPES.md#type-kompotlocal).

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

**F12:** Локальные значения.

<a id="api-K-untracked"></a>
### `K.untracked`

Выполняет функцию без регистрации реактивных зависимостей текущей области. Полезен при служебном чтении, которое не должно вызывать перекомпозицию.

**Сигнатура:** `K.untracked<T>(fn: fun(...: any): T, ...: any): T`

**Контракт:** Чтение state.value подписывает область, state:peek() читает без подписки. Хуки вызываются в неизменном порядке; функции new_* и copy можно вызывать вне композиции.

**Руководство:** [сценарий и примеры](STATE.md).

**F12:** Реактивное состояние.

<a id="api-K-is-state"></a>
### `K.is_state`

Проверяет, является ли значение State Kompot. Это не проверка TransitionState и не способ прочитать значение.

**Сигнатура:** `K.is_state(value: any): boolean`

**Контракт:** Чтение state.value подписывает область, state:peek() читает без подписки. Хуки вызываются в неизменном порядке; функции new_* и copy можно вызывать вне композиции.

**Руководство:** [сценарий и примеры](STATE.md).

**F12:** Реактивное состояние.

<a id="api-K-poll"></a>
### `K.poll`

Читает значение нереактивного источника каждый кадр и перестраивает область при изменении. Для обычного State достаточно чтения .value.

**Сигнатура:** `K.poll<T>(getter: fun(): T, eq?: fun(a: T, b: T): boolean): T`

**Контракт:** Чтение state.value подписывает область, state:peek() читает без подписки. Хуки вызываются в неизменном порядке; функции new_* и copy можно вызывать вне композиции.

**Руководство:** [сценарий и примеры](STATE.md).

**F12:** Внешние данные.

<a id="api-K-animate"></a>
### `K.animate`

Анимирует одно число или массив чисел к новой цели. Выбирайте transition, когда нужно дождаться завершения нескольких каналов вместе.

**Сигнатура:** `K.animate<T>(target: T, spec?: KompotAnimationSpec): T`

**Контракт:** animate, transition_state, transition, clock и after - хуки композиции. Действие после группы запускайте в effect по completion; начальное is_idle=true не означает завершённый переход.

**Параметры и результат:** [KompotAnimationSpec](API_TYPES.md#type-kompotanimationspec).

**Руководство:** [сценарий и примеры](MOTION.md).

**F12:** Кривые движения, Настройка пружины, Параллельные переходы, Последовательность из четырёх шагов, Каскадное появление, Прерывание и разворот перехода, Многоэтапная загрузка, Перестановка с сохранением движения, Перетаскивание с пружинным возвратом, Смена сцены в несколько фаз, Tween и spring.

<a id="api-K-transition-state"></a>
### `K.transition_state`

Запоминает состояние перехода в компоненте. Владельцу разрешено менять только target_state; завершение публикуется через is_idle/completion.

**Сигнатура:** `K.transition_state<T>(initial: T): KompotTransitionState<T>`

**Контракт:** animate, transition_state, transition, clock и after - хуки композиции. Действие после группы запускайте в effect по completion; начальное is_idle=true не означает завершённый переход.

**Параметры и результат:** [KompotTransitionState](API_TYPES.md#type-kompottransitionstate).

**Руководство:** [сценарий и примеры](MOTION.md).

**F12:** Цепочка по завершению переходов, Окна и диалоги.

<a id="api-K-new-transition-state"></a>
### `K.new_transition_state`

Создаёт состояние перехода вне композиции. Подходит для модели окна, которая должна сохраняться после удаления его содержимого.

**Сигнатура:** `K.new_transition_state<T>(initial: T): KompotTransitionState<T>`

**Контракт:** animate, transition_state, transition, clock и after - хуки композиции. Действие после группы запускайте в effect по completion; начальное is_idle=true не означает завершённый переход.

**Параметры и результат:** [KompotTransitionState](API_TYPES.md#type-kompottransitionstate).

**Руководство:** [сценарий и примеры](MOTION.md).

<a id="api-K-transition"></a>
### `K.transition`

Связывает TransitionState с группой анимаций текущего компонента. Каналы добавляются вызовами transition:animate в стабильном порядке.

**Сигнатура:** `K.transition<T>(state: KompotTransitionState<T>): KompotTransition<T>`

**Контракт:** animate, transition_state, transition, clock и after - хуки композиции. Действие после группы запускайте в effect по completion; начальное is_idle=true не означает завершённый переход.

**Ограничения:** Один TransitionState нельзя одновременно привязывать к независимым группам. После перезапуска цели завершение относится к новой группе; начальное состояние не увеличивает completion.

**Параметры и результат:** [KompotTransition](API_TYPES.md#type-kompottransition), [KompotTransitionState](API_TYPES.md#type-kompottransitionstate).

**Руководство:** [сценарий и примеры](MOTION.md).

**F12:** Цепочка по завершению переходов.

<a id="api-K-tween"></a>
### `K.tween`

Описывает анимацию с заданной длительностью и кривой. Сам по себе не создаёт хук и ничего не запускает.

**Сигнатура:** `K.tween(duration?: number, easing?: string): KompotTween`

**Начальные значения:** duration=0.25 секунды, easing="standard".

**Контракт:** animate, transition_state, transition, clock и after - хуки композиции. Действие после группы запускайте в effect по completion; начальное is_idle=true не означает завершённый переход.

**Параметры и результат:** [KompotTween](API_TYPES.md#type-kompottween).

**Руководство:** [сценарий и примеры](MOTION.md).

**F12:** Кривые движения, Параллельные переходы, Последовательность из четырёх шагов, Прерывание и разворот перехода, Многоэтапная загрузка, Цепочка по завершению переходов, Tween и spring.

<a id="api-K-spring"></a>
### `K.spring`

Описывает пружину через stiffness и damping. Для завершения по времени используйте tween; длительность пружины зависит от движения.

**Сигнатура:** `K.spring(stiffness?: number, damping?: number): KompotSpring`

**Начальные значения:** stiffness=380, damping=0.78.

**Контракт:** animate, transition_state, transition, clock и after - хуки композиции. Действие после группы запускайте в effect по completion; начальное is_idle=true не означает завершённый переход.

**Параметры и результат:** [KompotSpring](API_TYPES.md#type-kompotspring).

**Руководство:** [сценарий и примеры](MOTION.md).

**F12:** Настройка пружины, Параллельные переходы, Прерывание и разворот перехода, Перестановка с сохранением движения, Перетаскивание с пружинным возвратом, Tween и spring.

<a id="api-K-clock"></a>
### `K.clock`

Возвращает время от появления области и поддерживает её обновление каждый кадр. Используйте для непрерывного движения; он не останавливается сам.

**Сигнатура:** `K.clock(): number`

**Контракт:** animate, transition_state, transition, clock и after - хуки композиции. Действие после группы запускайте в effect по completion; начальное is_idle=true не означает завершённый переход.

**Руководство:** [сценарий и примеры](MOTION.md).

**F12:** Цикл туда и обратно, Волна и фазовые сдвиги, Орбиты и вложенное движение, Временная шкала: пауза и обратный ход, Время и задержка.

<a id="api-K-after"></a>
### `K.after`

Возвращает true после указанной задержки. Смена key перезапускает отсчёт; seconds без смены key не создаёт новый таймер.

**Сигнатура:** `K.after(seconds: number, key?: any): boolean`

**Контракт:** animate, transition_state, transition, clock и after - хуки композиции. Действие после группы запускайте в effect по completion; начальное is_idle=true не означает завершённый переход.

**Руководство:** [сценарий и примеры](MOTION.md).

**F12:** Последовательность из четырёх шагов, Каскадное появление, Многоэтапная загрузка, Смена сцены в несколько фаз, Время и задержка.

<a id="api-K-runtime"></a>
### `K.runtime`

Возвращает текущий Runtime для размеров и времени композиции и низкоуровневой интеграции. Не храните ссылку как глобальный источник для другого приложения.

**Сигнатура:** `K.runtime(): table`

**Контракт:** Строит дерево во время композиции. В on_click и других событиях меняйте состояние; не вызывайте там компоненты или хуки.

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-K-interaction"></a>
### `K.interaction`

Запоминает общий снимок hovered/pressed/dragged/focused. Передайте его модификатору ввода и читайте значения для оформления.

**Сигнатура:** `K.interaction(): KompotInteraction`

**Контракт:** Позиции и индексы API Lua начинаются с 1. Обычная прокрутка и lazy-списки используют разные типы состояния и не взаимозаменяемы.

**Параметры и результат:** [KompotInteraction](API_TYPES.md#type-kompotinteraction).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Наведение и подсказки, Клавиатура и фокус.

<a id="api-K-new-interaction"></a>
### `K.new_interaction`

Создаёт внешний снимок взаимодействия без хука. Сам не подключается к вводу, пока его не передали clickable/hoverable/draggable.

**Сигнатура:** `K.new_interaction(): KompotInteraction`

**Контракт:** Позиции и индексы API Lua начинаются с 1. Обычная прокрутка и lazy-списки используют разные типы состояния и не взаимозаменяемы.

**Параметры и результат:** [KompotInteraction](API_TYPES.md#type-kompotinteraction).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-K-rgb"></a>
### `K.rgb`

Создаёт цвет из нормализованных r,g,b,a в диапазоне 0..1. Для каналов 0..255 сначала разделите их на 255.

**Сигнатура:** `K.rgb(r: number, g: number, b: number, a?: number): number[]`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

**F12:** Цвет и форматирование.

<a id="api-K-hex"></a>
### `K.hex`

Разбирает строковый цвет #RGB, #RRGGBB или #RRGGBBAA в нормализованный массив. Альфа расположена в конце строки.

**Сигнатура:** `K.hex(value: string): number[]`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

**F12:** Цвет и форматирование.

<a id="api-K-theme"></a>
### `K.theme`

Читает тему текущего поддерева. Вне провайдера действует базовая тема ядра, а не автоматически Kompot UI.

**Сигнатура:** `K.theme(): KompotTheme`

**Контракт:** K.Theme принимает готовую тему; UI.Theme принимает настройки встроенной дизайн-системы. Прямой UI.Button и K.ui().Button - разные точки выбора реализации.

**Параметры и результат:** [KompotTheme](API_TYPES.md#type-kompottheme).

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

**F12:** Палитра и плотность.

<a id="api-K-Theme"></a>
### `K.Theme`

Предоставляет готовую таблицу темы детям. Для наследования настроек Kompot UI удобнее UI.Theme(opts, content).

**Сигнатура:** `K.Theme(theme: KompotTheme, content: KompotContent)`

**Контракт:** K.Theme принимает готовую тему; UI.Theme принимает настройки встроенной дизайн-системы. Прямой UI.Button и K.ui().Button - разные точки выбора реализации.

**Параметры и результат:** [KompotContent](API_TYPES.md#type-kompotcontent), [KompotTheme](API_TYPES.md#type-kompottheme).

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

**F12:** Вложенная тема.

<a id="api-K-ContentColor"></a>
### `K.ContentColor`

Переопределяет цвет содержимого внутри поддерева, не меняя всю тему. Явный color элемента имеет приоритет.

**Сигнатура:** `K.ContentColor(color: KompotColor, content: KompotContent)`

**Контракт:** K.Theme принимает готовую тему; UI.Theme принимает настройки встроенной дизайн-системы. Прямой UI.Button и K.ui().Button - разные точки выбора реализации.

**Параметры и результат:** [KompotColor](API_TYPES.md#type-kompotcolor), [KompotContent](API_TYPES.md#type-kompotcontent).

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

**F12:** Цвет и форматирование, Контракт дизайн-системы.

<a id="api-K-TextStyle"></a>
### `K.TextStyle`

Предоставляет стиль текста поддереву по имени или таблицей. Явный стиль конкретного текста можно передать прямо в K.Text.

**Сигнатура:** `K.TextStyle(style: string|KompotTextStyle, content: KompotContent)`

**Контракт:** K.Theme принимает готовую тему; UI.Theme принимает настройки встроенной дизайн-системы. Прямой UI.Button и K.ui().Button - разные точки выбора реализации.

**Параметры и результат:** [KompotContent](API_TYPES.md#type-kompotcontent), [KompotTextStyle](API_TYPES.md#type-kompottextstyle).

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

**F12:** Типографика, Контракт дизайн-системы.

<a id="api-K-style"></a>
### `K.style`

Разрешает имя или таблицу текстового стиля в выбранной теме. Для неизвестного имени использует стиль по умолчанию.

**Сигнатура:** `K.style(name: string|KompotTextStyle, theme?: KompotTheme): KompotTextStyle`

**Контракт:** K.Theme принимает готовую тему; UI.Theme принимает настройки встроенной дизайн-системы. Прямой UI.Button и K.ui().Button - разные точки выбора реализации.

**Параметры и результат:** [KompotTextStyle](API_TYPES.md#type-kompottextstyle), [KompotTheme](API_TYPES.md#type-kompottheme).

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

**F12:** Типографика.

<a id="api-K-extend-theme"></a>
### `K.extend_theme`

Сливает таблицы темы рекурсивно. Цвета-массивы и функции заменяются целиком; ui заменяется таблицей, а UI.theme дополняет свой контракт отдельно.

**Сигнатура:** `K.extend_theme(base: KompotTheme, overrides: table): KompotTheme`

**Контракт:** K.Theme принимает готовую тему; UI.Theme принимает настройки встроенной дизайн-системы. Прямой UI.Button и K.ui().Button - разные точки выбора реализации.

**Параметры и результат:** [KompotTheme](API_TYPES.md#type-kompottheme).

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

**F12:** Вложенная тема.

<a id="api-K-ui"></a>
### `K.ui`

Возвращает контракт компонентов из текущей темы. Используйте для переносимого экрана; без theme.ui возникает ошибка.

**Сигнатура:** `K.ui(): KompotUiContract`

**Контракт:** K.Theme принимает готовую тему; UI.Theme принимает настройки встроенной дизайн-системы. Прямой UI.Button и K.ui().Button - разные точки выбора реализации.

**Параметры и результат:** [KompotUiContract](API_TYPES.md#type-kompotuicontract).

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

**F12:** Контракт дизайн-системы.

<a id="api-K-args"></a>
### `K.args`

Разбирает сокращённые формы вызова компонента: props, modifier или content. Возвращает props и content двумя Lua-значениями; полезен авторам компонентов.

**Сигнатура:** `K.args(a: KompotProps|KompotModifier|KompotContent, content?: KompotContent): KompotProps, KompotContent?`

**Контракт:** Строит дерево во время композиции. В on_click и других событиях меняйте состояние; не вызывайте там компоненты или хуки.

**Параметры и результат:** [KompotContent](API_TYPES.md#type-kompotcontent), [KompotModifier](API_TYPES.md#type-kompotmodifier), [KompotProps](API_TYPES.md#type-kompotprops).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-K-preview"></a>
### `K.preview`

Регистрирует именованное превью модуля для Lens. Сам не открывает HUD и не монтирует интерфейс в игре.

**Сигнатура:** `K.preview(name: string, opts: KompotPreviewOptions|KompotContent, content?: KompotContent): KompotPreviewEntry`

**Начальные значения:** width=400, height=300, padding=16, hook_diagnostics=true, keyboard_navigation=false; тема K.BASE_THEME.

**Параметры и результат:** [KompotContent](API_TYPES.md#type-kompotcontent), [KompotPreviewEntry](API_TYPES.md#type-kompotpreviewentry), [KompotPreviewOptions](API_TYPES.md#type-kompotpreviewoptions).

**Руководство:** [сценарий и примеры](PREVIEW.md).

**F12:** Превью в Kompot Lens.

<a id="api-K-previews"></a>
### `K.previews`

Возвращает зарегистрированные превью. Это реестр текущего процесса Lua, а не список живых игровых окон.

**Сигнатура:** `K.previews(): KompotPreviewEntry[]`

**Параметры и результат:** [KompotPreviewEntry](API_TYPES.md#type-kompotpreviewentry).

**Руководство:** [сценарий и примеры](PREVIEW.md).

**F12:** Превью в Kompot Lens.

<a id="api-K-mount"></a>
### `K.mount`

Создаёт живой интерфейс VoxelCore и возвращает handle. Без target занимает экран; при закрытии владельца вызывайте handle:dispose().

**Сигнатура:** `K.mount(opts: KompotMountOptions): KompotMountHandle`

**Начальные значения:** target отсутствует: экран; fullscreen=true; interactive=true; z_index=5; keyboard_navigation=false; тема K.BASE_THEME. lock_inventory задаёт отдельную политику из QUICKSTART.

**Контракт:** Нужен готовый клиентский HUD/документ движка. Не вызывайте mount из композиции. Для редактора без игры используйте preview; для своего цикла - App.new.

**Параметры и результат:** [KompotMountHandle](API_TYPES.md#type-kompotmounthandle), [KompotMountOptions](API_TYPES.md#type-kompotmountoptions).

**Руководство:** [сценарий и примеры](QUICKSTART.md).

**F12:** Первый интерфейс, Подключение и освобождение.

<a id="api-M"></a>
## Модификаторы

[M.is](#api-M-is) · [M.equals](#api-M-equals) · [M.then_](#api-M-then) · [M.padding](#api-M-padding) · [M.size](#api-M-size) · [M.width](#api-M-width) · [M.height](#api-M-height) · [M.size_in](#api-M-size-in) · [M.width_in](#api-M-width-in) · [M.height_in](#api-M-height-in) · [M.required_size](#api-M-required-size) · [M.fill_max_width](#api-M-fill-max-width) · [M.fill_max_height](#api-M-fill-max-height) · [M.fill_max_size](#api-M-fill-max-size) · [M.wrap_content](#api-M-wrap-content) · [M.aspect_ratio](#api-M-aspect-ratio) · [M.offset](#api-M-offset) · [M.weight](#api-M-weight) · [M.match_parent_size](#api-M-match-parent-size) · [M.align](#api-M-align) · [M.z_index](#api-M-z-index) · [M.vertical_scroll](#api-M-vertical-scroll) · [M.horizontal_scroll](#api-M-horizontal-scroll) · [M.background](#api-M-background) · [M.background_image](#api-M-background-image) · [M.border](#api-M-border) · [M.shadow](#api-M-shadow) · [M.rotate](#api-M-rotate) · [M.scale](#api-M-scale) · [M.clip](#api-M-clip) · [M.alpha](#api-M-alpha) · [M.clickable](#api-M-clickable) · [M.focusable](#api-M-focusable) · [M.block_pointer](#api-M-block-pointer) · [M.hoverable](#api-M-hoverable) · [M.draggable](#api-M-draggable) · [M.drop_target](#api-M-drop-target) · [M.pointer_input](#api-M-pointer-input) · [M.on_wheel](#api-M-on-wheel) · [M.cursor](#api-M-cursor) · [M.on_size](#api-M-on-size) · [M.on_placed](#api-M-on-placed) · [M.tag](#api-M-tag)

<a id="api-M-is"></a>
### `M.is`

Проверяет, является ли значение цепочкой Modifier. Вызывается M.is(value), без двоеточия.

**Сигнатура:** `M.is(value: any): boolean`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-M-equals"></a>
### `M.equals`

Сравнивает слои двух цепочек по содержимому. Служебный способ сравнения, не меняет ни одну цепочку; вызывается M.equals(a,b).

**Сигнатура:** `M.equals(a: KompotModifier, b: KompotModifier): boolean`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-M-then"></a>
### `M.then_`

Добавляет слои другой цепочки после текущих. Удобен для объединения общих и локальных модификаторов.

**Сигнатура:** `M:then_(other: KompotModifier): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-M-padding"></a>
### `M.padding`

Добавляет внутреннее пространство в точке цепочки. Один аргумент задаёт все стороны; два - горизонталь и вертикаль; четыре - left,top,right,bottom.

**Сигнатура:** `M:padding(a: number|KompotPadding, b?: number, c?: number, d?: number): KompotModifier`

**Начальные значения:** Поддерживаются одна, две или четыре величины либо таблица сторон. Не используйте три аргумента: нижняя сторона останется nil.

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier), [KompotPadding](API_TYPES.md#type-kompotpadding).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Порядок модификаторов.

<a id="api-M-size"></a>
### `M.size`

Задаёт желаемый размер; без height использует width по обеим осям. Родительские ограничения сохраняются.

**Сигнатура:** `M:size(width: number, height?: number): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Ключевые кадры и перемотка, Порядок модификаторов.

<a id="api-M-width"></a>
### `M.width`

Задаёт желаемую ширину в пикселях внутри ограничений родителя. Не означает долю свободного места - для этого нужен weight.

**Сигнатура:** `M:width(width: number): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** FlowRow и переносы.

<a id="api-M-height"></a>
### `M.height`

Задаёт желаемую высоту в пикселях. Для динамического содержимого без фиксированной высоты оставьте размер раскладке.

**Сигнатура:** `M:height(height: number): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Волна и фазовые сдвиги.

<a id="api-M-size-in"></a>
### `M.size_in`

Ограничивает диапазоны ширины и высоты. Неназванные границы не задавайте вместо нуля: nil сохраняет отсутствие соответствующего ограничения.

**Сигнатура:** `M:size_in(min_width?: number, max_width?: number, min_height?: number, max_height?: number): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Размеры и обрезка.

<a id="api-M-width-in"></a>
### `M.width_in`

Ограничивает минимальную и максимальную ширину. Подходит для кнопок и текста, растущих по содержимому.

**Сигнатура:** `M:width_in(min?: number, max?: number): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** FlowRow и переносы.

<a id="api-M-height-in"></a>
### `M.height_in`

Ограничивает минимальную и максимальную высоту. Для прокрутки нужно задать конечную область просмотра.

**Сигнатура:** `M:height_in(min?: number, max?: number): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Размеры и обрезка.

<a id="api-M-required-size"></a>
### `M.required_size`

Требует размер содержимого независимо от обычного согласования с родителем. Может выйти за доступное место; применяйте, когда это намеренно.

**Сигнатура:** `M:required_size(width: number, height?: number): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Порядок модификаторов.

<a id="api-M-fill-max-width"></a>
### `M.fill_max_width`

Занимает fraction доступной конечной ширины. Не получает ширину всего экрана независимо от родителя.

**Сигнатура:** `M:fill_max_width(fraction?: number): KompotModifier`

**Начальные значения:** fraction=1.

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Размеры и обрезка.

<a id="api-M-fill-max-height"></a>
### `M.fill_max_height`

Занимает fraction доступной конечной высоты. В неограниченной оси прокрутки не создаёт конечную высоту.

**Сигнатура:** `M:fill_max_height(fraction?: number): KompotModifier`

**Начальные значения:** fraction=1.

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Размеры и обрезка.

<a id="api-M-fill-max-size"></a>
### `M.fill_max_size`

Занимает доступный размер по двум осям. Для слоя поверх содержимого Box обычно нужен match_parent_size.

**Сигнатура:** `M:fill_max_size(fraction?: number): KompotModifier`

**Начальные значения:** fraction=1.

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Размеры и обрезка.

<a id="api-M-wrap-content"></a>
### `M.wrap_content`

Снимает минимальные ограничения в этой точке цепочки, сохраняя максимальные. Используется, когда содержимое должно выбирать свой размер.

**Сигнатура:** `M:wrap_content(): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Размеры и обрезка.

<a id="api-M-aspect-ratio"></a>
### `M.aspect_ratio`

Выбирает размер с заданным отношением ширины к высоте. Это ограничение прямоугольника элемента, а не режим масштабирования картинки.

**Сигнатура:** `M:aspect_ratio(ratio: number): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Размеры и обрезка.

<a id="api-M-offset"></a>
### `M.offset`

Сдвигает размещение без изменения измеренного размера. Соседи не резервируют место под сдвинутое положение.

**Сигнатура:** `M:offset(x?: number, y?: number): KompotModifier`

**Начальные значения:** x=0, y=0.

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Параллельные переходы, Ключевые кадры и перемотка, Волна и фазовые сдвиги, Орбиты и вложенное движение, Перестановка с сохранением движения, Выравнивание и слои, Перетаскивание.

<a id="api-M-weight"></a>
### `M.weight`

Делит остаток места между детьми Row/Column. fill=false разрешает ребёнку быть меньше выделенной доли.

**Сигнатура:** `M:weight(weight?: number, fill?: boolean): KompotModifier`

**Начальные значения:** weight=1, fill=true.

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Row, Column и Spacer.

<a id="api-M-match-parent-size"></a>
### `M.match_parent_size`

Измеряет ребёнка по окончательному размеру Box, не включая его в вычисление этого размера. Работает на прямом ребёнке Box.

**Сигнатура:** `M:match_parent_size(): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Выравнивание и слои, Картинка фоном: cover.

<a id="api-M-align"></a>
### `M.align`

Выравнивает ребёнка Box либо по поперечной оси Row/Column. Не выравнивает текст внутри Text - для него есть Text.align.

**Сигнатура:** `M:align(align: KompotAlign|KompotCrossAlign): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotAlign](API_TYPES.md#type-kompotalign), [KompotCrossAlign](API_TYPES.md#type-kompotcrossalign), [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Выравнивание и слои.

<a id="api-M-z-index"></a>
### `M.z_index`

Меняет порядок рисования и ввода соседей одного контейнера. Для всплывающих слоёв используется Popup.z.

**Сигнатура:** `M:z_index(z: number): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Выравнивание и слои.

<a id="api-M-vertical-scroll"></a>
### `M.vertical_scroll`

Прокручивает всех существующих детей по вертикали с ScrollState. Сам не виртуализует элементы.

**Сигнатура:** `M:vertical_scroll(state: KompotScrollState): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier), [KompotScrollState](API_TYPES.md#type-kompotscrollstate).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Обычная прокрутка.

<a id="api-M-horizontal-scroll"></a>
### `M.horizontal_scroll`

Прокручивает содержимое по горизонтали с ScrollState. Для длинного горизонтального набора рассмотрите LazyRow.

**Сигнатура:** `M:horizontal_scroll(state: KompotScrollState): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier), [KompotScrollState](API_TYPES.md#type-kompotscrollstate).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Обычная прокрутка.

<a id="api-M-background"></a>
### `M.background`

Рисует однотонный фон выбранной формы, не добавляя размер и обработку ввода. Форма фона не обрезает детей.

**Сигнатура:** `M:background(color: KompotColor, shape?: KompotShapeInput): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotColor](API_TYPES.md#type-kompotcolor), [KompotModifier](API_TYPES.md#type-kompotmodifier), [KompotShapeInput](API_TYPES.md#type-kompotshapeinput).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Своё оформление поля, Радиус каждого угла, Порядок модификаторов.

<a id="api-M-background-image"></a>
### `M.background_image`

Рисует материал nine-patch. Для иллюстрации с cover используйте Image отдельным ребёнком Box.

**Сигнатура:** `M:background_image(paint: KompotNinePatch, tint?: KompotColor): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotColor](API_TYPES.md#type-kompotcolor), [KompotModifier](API_TYPES.md#type-kompotmodifier), [KompotNinePatch](API_TYPES.md#type-kompotninepatch).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Nine-patch: рамки и повторение.

<a id="api-M-border"></a>
### `M.border`

Рисует рамку внутри границ выбранной формы. Задайте ту же форму, что у фона, если их контуры должны совпадать.

**Сигнатура:** `M:border(width: number, color: KompotColor, shape?: KompotShapeInput): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotColor](API_TYPES.md#type-kompotcolor), [KompotModifier](API_TYPES.md#type-kompotmodifier), [KompotShapeInput](API_TYPES.md#type-kompotshapeinput).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Своё оформление поля, Радиус каждого угла, Порядок модификаторов.

<a id="api-M-shadow"></a>
### `M.shadow`

Рисует тень с elevation, формой, цветом и необязательным вертикальным сдвигом. Не увеличивает размер раскладки.

**Сигнатура:** `M:shadow(elevation?: number, shape?: KompotShapeInput, color?: KompotColor, dy?: number): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotColor](API_TYPES.md#type-kompotcolor), [KompotModifier](API_TYPES.md#type-kompotmodifier), [KompotShapeInput](API_TYPES.md#type-kompotshapeinput).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Радиус каждого угла, Размеры и обрезка.

<a id="api-M-rotate"></a>
### `M.rotate`

Поворачивает рисунок, содержимое и области ввода вокруг pivot. Размер соседей не пересчитывается по повёрнутой рамке.

**Сигнатура:** `M:rotate(angle: number, pivot?: KompotPivot): KompotModifier`

**Начальные значения:** pivot={0.5,0.5}; угол в градусах.

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier), [KompotPivot](API_TYPES.md#type-kompotpivot).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-M-scale"></a>
### `M.scale`

Масштабирует рисунок и ввод относительно pivot. Для изменения размера раскладки используйте size, а не scale.

**Сигнатура:** `M:scale(x: number, y?: number, pivot?: KompotPivot): KompotModifier`

**Начальные значения:** y=x, pivot={0.5,0.5}.

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier), [KompotPivot](API_TYPES.md#type-kompotpivot).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-M-clip"></a>
### `M.clip`

Обрезает следующие слои и детей по форме. Не выбирает cover/contain и не управляет прокруткой сам по себе.

**Сигнатура:** `M:clip(shape?: KompotShapeInput): KompotModifier`

**Начальные значения:** Прямоугольная обрезка, если shape не задан.

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier), [KompotShapeInput](API_TYPES.md#type-kompotshapeinput).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Общая форма Shape, Радиус каждого угла, Размеры и обрезка.

<a id="api-M-alpha"></a>
### `M.alpha`

Умножает прозрачность поддерева. Нулевая прозрачность сама по себе не является удалением компонента или политикой отключения ввода.

**Сигнатура:** `M:alpha(alpha: number): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Параллельные переходы, Каскадное появление, Прерывание и разворот перехода, Смена сцены в несколько фаз, Размеры и обрезка.

<a id="api-M-clickable"></a>
### `M.clickable`

Добавляет нажатия, обработчики правой/долгой кнопки, взаимодействие и необязательный фокус. Для обычной кнопки с оформлением удобнее UI.Button.

**Сигнатура:** `M:clickable(on_click?: fun(), opts?: KompotClickOptions): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotClickOptions](API_TYPES.md#type-kompotclickoptions), [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Клавиатура и фокус.

<a id="api-M-focusable"></a>
### `M.focusable`

Добавляет обработку клавиш в локальном фокусе. Используйте для собственного контрола, а не для включения Tab во всём приложении.

**Сигнатура:** `M:focusable(on_key?: fun(key: string), opts?: KompotClickOptions): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotClickOptions](API_TYPES.md#type-kompotclickoptions), [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Клавиатура и фокус.

<a id="api-M-block-pointer"></a>
### `M.block_pointer`

Создаёт непрозрачную область ввода без пользовательского действия. Подходит панели, через которую клик не должен попадать в мир.

**Сигнатура:** `M:block_pointer(): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Перетаскивание, Цель перетаскивания, Указатель и колесо.

<a id="api-M-hoverable"></a>
### `M.hoverable`

Записывает наведение в Interaction или callback(bool). Сам не делает элемент нажимаемым.

**Сигнатура:** `M:hoverable(target: KompotInteraction|fun(hovered: boolean)): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotInteraction](API_TYPES.md#type-kompotinteraction), [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Наведение и подсказки.

<a id="api-M-draggable"></a>
### `M.draggable`

Добавляет жест перетаскивания со start/move/end/cancel. Изменение геометрии и перенос данных принадлежат владельцу.

**Сигнатура:** `M:draggable(opts: KompotDragOptions): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotDragOptions](API_TYPES.md#type-kompotdragoptions), [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Перетаскивание с пружинным возвратом, Раздвижные панели, Перетаскивание, Цель перетаскивания.

<a id="api-M-drop-target"></a>
### `M.drop_target`

Добавляет приём переносимых данных с enter/leave/drop. Возврат false из on_drop отклоняет перенос.

**Сигнатура:** `M:drop_target(opts?: KompotDropOptions): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotDropOptions](API_TYPES.md#type-kompotdropoptions), [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Цель перетаскивания.

<a id="api-M-pointer-input"></a>
### `M.pointer_input`

Доставляет низкоуровневые down/up/move/cancel. Для типовой кнопки или перетаскивания предпочтительнее готовый модификатор.

**Сигнатура:** `M:pointer_input(fn: fun(event: KompotPointerEvent)): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier), [KompotPointerEvent](API_TYPES.md#type-kompotpointerevent).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Указатель и колесо.

<a id="api-M-on-wheel"></a>
### `M.on_wheel`

Обрабатывает колесо; true означает, что событие использовано. false/nil позволяют передать его дальше.

**Сигнатура:** `M:on_wheel(fn: fun(delta: number): boolean?): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Указатель и колесо.

<a id="api-M-cursor"></a>
### `M.cursor`

Задаёт курсор над областью элемента. Это оформление указателя, не обработчик клика.

**Сигнатура:** `M:cursor(name: string): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Наведение и подсказки.

<a id="api-M-on-size"></a>
### `M.on_size`

Сообщает измеренные width,height после раскладки. Меняйте состояние только при реальном отличии, чтобы не создавать цикл перераскладки.

**Сигнатура:** `M:on_size(fn: fun(width: number, height: number)): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Своя раскладка.

<a id="api-M-on-placed"></a>
### `M.on_placed`

Сообщает экранное размещение x,y,width,height после раскладки. Не стройте дерево из callback.

**Сигнатура:** `M:on_placed(fn: fun(x: number, y: number, width: number, height: number)): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Своя раскладка.

<a id="api-M-tag"></a>
### `M.tag`

Присваивает диагностическую метку для App:find_tag и проверок. Не заменяет key и не сохраняет состояние при перестановке.

**Сигнатура:** `M:tag(name: string): KompotModifier`

**Контракт:** Цепочка неизменяемая: метод возвращает новый Modifier. Порядок слоёв важен; padding до фона и после фона даёт разный результат. Большинство методов вызывается с двоеточием.

**Параметры и результат:** [KompotModifier](API_TYPES.md#type-kompotmodifier).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

**F12:** Указатель и колесо.

<a id="api-K-Shape"></a>
## Формы

[K.Shape.rectangle](#api-K-Shape-rectangle) · [K.Shape.circle](#api-K-Shape-circle) · [K.Shape.rounded](#api-K-Shape-rounded) · [K.Shape.cut](#api-K-Shape-cut) · [K.Shape.px](#api-K-Shape-px) · [K.Shape.percent](#api-K-Shape-percent)

<a id="api-K-Shape-rectangle"></a>
### `K.Shape.rectangle`

Создаёт прямоугольную форму без скруглений. Передаётся в фон, рамку, тень и clip.

**Сигнатура:** `K.Shape.rectangle(): KompotShape`

**Контракт:** Незаданные углы равны нулю. Смежные слишком большие углы пропорционально уменьшаются; одна форма может использоваться всеми слоями.

**Параметры и результат:** [KompotShape](API_TYPES.md#type-kompotshape).

**Руководство:** [сценарий и примеры](UI.md).

<a id="api-K-Shape-circle"></a>
### `K.Shape.circle`

Создаёт круг для квадратной области и капсулу для прямоугольной. Размер разрешается при раскладке.

**Сигнатура:** `K.Shape.circle(): KompotShape`

**Контракт:** Незаданные углы равны нулю. Смежные слишком большие углы пропорционально уменьшаются; одна форма может использоваться всеми слоями.

**Параметры и результат:** [KompotShape](API_TYPES.md#type-kompotshape).

**Руководство:** [сценарий и примеры](UI.md).

<a id="api-K-Shape-rounded"></a>
### `K.Shape.rounded`

Создаёт скруглённую форму с общим или разными размерами углов. Число означает пиксели, percent - долю меньшей стороны.

**Сигнатура:** `K.Shape.rounded(size?: KompotCornerValue|KompotShapeCorners): KompotShape`

**Контракт:** Незаданные углы равны нулю. Смежные слишком большие углы пропорционально уменьшаются; одна форма может использоваться всеми слоями.

**Параметры и результат:** [KompotCornerValue](API_TYPES.md#type-kompotcornervalue), [KompotShape](API_TYPES.md#type-kompotshape), [KompotShapeCorners](API_TYPES.md#type-kompotshapecorners).

**Руководство:** [сценарий и примеры](UI.md).

**F12:** Общая форма Shape.

<a id="api-K-Shape-cut"></a>
### `K.Shape.cut`

Создаёт форму со срезанными углами. Толщина диагональной рамки согласована с её контуром.

**Сигнатура:** `K.Shape.cut(size?: KompotCornerValue|KompotShapeCorners): KompotShape`

**Контракт:** Незаданные углы равны нулю. Смежные слишком большие углы пропорционально уменьшаются; одна форма может использоваться всеми слоями.

**Параметры и результат:** [KompotCornerValue](API_TYPES.md#type-kompotcornervalue), [KompotShape](API_TYPES.md#type-kompotshape), [KompotShapeCorners](API_TYPES.md#type-kompotshapecorners).

**Руководство:** [сценарий и примеры](UI.md).

**F12:** Общая форма Shape.

<a id="api-K-Shape-px"></a>
### `K.Shape.px`

Описывает размер угла в пикселях. Полезен рядом с percent в таблице разных углов.

**Сигнатура:** `K.Shape.px(value: number): KompotCornerSize`

**Контракт:** Незаданные углы равны нулю. Смежные слишком большие углы пропорционально уменьшаются; одна форма может использоваться всеми слоями.

**Параметры и результат:** [KompotCornerSize](API_TYPES.md#type-kompotcornersize).

**Руководство:** [сценарий и примеры](UI.md).

<a id="api-K-Shape-percent"></a>
### `K.Shape.percent`

Описывает размер угла в процентах меньшей стороны, 0..100. Это не доля ширины родителя.

**Сигнатура:** `K.Shape.percent(value: number): KompotCornerSize`

**Контракт:** Незаданные углы равны нулю. Смежные слишком большие углы пропорционально уменьшаются; одна форма может использоваться всеми слоями.

**Параметры и результат:** [KompotCornerSize](API_TYPES.md#type-kompotcornersize).

**Руководство:** [сценарий и примеры](UI.md).

**F12:** Общая форма Shape.

<a id="api-K-color"></a>
## Цвет

[K.color.rgb](#api-K-color-rgb) · [K.color.hex](#api-K-color-hex) · [K.color.of](#api-K-color-of) · [K.color.to_hex](#api-K-color-to-hex) · [K.color.with_alpha](#api-K-color-with-alpha) · [K.color.mul_alpha](#api-K-color-mul-alpha) · [K.color.mix](#api-K-color-mix) · [K.color.over](#api-K-color-over) · [K.color.equals](#api-K-color-equals) · [K.color.to_hsl](#api-K-color-to-hsl) · [K.color.hsl](#api-K-color-hsl) · [K.color.lighten](#api-K-color-lighten) · [K.color.darken](#api-K-color-darken) · [K.color.luminance](#api-K-color-luminance) · [K.color.contrast](#api-K-color-contrast) · [K.color.on](#api-K-color-on) · [K.color.tone](#api-K-color-tone) · [K.color.palette](#api-K-color-palette) · [K.color.to255](#api-K-color-to255)

| Значение | Тип | Назначение |
|---|---|---|
| `K.color.WHITE` | `number[]` | Непрозрачный белый: {1,1,1,1}. |
| `K.color.BLACK` | `number[]` | Непрозрачный чёрный: {0,0,0,1}. |
| `K.color.TRANSPARENT` | `number[]` | Прозрачный чёрный: {0,0,0,0}. |

<a id="api-K-color-rgb"></a>
### `K.color.rgb`

Создаёт цвет из нормализованных r,g,b,a в диапазоне 0..1. Для каналов 0..255 сначала разделите их на 255.

**Сигнатура:** `K.color.rgb(r: number, g: number, b: number, a?: number): number[]`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-hex"></a>
### `K.color.hex`

Разбирает строковый цвет #RGB, #RRGGBB или #RRGGBBAA в нормализованный массив. Альфа расположена в конце строки.

**Сигнатура:** `K.color.hex(value: string): number[]`

**Ограничения:** Не используйте hex как валидатор пользовательского ввода: неверные каналы могут превратиться в нули. Сначала проверьте формат строки.

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-of"></a>
### `K.color.of`

Принимает поддерживаемый цвет и возвращает массив либо nil. Полезен на границе собственного API, принимающего строки и массивы.

**Сигнатура:** `K.color.of(value: KompotColor?): number[]?`

**Параметры и результат:** [KompotColor](API_TYPES.md#type-kompotcolor).

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-to-hex"></a>
### `K.color.to_hex`

Форматирует нормализованный цвет строкой #RRGGBBAA. Не меняет исходный массив.

**Сигнатура:** `K.color.to_hex(value: number[]): string`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-with-alpha"></a>
### `K.color.with_alpha`

Создаёт цвет с заменённой альфой. Для умножения существующей альфы используйте mul_alpha.

**Сигнатура:** `K.color.with_alpha(value: number[], alpha: number): number[]`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-mul-alpha"></a>
### `K.color.mul_alpha`

Умножает существующую альфу цвета на коэффициент. Подходит для плавного исчезновения.

**Сигнатура:** `K.color.mul_alpha(value: number[], alpha: number): number[]`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-mix"></a>
### `K.color.mix`

Интерполирует каналы двух цветов по t. Это вычисление значения, а не анимационный хук.

**Сигнатура:** `K.color.mix(a: number[], b: number[], t: number): number[]`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-over"></a>
### `K.color.over`

Смешивает верхний цвет поверх базового с учётом альфы. Не задаёт порядок элементов в интерфейсе.

**Сигнатура:** `K.color.over(base: number[], over: number[]): number[]`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-equals"></a>
### `K.color.equals`

Сравнивает нормализованные цвета по каналам. Подходит как функция сравнения State с цветом.

**Сигнатура:** `K.color.equals(a: number[], b: number[]): boolean`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-to-hsl"></a>
### `K.color.to_hsl`

Возвращает h (градусы), s и l (0..1) отдельными Lua-значениями. Используйте local h,s,l = ..., а не одну переменную для всех трёх.

**Сигнатура:** `K.color.to_hsl(value: number[]): number, number, number`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-hsl"></a>
### `K.color.hsl`

Создаёт нормализованный цвет из h,s,l и необязательной альфы. h задан в градусах, s и l в 0..1.

**Сигнатура:** `K.color.hsl(h: number, s: number, l: number, a?: number): number[]`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-lighten"></a>
### `K.color.lighten`

Осветляет цвет через светлоту HSL. Сохраняет альфу.

**Сигнатура:** `K.color.lighten(value: number[], amount: number): number[]`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-darken"></a>
### `K.color.darken`

Затемняет цвет через светлоту HSL. Сохраняет альфу.

**Сигнатура:** `K.color.darken(value: number[], amount: number): number[]`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-luminance"></a>
### `K.color.luminance`

Вычисляет относительную яркость RGB. Используется для проверки контраста, а не для изменения цвета.

**Сигнатура:** `K.color.luminance(value: number[]): number`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-contrast"></a>
### `K.color.contrast`

Вычисляет отношение контраста двух цветов. Для полупрозрачных цветов сначала учитывайте реальный фон.

**Сигнатура:** `K.color.contrast(a: number[], b: number[]): number`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-on"></a>
### `K.color.on`

Выбирает тёмный или светлый цвет содержимого по контрасту с фоном. Можно передать собственную пару кандидатов.

**Сигнатура:** `K.color.on(background: number[], dark?: number[], light?: number[]): number[]`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-tone"></a>
### `K.color.tone`

Создаёт непрозрачный тон исходного цвета со светлотой tone в 0..100 и необязательной насыщенностью. Это вспомогательное построение палитры.

**Сигнатура:** `K.color.tone(value: number[], tone: number, chroma?: number): number[]`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-palette"></a>
### `K.color.palette`

Создаёт таблицу тонов с числовыми ключами из набора 0..100; это не массив с непрерывными индексами. Для готовых семантических ролей интерфейса используйте тему.

**Сигнатура:** `K.color.palette(value: number[], chroma?: number): table<integer, number[]>`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-color-to255"></a>
### `K.color.to255`

Переводит нормализованный цвет в целочисленные каналы 0..255. Нужен на границе с низкоуровневой отрисовкой движка.

**Сигнатура:** `K.color.to255(value: number[], alpha_mul?: number): number[]`

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-K-fonts"></a>
## Шрифты

[K.fonts.register_family](#api-K-fonts-register-family) · [K.fonts.info](#api-K-fonts-info) · [K.fonts.resolve](#api-K-fonts-resolve) · [K.fonts.typography](#api-K-fonts-typography) · [K.fonts.register_metrics](#api-K-fonts-register-metrics)

<a id="api-K-fonts-register-family"></a>
### `K.fonts.register_family`

Регистрирует семейство из уже загруженных ресурсов шрифтов. Не загружает TTF и не заменяет preload.json; ID семейства включает namespace пака.

**Сигнатура:** `K.fonts.register_family(id: string, entries: table[]): nil`

**Руководство:** [сценарий и примеры](FONTS.md).

<a id="api-K-fonts-info"></a>
### `K.fonts.info`

Возвращает сведения о зарегистрированном ресурсе по имени либо nil. Не ищет произвольный файл на диске.

**Сигнатура:** `K.fonts.info(name: string): table?`

**Руководство:** [сценарий и примеры](FONTS.md).

<a id="api-K-fonts-resolve"></a>
### `K.fonts.resolve`

Находит ресурс семейства с точным размером и весом. При отсутствии сочетания возникает ошибка; автоматического масштабирования ближайшего размера нет.

**Сигнатура:** `K.fonts.resolve(id: string, size: number, weight?: string): string`

**Руководство:** [сценарий и примеры](FONTS.md).

<a id="api-K-fonts-typography"></a>
### `K.fonts.typography`

Строит таблицу стилей из defaults, выбранных семейств и overrides. Не регистрирует новые размеры шрифтов автоматически.

**Сигнатура:** `K.fonts.typography(defaults: table<string, KompotTextStyle>, opts?: table, overrides?: table): table<string, KompotTextStyle>`

**Параметры и результат:** [KompotTextStyle](API_TYPES.md#type-kompottextstyle).

**Руководство:** [сценарий и примеры](FONTS.md).

<a id="api-K-fonts-register-metrics"></a>
### `K.fonts.register_metrics`

Подключает заранее измеренные метрики. Нужен для соответствия внешнего превью движку; не влияет на загрузку самого шрифта.

**Сигнатура:** `K.fonts.register_metrics(metrics: table)`

**Руководство:** [сценарий и примеры](FONTS.md).

<a id="api-K-text"></a>
## Расчёт текста

[K.text.chars](#api-K-text-chars) · [K.text.layout](#api-K-text-layout) · [K.text.parse_md](#api-K-text-parse-md) · [K.text.layout_rich](#api-K-text-layout-rich) · [K.text.clear_cache](#api-K-text-clear-cache) · [K.text.approx_measurer](#api-K-text-approx-measurer) · [K.text.register_metrics](#api-K-text-register-metrics) · [K.text.metrics_measurer](#api-K-text-metrics-measurer) · [K.text.field_line_height](#api-K-text-field-line-height)

| Значение | Тип | Назначение |
|---|---|---|
| `K.text.version` | `integer` | Служебная версия общих метрик/кэша текста. |

<a id="api-K-text-chars"></a>
### `K.text.chars`

Разбивает UTF-8 строку на кодовые точки. Это не разбиение на видимые графемы, слова или строки.

**Сигнатура:** `K.text.chars(text: string): string[]`

**Контракт:** Это API расчёта текста, а не готовые компоненты. Для обычной подписи используйте K.Text, для пользовательского ввода BasicTextField/UI.TextField.

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

<a id="api-K-text-layout"></a>
### `K.text.layout`

Рассчитывает строки, ширины и высоту обычного текста по measurer и ограничениям. Для нативного редактируемого textbox используйте его собственную раскладку.

**Сигнатура:** `K.text.layout(measurer: KompotTextMeasurer, font: string, text: string|number, max_width: number, max_lines?: integer, wrap?: boolean, ellipsis?: boolean): KompotTextLayout`

**Контракт:** Это API расчёта текста, а не готовые компоненты. Для обычной подписи используйте K.Text, для пользовательского ввода BasicTextField/UI.TextField.

**Параметры и результат:** [KompotTextLayout](API_TYPES.md#type-kompottextlayout), [KompotTextMeasurer](API_TYPES.md#type-kompottextmeasurer).

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

<a id="api-K-text-parse-md"></a>
### `K.text.parse_md`

Разбирает поддерживаемую разметку md в текстовые фрагменты. Это небольшой синтаксис Kompot, а не полный Markdown-документ.

**Сигнатура:** `K.text.parse_md(text: string): table[]`

**Контракт:** Это API расчёта текста, а не готовые компоненты. Для обычной подписи используйте K.Text, для пользовательского ввода BasicTextField/UI.TextField.

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

<a id="api-K-text-layout-rich"></a>
### `K.text.layout_rich`

Рассчитывает строки стилизованных фрагментов. Передавайте метрики всех реально используемых шрифтов.

**Сигнатура:** `K.text.layout_rich(measurer: KompotTextMeasurer, runs: table[], max_width: number, max_lines?: integer, wrap?: boolean): KompotTextLayout`

**Контракт:** Это API расчёта текста, а не готовые компоненты. Для обычной подписи используйте K.Text, для пользовательского ввода BasicTextField/UI.TextField.

**Параметры и результат:** [KompotTextLayout](API_TYPES.md#type-kompottextlayout), [KompotTextMeasurer](API_TYPES.md#type-kompottextmeasurer).

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

<a id="api-K-text-clear-cache"></a>
### `K.text.clear_cache`

Очищает общий кэш текстовых раскладок. Не пересоздаёт State или загруженные шрифты.

**Сигнатура:** `K.text.clear_cache()`

**Контракт:** Это API расчёта текста, а не готовые компоненты. Для обычной подписи используйте K.Text, для пользовательского ввода BasicTextField/UI.TextField.

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

<a id="api-K-text-approx-measurer"></a>
### `K.text.approx_measurer`

Создаёт приблизительный измеритель для тестов и внешнего превью. Не обещает пиксельного совпадения с движком.

**Сигнатура:** `K.text.approx_measurer(scale?: number): KompotTextMeasurer`

**Контракт:** Это API расчёта текста, а не готовые компоненты. Для обычной подписи используйте K.Text, для пользовательского ввода BasicTextField/UI.TextField.

**Параметры и результат:** [KompotTextMeasurer](API_TYPES.md#type-kompottextmeasurer).

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

<a id="api-K-text-register-metrics"></a>
### `K.text.register_metrics`

Добавляет измеренные метрики и инвалидирует текстовый кэш. Удобнее вызывать через API fonts при настройке семейства.

**Сигнатура:** `K.text.register_metrics(metrics: table<string, table>)`

**Контракт:** Это API расчёта текста, а не готовые компоненты. Для обычной подписи используйте K.Text, для пользовательского ввода BasicTextField/UI.TextField.

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

<a id="api-K-text-metrics-measurer"></a>
### `K.text.metrics_measurer`

Создаёт измеритель на зарегистрированных метриках. Подходит App и внешнему рендереру без нативного GUI.

**Сигнатура:** `K.text.metrics_measurer(): KompotTextMeasurer`

**Контракт:** Это API расчёта текста, а не готовые компоненты. Для обычной подписи используйте K.Text, для пользовательского ввода BasicTextField/UI.TextField.

**Параметры и результат:** [KompotTextMeasurer](API_TYPES.md#type-kompottextmeasurer).

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

<a id="api-K-text-field-line-height"></a>
### `K.text.field_line_height`

Возвращает высоту строки нативного поля через measurer с предусмотренным fallback. Она может отличаться от высоты строки K.Text.

**Сигнатура:** `K.text.field_line_height(measurer: KompotTextMeasurer, font: string): number`

**Контракт:** Это API расчёта текста, а не готовые компоненты. Для обычной подписи используйте K.Text, для пользовательского ввода BasicTextField/UI.TextField.

**Параметры и результат:** [KompotTextMeasurer](API_TYPES.md#type-kompottextmeasurer).

**Руководство:** [сценарий и примеры](TEXT_INPUT.md).

<a id="api-state"></a>
## Объект State

value - наблюдаемое значение. set/update/patch/update_field вызываются с self. Изменение вложенной таблицы на месте не уведомляет подписчиков.

[state.set](#api-state-set) · [state.peek](#api-state-peek) · [state.update](#api-state-update) · [state.patch](#api-state-patch) · [state.update_field](#api-state-update-field)

| Значение | Тип | Назначение |
|---|---|---|
| `state.value` | `T` | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |

<a id="api-state-set"></a>
### `state.set`

Заменяет значение и уведомляет подписчиков, если оно изменилось по eq. Не мутируйте старую таблицу перед вызовом.

**Сигнатура:** `state:set(value: T)`

**Параметры и результат:** [KompotState](API_TYPES.md#type-kompotstate).

**Руководство:** [сценарий и примеры](STATE.md).

<a id="api-state-peek"></a>
### `state.peek`

Читает текущее значение без подписки области. В обработчике обновления удобно читать именно так.

**Сигнатура:** `state:peek(): T`

**Параметры и результат:** [KompotState](API_TYPES.md#type-kompotstate).

**Руководство:** [сценарий и примеры](STATE.md).

<a id="api-state-update"></a>
### `state.update`

Вычисляет новое значение из старого и передаёт его в set. Функция должна вернуть результат, а не изменить старую таблицу на месте.

**Сигнатура:** `state:update(fn: fun(value: T): T)`

**Параметры и результат:** [KompotState](API_TYPES.md#type-kompotstate).

**Руководство:** [сценарий и примеры](STATE.md).

<a id="api-state-patch"></a>
### `state.patch`

Поверхностно копирует таблицу состояния и заменяет перечисленные поля. Функции в changes сохраняются как данные, а не вызываются.

**Сигнатура:** `state:patch(changes: table)`

**Параметры и результат:** [KompotState](API_TYPES.md#type-kompotstate).

**Руководство:** [сценарий и примеры](STATE.md).

<a id="api-state-update-field"></a>
### `state.update_field`

Поверхностно копирует таблицу и меняет одно поле значением или вычисляющей функцией. nil удаляет поле; функцию как данные храните через patch.

**Сигнатура:** `state:update_field(key: any, value_or_fn: any|fun(old: any): any)`

**Параметры и результат:** [KompotState](API_TYPES.md#type-kompotstate).

**Руководство:** [сценарий и примеры](STATE.md).

<a id="api-local-value"></a>
## Локальное значение

[local_value.get](#api-local-value-get)

| Значение | Тип | Назначение |
|---|---|---|
| `local_value.default` | `T` | Значение Local при отсутствии ближайшего провайдера. |
| `local_value.name` | `string` | Идентификатор или имя описываемого объекта; точный namespace определяется содержащим типом. |

<a id="api-local-value-get"></a>
### `local_value.get`

Читает ближайшее предоставленное значение Local либо default. Вызывается с двоеточием во время композиции.

**Сигнатура:** `local_value:get(): T`

**Параметры и результат:** [KompotLocal](API_TYPES.md#type-kompotlocal).

**Руководство:** [сценарий и примеры](DESIGN_SYSTEM.md).

<a id="api-transition-state"></a>
## Состояние перехода

target_state записывается владельцем; current_state, is_idle и completion доступны только для чтения. Это не State с полем value.



| Значение | Тип | Назначение |
|---|---|---|
| `transition_state.target_state` | `T` | Записываемая цель перехода. |
| `transition_state.current_state` | `T` | Последнее завершённое состояние; только чтение. |
| `transition_state.is_idle` | `boolean` | Завершены все анимации; только чтение. |
| `transition_state.completion` | `integer` | Число завершений после применения кадра; изначально 0, только чтение. |

<a id="api-transition"></a>
## Группа перехода

[transition.animate](#api-transition-animate)

<a id="api-transition-animate"></a>
### `transition.animate`

Добавляет анимируемый канал в текущую группу. value_of(state) возвращает конечное число или числовой массив; каналы могут иметь разные спецификации.

**Сигнатура:** `transition:animate<V>(value_of: fun(state: T): V, spec?: KompotAnimationSpec): V`

**Параметры и результат:** [KompotAnimationSpec](API_TYPES.md#type-kompotanimationspec), [KompotTransition](API_TYPES.md#type-kompottransition).

**Руководство:** [сценарий и примеры](MOTION.md).

<a id="api-scroll"></a>
## Обычная прокрутка

value/max/view в пикселях; step=48 по умолчанию. Для уведомления раскладки меняйте позицию через scroll_to/scroll_by, а не присваиванием value.

[scroll.scroll_by](#api-scroll-scroll-by) · [scroll.scroll_to](#api-scroll-scroll-to) · [scroll.fraction](#api-scroll-fraction)

| Значение | Тип | Назначение |
|---|---|---|
| `scroll.value` | `number` | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |
| `scroll.max` | `number` | Предел или шаг числового контрола/прокрутки. step - величина шага, steps у Slider - число интервалов. |
| `scroll.view` | `number` | Позиция, смещение, объём или размер видимой области прокрутки. После раскладки значения уточняются. |
| `scroll.step` | `number` | Предел или шаг числового контрола/прокрутки. step - величина шага, steps у Slider - число интервалов. |

<a id="api-scroll-scroll-by"></a>
### `scroll.scroll_by`

Изменяет позицию на delta пикселей в пределах 0..max. Возвращает фактический сдвиг, который может быть меньше запрошенного.

**Сигнатура:** `scroll:scroll_by(delta: number): number`

**Параметры и результат:** [KompotScrollState](API_TYPES.md#type-kompotscrollstate).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-scroll-scroll-to"></a>
### `scroll.scroll_to`

Переходит к абсолютной позиции в пикселях с ограничением по границам. Пределы становятся известны после раскладки.

**Сигнатура:** `scroll:scroll_to(value: number): number`

**Параметры и результат:** [KompotScrollState](API_TYPES.md#type-kompotscrollstate).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-scroll-fraction"></a>
### `scroll.fraction`

Возвращает долю прокрутки и долю видимой части двумя Lua-значениями. Используется Scrollbar.

**Сигнатура:** `scroll:fraction(): number, number`

**Параметры и результат:** [KompotScrollState](API_TYPES.md#type-kompotscrollstate).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-lazy"></a>
## Ленивая прокрутка

first начинается с 1. Пределы и оценка total уточняются по мере измерения видимых элементов.

[lazy.scroll_by](#api-lazy-scroll-by) · [lazy.scroll_to_item](#api-lazy-scroll-to-item) · [lazy.first_visible](#api-lazy-first-visible) · [lazy.fraction](#api-lazy-fraction)

| Значение | Тип | Назначение |
|---|---|---|
| `lazy.first` | `integer` | Индекс первого видимого элемента Lua от 1. |
| `lazy.offset` | `number` | Позиция, смещение, объём или размер видимой области прокрутки. После раскладки значения уточняются. |
| `lazy.total` | `number` | Позиция, смещение, объём или размер видимой области прокрутки. После раскладки значения уточняются. |
| `lazy.view` | `number` | Позиция, смещение, объём или размер видимой области прокрутки. После раскладки значения уточняются. |
| `lazy.step` | `number` | Предел или шаг числового контрола/прокрутки. step - величина шага, steps у Slider - число интервалов. |

<a id="api-lazy-scroll-by"></a>
### `lazy.scroll_by`

Смещает виртуализованный список на delta пикселей. Точные размеры ещё не измеренных элементов уточняются при раскладке.

**Сигнатура:** `lazy:scroll_by(delta: number): number`

**Параметры и результат:** [KompotLazyState](API_TYPES.md#type-kompotlazystate).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-lazy-scroll-to-item"></a>
### `lazy.scroll_to_item`

Запрашивает переход к элементу с индексом от 1. Состояние применяется связанной Lazy-раскладкой.

**Сигнатура:** `lazy:scroll_to_item(index: integer)`

**Параметры и результат:** [KompotLazyState](API_TYPES.md#type-kompotlazystate).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-lazy-first-visible"></a>
### `lazy.first_visible`

Возвращает индекс первого видимого элемента от 1. Не является индексом массива TypeScript от 0.

**Сигнатура:** `lazy:first_visible(): integer`

**Параметры и результат:** [KompotLazyState](API_TYPES.md#type-kompotlazystate).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-lazy-fraction"></a>
### `lazy.fraction`

Возвращает оценку позиции и видимой доли для полосы прокрутки. До измерения списка это не точная карта всех высот.

**Сигнатура:** `lazy:fraction(): number, number`

**Параметры и результат:** [KompotLazyState](API_TYPES.md#type-kompotlazystate).

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-handle"></a>
## Смонтированный интерфейс

[handle.dispose](#api-handle-dispose) · [handle.set_content](#api-handle-set-content) · [handle.set_theme](#api-handle-set-theme) · [handle.is_over](#api-handle-is-over)

| Значение | Тип | Назначение |
|---|---|---|
| `handle.disposed` | `boolean` | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `handle.app` | `KompotAppInstance` | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `handle.backend` | `table` | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `handle.host` | `any` | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `handle.fake_input` | `table` | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `handle.close_pending` | `boolean` | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |

<a id="api-handle-dispose"></a>
### `handle.dispose`

Завершает приложение, эффекты и нативный хост. Повторный вызов безопасен; скрытие макета без уничтожения не равно dispose.

**Сигнатура:** `handle:dispose()`

**Параметры и результат:** [KompotMountHandle](API_TYPES.md#type-kompotmounthandle).

**Руководство:** [сценарий и примеры](QUICKSTART.md).

**F12:** Подключение и освобождение.

<a id="api-handle-set-content"></a>
### `handle.set_content`

Меняет корневую функцию и намеренно создаёт новую группу состояния. Для сохранения формы обычно достаточно менять её State.

**Сигнатура:** `handle:set_content(content: KompotContent)`

**Параметры и результат:** [KompotContent](API_TYPES.md#type-kompotcontent), [KompotMountHandle](API_TYPES.md#type-kompotmounthandle).

**Руководство:** [сценарий и примеры](QUICKSTART.md).

**F12:** Подключение и освобождение.

<a id="api-handle-set-theme"></a>
### `handle.set_theme`

Меняет тему смонтированного приложения и прогревает её шрифты. Не создаёт второе окно.

**Сигнатура:** `handle:set_theme(theme: KompotTheme)`

**Параметры и результат:** [KompotMountHandle](API_TYPES.md#type-kompotmounthandle), [KompotTheme](API_TYPES.md#type-kompottheme).

**Руководство:** [сценарий и примеры](QUICKSTART.md).

**F12:** Подключение и освобождение.

<a id="api-handle-is-over"></a>
### `handle.is_over`

Проверяет, находится ли экранная точка над областью ввода или block_pointer этого интерфейса. После dispose возвращает false.

**Сигнатура:** `handle:is_over(x: number, y: number): boolean`

**Параметры и результат:** [KompotMountHandle](API_TYPES.md#type-kompotmounthandle).

**Руководство:** [сценарий и примеры](QUICKSTART.md).

**F12:** Подключение и освобождение.

<a id="api-K-App"></a>
## Конструктор приложения

[K.App.new](#api-K-App-new)

<a id="api-K-App-new"></a>
### `K.App.new`

Создаёт приложение без автоматического хоста и кадров движка. Владелец передаёт measurer/backend, вызывает frame и dispose.

**Сигнатура:** `K.App.new(opts: KompotAppOptions): KompotAppInstance`

**Параметры и результат:** [KompotAppInstance](API_TYPES.md#type-kompotappinstance), [KompotAppOptions](API_TYPES.md#type-kompotappoptions).

**Руководство:** [сценарий и примеры](PREVIEW.md).

<a id="api-app"></a>
## Кадровый цикл

[app.set_size](#api-app-set-size) · [app.frame](#api-app-frame) · [app.find_tag](#api-app-find-tag) · [app.dispose](#api-app-dispose)

| Значение | Тип | Назначение |
|---|---|---|
| `app.rt` | `table<string, any>` | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `app.input` | `table<string, any>` | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `app.dl` | `table[]` | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `app.stats` | `table<string, number>` | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |

<a id="api-app-set-size"></a>
### `app.set_size`

Задаёт размер области приложения и запрашивает новую раскладку. Не меняет размер окна движка автоматически.

**Сигнатура:** `app:set_size(width: number, height: number)`

**Параметры и результат:** [KompotAppInstance](API_TYPES.md#type-kompotappinstance).

**Руководство:** [сценарий и примеры](PREVIEW.md).

<a id="api-app-frame"></a>
### `app.frame`

Выполняет один кадр с dt в секундах и необязательным событием ввода. Возвращает, был ли подготовлен новый рисунок; завершает эффекты после применения.

**Сигнатура:** `app:frame(dt?: number, event?: table): boolean`

**Параметры и результат:** [KompotAppInstance](API_TYPES.md#type-kompotappinstance).

**Руководство:** [сценарий и примеры](PREVIEW.md).

<a id="api-app-find-tag"></a>
### `app.find_tag`

Находит размещённый элемент по метке после кадра. Для идентичности State нужен key, а не tag.

**Сигнатура:** `app:find_tag(name: string): table?`

**Параметры и результат:** [KompotAppInstance](API_TYPES.md#type-kompotappinstance).

**Руководство:** [сценарий и примеры](PREVIEW.md).

<a id="api-app-dispose"></a>
### `app.dispose`

Освобождает области композиции, эффекты и backend приложения. Нужен при собственном кадровом цикле без mount.

**Сигнатура:** `app:dispose()`

**Параметры и результат:** [KompotAppInstance](API_TYPES.md#type-kompotappinstance).

**Руководство:** [сценарий и примеры](PREVIEW.md).

<a id="api-canvas"></a>
## Рисование на холсте

Координаты локальные, целочисленные. Методы set/line/rect/clear используют байтовые каналы 0..255 или упакованный цвет; Image options.color использует KompotColor.

[canvas.image](#api-canvas-image) · [canvas.set](#api-canvas-set) · [canvas.line](#api-canvas-line) · [canvas.rect](#api-canvas-rect) · [canvas.clear](#api-canvas-clear)

| Значение | Тип | Назначение |
|---|---|---|
| `canvas.width` | `number` | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `canvas.height` | `number` | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |

<a id="api-canvas-image"></a>
### `canvas.image`

Рисует текстуру или Raster на холсте с преобразованием, UV, tint и alpha. Методы вызываются с двоеточием; регион источника задаётся в 0..1.

**Сигнатура:** `canvas:image(src: string|KompotRaster, opts?: KompotCanvasImageOptions)`

**Параметры и результат:** [KompotCanvas](API_TYPES.md#type-kompotcanvas), [KompotCanvasImageOptions](API_TYPES.md#type-kompotcanvasimageoptions), [KompotRaster](API_TYPES.md#type-kompotraster).

**Руководство:** [сценарий и примеры](MOTION.md).

<a id="api-canvas-set"></a>
### `canvas.set`

Записывает пиксель по локальным x,y. Каналы r,g,b,a заданы в 0..255; один r может быть упакованным цветом движка.

**Сигнатура:** `canvas:set(x: number, y: number, r: number, g?: number, b?: number, a?: number)`

**Параметры и результат:** [KompotCanvas](API_TYPES.md#type-kompotcanvas).

**Руководство:** [сценарий и примеры](MOTION.md).

<a id="api-canvas-line"></a>
### `canvas.line`

Рисует отрезок между целочисленными точками в координатах холста. Не создаёт отдельный элемент интерфейса.

**Сигнатура:** `canvas:line(x1: number, y1: number, x2: number, y2: number, r: number, g?: number, b?: number, a?: number)`

**Параметры и результат:** [KompotCanvas](API_TYPES.md#type-kompotcanvas).

**Руководство:** [сценарий и примеры](MOTION.md).

<a id="api-canvas-rect"></a>
### `canvas.rect`

Рисует заполненный прямоугольник в координатах холста. Это операция пикселей, не K.Box и не модификатор.

**Сигнатура:** `canvas:rect(x: number, y: number, width: number, height: number, r: number, g?: number, b?: number, a?: number)`

**Параметры и результат:** [KompotCanvas](API_TYPES.md#type-kompotcanvas).

**Руководство:** [сценарий и примеры](MOTION.md).

<a id="api-canvas-clear"></a>
### `canvas.clear`

Очищает холст перед новым рисунком. Без цвета заполняет прозрачностью.

**Сигнатура:** `canvas:clear(r?: number, g?: number, b?: number, a?: number)`

**Параметры и результат:** [KompotCanvas](API_TYPES.md#type-kompotcanvas).

**Руководство:** [сценарий и примеры](MOTION.md).

<a id="api-measure-api"></a>
## Измерение собственной раскладки

[measure_api.measure](#api-measure-api-measure) · [measure_api.place](#api-measure-api-place)

| Значение | Тип | Назначение |
|---|---|---|
| `measure_api.INF` | `number` | Бесконечная верхняя граница измерения, а не размер экрана. |

<a id="api-measure-api-measure"></a>
### `measure_api.measure`

Измеряет ребёнка в переданном диапазоне и возвращает width,height двумя значениями. Вызов с точными min=max требует соответствующий размер.

**Сигнатура:** `measure_api.measure(child: any, min_width: number, max_width: number, min_height: number, max_height: number): number, number`

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-measure-api-place"></a>
### `measure_api.place`

Размещает ранее измеренного ребёнка относительно содержимого Layout. Координаты локальные, а не экранные.

**Сигнатура:** `measure_api.place(child: any, x: number, y: number)`

**Руководство:** [сценарий и примеры](CONCEPTS.md).

<a id="api-measurer"></a>
## Измеритель текста

[measurer.width](#api-measurer-width) · [measurer.line_height](#api-measurer-line-height) · [measurer.field_line_height](#api-measurer-field-line-height)

<a id="api-measurer-width"></a>
### `measurer.width`

Возвращает ширину текста в указанном шрифте. В собственном backend реализация обязана согласовываться с реальной отрисовкой.

**Сигнатура:** `measurer:width(font: string, text: string): number`

**Параметры и результат:** [KompotTextMeasurer](API_TYPES.md#type-kompottextmeasurer).

**Руководство:** [сценарий и примеры](FONTS.md).

<a id="api-measurer-line-height"></a>
### `measurer.line_height`

Возвращает высоту строки K.Text. Для textbox может использоваться другая высота field_line_height.

**Сигнатура:** `measurer:line_height(font: string): number`

**Параметры и результат:** [KompotTextMeasurer](API_TYPES.md#type-kompottextmeasurer).

**Руководство:** [сценарий и примеры](FONTS.md).

<a id="api-measurer-field-line-height"></a>
### `measurer.field_line_height`

Необязательный метод высоты строки нативного поля. Если отсутствует, K.text.field_line_height использует предусмотренный fallback.

**Сигнатура:** `measurer:field_line_height(font: string): number`

**Параметры и результат:** [KompotTextMeasurer](API_TYPES.md#type-kompottextmeasurer).

**Руководство:** [сценарий и примеры](FONTS.md).
