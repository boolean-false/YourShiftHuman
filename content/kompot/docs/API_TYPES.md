# Типы и свойства API

<!-- Сгенерировано tools/build_api_reference.py. -->

[Выбор API](API.md) · [Ядро](API_CORE.md) · [Kompot UI](API_UI.md)

Это структурный справочник, а не алгоритм работы компонентов. Отсутствие `?` означает обязательность по типу; ограничения и начальные значения смотрите в карточке функции. Наследуемые поля вынесены в базовый тип. Все размеры в пикселях, если не указана другая единица.

## Указатель

- [KompotAlign](#type-kompotalign)
- [KompotAnimationSpec](#type-kompotanimationspec)
- [KompotApi](#type-kompotapi)
- [KompotApp](#type-kompotapp)
- [KompotAppInstance](#type-kompotappinstance)
- [KompotAppOptions](#type-kompotappoptions)
- [KompotArrangement](#type-kompotarrangement)
- [KompotBasicTextFieldProps](#type-kompotbasictextfieldprops)
- [KompotBoxProps](#type-kompotboxprops)
- [KompotCanvas](#type-kompotcanvas)
- [KompotCanvasImageOptions](#type-kompotcanvasimageoptions)
- [KompotCanvasProps](#type-kompotcanvasprops)
- [KompotClickOptions](#type-kompotclickoptions)
- [KompotColor](#type-kompotcolor)
- [KompotColorApi](#type-kompotcolorapi)
- [KompotContent](#type-kompotcontent)
- [KompotCornerSize](#type-kompotcornersize)
- [KompotCornerValue](#type-kompotcornervalue)
- [KompotCorners](#type-kompotcorners)
- [KompotCrossAlign](#type-kompotcrossalign)
- [KompotDragEvent](#type-kompotdragevent)
- [KompotDragOptions](#type-kompotdragoptions)
- [KompotDropOptions](#type-kompotdropoptions)
- [KompotEditorValue](#type-kompoteditorvalue)
- [KompotFlowProps](#type-kompotflowprops)
- [KompotFontApi](#type-kompotfontapi)
- [KompotIconProps](#type-kompoticonprops)
- [KompotImageFit](#type-kompotimagefit)
- [KompotImageProps](#type-kompotimageprops)
- [KompotInteraction](#type-kompotinteraction)
- [KompotLayoutProps](#type-kompotlayoutprops)
- [KompotLazyGridProps](#type-kompotlazygridprops)
- [KompotLazyProps](#type-kompotlazyprops)
- [KompotLazyState](#type-kompotlazystate)
- [KompotLinearProps](#type-kompotlinearprops)
- [KompotLocal](#type-kompotlocal)
- [KompotMeasureApi](#type-kompotmeasureapi)
- [KompotModifier](#type-kompotmodifier)
- [KompotMountHandle](#type-kompotmounthandle)
- [KompotMountOptions](#type-kompotmountoptions)
- [KompotNinePatch](#type-kompotninepatch)
- [KompotNinePatchOptions](#type-kompotninepatchoptions)
- [KompotPadding](#type-kompotpadding)
- [KompotPivot](#type-kompotpivot)
- [KompotPlacement](#type-kompotplacement)
- [KompotPointerEvent](#type-kompotpointerevent)
- [KompotPopupProps](#type-kompotpopupprops)
- [KompotPreviewEntry](#type-kompotpreviewentry)
- [KompotPreviewOptions](#type-kompotpreviewoptions)
- [KompotProps](#type-kompotprops)
- [KompotRadius](#type-kompotradius)
- [KompotRaster](#type-kompotraster)
- [KompotRasterOptions](#type-kompotrasteroptions)
- [KompotRect](#type-kompotrect)
- [KompotScrollState](#type-kompotscrollstate)
- [KompotShape](#type-kompotshape)
- [KompotShapeApi](#type-kompotshapeapi)
- [KompotShapeCorners](#type-kompotshapecorners)
- [KompotShapeInput](#type-kompotshapeinput)
- [KompotSnap](#type-kompotsnap)
- [KompotSpring](#type-kompotspring)
- [KompotState](#type-kompotstate)
- [KompotTextAlign](#type-kompottextalign)
- [KompotTextApi](#type-kompottextapi)
- [KompotTextInputProps](#type-kompottextinputprops)
- [KompotTextLayout](#type-kompottextlayout)
- [KompotTextMeasurer](#type-kompottextmeasurer)
- [KompotTextProps](#type-kompottextprops)
- [KompotTextSpan](#type-kompottextspan)
- [KompotTextStyle](#type-kompottextstyle)
- [KompotTheme](#type-kompottheme)
- [KompotTransition](#type-kompottransition)
- [KompotTransitionState](#type-kompottransitionstate)
- [KompotTween](#type-kompottween)
- [KompotUiActionHintProps](#type-kompotuiactionhintprops)
- [KompotUiApi](#type-kompotuiapi)
- [KompotUiBadgeProps](#type-kompotuibadgeprops)
- [KompotUiBarProps](#type-kompotuibarprops)
- [KompotUiButtonProps](#type-kompotuibuttonprops)
- [KompotUiCardProps](#type-kompotuicardprops)
- [KompotUiChoiceDefaults](#type-kompotuichoicedefaults)
- [KompotUiChoiceProps](#type-kompotuichoiceprops)
- [KompotUiComponentDefaults](#type-kompotuicomponentdefaults)
- [KompotUiContract](#type-kompotuicontract)
- [KompotUiDialogAction](#type-kompotuidialogaction)
- [KompotUiDialogProps](#type-kompotuidialogprops)
- [KompotUiDividerProps](#type-kompotuidividerprops)
- [KompotUiFieldProps](#type-kompotuifieldprops)
- [KompotUiHotbarProps](#type-kompotuihotbarprops)
- [KompotUiHudProps](#type-kompotuihudprops)
- [KompotUiIconButtonDefaults](#type-kompotuiiconbuttondefaults)
- [KompotUiIconButtonProps](#type-kompotuiiconbuttonprops)
- [KompotUiInventoryProps](#type-kompotuiinventoryprops)
- [KompotUiItem](#type-kompotuiitem)
- [KompotUiItemDetailsProps](#type-kompotuiitemdetailsprops)
- [KompotUiItemSlotProps](#type-kompotuiitemslotprops)
- [KompotUiKeyProps](#type-kompotuikeyprops)
- [KompotUiLabeledFieldProps](#type-kompotuilabeledfieldprops)
- [KompotUiListItemProps](#type-kompotuilistitemprops)
- [KompotUiListRowProps](#type-kompotuilistrowprops)
- [KompotUiLuaProps](#type-kompotuiluaprops)
- [KompotUiMachinePanelProps](#type-kompotuimachinepanelprops)
- [KompotUiMenuBarProps](#type-kompotuimenubarprops)
- [KompotUiMenuItemProps](#type-kompotuimenuitemprops)
- [KompotUiMenuProps](#type-kompotuimenuprops)
- [KompotUiOption](#type-kompotuioption)
- [KompotUiPanelProps](#type-kompotuipanelprops)
- [KompotUiPreviewProps](#type-kompotuipreviewprops)
- [KompotUiProgressProps](#type-kompotuiprogressprops)
- [KompotUiProps](#type-kompotuiprops)
- [KompotUiResourceBarProps](#type-kompotuiresourcebarprops)
- [KompotUiScrollbarDefaults](#type-kompotuiscrollbardefaults)
- [KompotUiScrollbarProps](#type-kompotuiscrollbarprops)
- [KompotUiSegmentedDefaults](#type-kompotuisegmenteddefaults)
- [KompotUiSegmentedOption](#type-kompotuisegmentedoption)
- [KompotUiSegmentedProps](#type-kompotuisegmentedprops)
- [KompotUiSelectDefaults](#type-kompotuiselectdefaults)
- [KompotUiSelectProps](#type-kompotuiselectprops)
- [KompotUiSkin](#type-kompotuiskin)
- [KompotUiSkinInput](#type-kompotuiskininput)
- [KompotUiSliderProps](#type-kompotuisliderprops)
- [KompotUiSplitPaneDefaults](#type-kompotuisplitpanedefaults)
- [KompotUiSplitPaneProps](#type-kompotuisplitpaneprops)
- [KompotUiStepperProps](#type-kompotuistepperprops)
- [KompotUiSurfaceContext](#type-kompotuisurfacecontext)
- [KompotUiSurfaceStyle](#type-kompotuisurfacestyle)
- [KompotUiTabsDefaults](#type-kompotuitabsdefaults)
- [KompotUiTabsProps](#type-kompotuitabsprops)
- [KompotUiTheme](#type-kompotuitheme)
- [KompotUiThemeOptions](#type-kompotuithemeoptions)
- [KompotUiToastProps](#type-kompotuitoastprops)
- [KompotUiToggleProps](#type-kompotuitoggleprops)
- [KompotUiTooltipDefaults](#type-kompotuitooltipdefaults)
- [KompotUiTooltipProps](#type-kompotuitooltipprops)
- [KompotUiVectorFieldProps](#type-kompotuivectorfieldprops)
- [KompotUiWindowProps](#type-kompotuiwindowprops)

<a id="type-kompotalign"></a>
## `KompotAlign`

`'top_start'|'top_center'|'top_end'|'center_start'|'center'|'center_end'|'bottom_start'|'bottom_center'|'bottom_end'`



<a id="type-kompotanimationspec"></a>
## `KompotAnimationSpec`

`KompotTween|KompotSpring|KompotSnap`

[KompotSnap](API_TYPES.md#type-kompotsnap), [KompotSpring](API_TYPES.md#type-kompotspring), [KompotTween](API_TYPES.md#type-kompottween)

<a id="type-kompotapi"></a>
## `KompotApi`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `VERSION` | `string` | нет | Версия ядра Kompot. Не путайте с внутренней версией дизайн-системы UI.VERSION. |
| `copy` | `fun<T>(source: T, changes?: table): T` | нет | Копия таблицы с заменой полей; вложенные значения общие, метатаблица не копируется. |
| `Modifier` | `KompotModifier` | нет | Алиас K.M; не конструктор с new. |
| `M` | `KompotModifier` | нет | Пустая неизменяемая цепочка Modifier, отправная точка для M:size(...). |
| `Shape` | `KompotShapeApi` | нет | Конструкторы форм; точные методы перечислены ниже. |
| `rounded_corners` | `fun(radius?: KompotRadius): KompotRadius` | нет | Копирует и проверяет радиусы углов. |
| `nine_patch` | `fun(source: string\|KompotRaster, opts?: KompotNinePatchOptions): KompotNinePatch` | нет | Рамки и повторение. source - texture/path или atlas:sprite; для cover используйте K.Image. |
| `raster` | `fun(opts: KompotRasterOptions): KompotRaster` | нет | Описывает процедурный источник пикселей для nine-patch и Canvas:image. key идентифицирует ресурс, version меняется при изменении исходных пикселей. |
| `Box` | `fun(a: KompotBoxProps\|KompotModifier\|KompotContent, content?: KompotContent)` | нет | Накладывает детей друг на друга в порядке объявления. Подходит для фона и содержимого поверх него; обычных детей измеряет до match_parent_size. |
| `Row` | `fun(a: KompotLinearProps\|KompotModifier\|KompotContent, content?: KompotContent)` | нет | Размещает детей по горизонтали. Для вертикального списка используйте Column, для автоматического переноса FlowRow. |
| `Column` | `fun(a: KompotLinearProps\|KompotModifier\|KompotContent, content?: KompotContent)` | нет | Размещает детей по вертикали. Она не прокручивается сама; прокрутку задаёт модификатор со ScrollState. |
| `FlowRow` | `fun(a: KompotFlowProps\|KompotModifier\|KompotContent, content?: KompotContent)` | нет | Переносит элементы на следующие строки, когда не хватает ограниченной ширины. Не виртуализирует содержимое. |
| `Spacer` | `fun(width: number\|KompotModifier, height?: number)` | нет | Занимает пустое место без рисунка и ввода. Передайте число для ширины либо modifier для height/weight. |
| `Text` | `fun(text: string\|number\|nil, props?: KompotTextProps)` | нет | Рисует текст с переносами, стилем, цветом и необязательной разметкой md. Для пользовательского ввода нужен TextInput или BasicTextField. |
| `Image` | `fun(source: string, props?: KompotImageProps)` | нет | source - texture/path или atlas:sprite, без префикса пака. Поддерживает fit и фоновый слой в Box. |
| `Icon` | `fun(name: string, props?: KompotIconProps)` | нет | Ищет значок в атласе icons текущей темы. Для произвольного пути текстуры используйте Image; базовая тема не обещает атлас значков. |
| `Canvas` | `fun(props: KompotCanvasProps)` | нет | Создаёт рисуемый холст конечного размера с callback draw(canvas,w,h). version управляет повторной отрисовкой; размер холста задаёт раскладка. |
| `Layout` | `fun(props: KompotLayoutProps, content: KompotContent)` | нет | Задаёт собственные измерение и размещение детей через measure и api.measure/api.place. Нужен для раскладок, которые не выражаются Row/Column/Box. |
| `TextInput` | `fun(props: KompotTextInputProps)` | нет | Низкоуровневый нативный textbox движка. Даёт прямые value и события; для управляемого текста и защиты от старого value используйте BasicTextField. |
| `BasicTextField` | `fun(props: KompotBasicTextFieldProps)` | нет | Управляет строковым state, editor_state или value/on_change без фирменного оформления. Выбирайте один способ владения текстом. |
| `new_text_field_state` | `fun(initial?: string): KompotState<KompotEditorValue>` | нет | Создаёт внешний State с text, anchor и caret. Для использования editor_state нужен движок с API выделения и текстовой раскладки. |
| `text_field_state` | `fun(initial?: string): KompotState<KompotEditorValue>` | нет | Запоминает состояние текста и выделения в компоненте. Инициализация не повторяется при перекомпозиции. |
| `scroll_state` | `fun(initial?: number): KompotScrollState` | нет | Запоминает позицию обычной прокрутки. Подходит, когда все дети уже существуют; для больших наборов используйте lazy_state и LazyColumn/Grid. |
| `lazy_state` | `fun(): KompotLazyState` | нет | Запоминает позицию виртуализованного списка. Для внешней модели доступен прямой Scroll.new_lazy из модуля совместимости. |
| `LazyColumn` | `fun(props: KompotLazyProps)` | нет | Строит видимую часть вертикального списка из count и item(index). Не создавайте все элементы заранее; key_of сохраняет идентичность при перестановке. |
| `LazyRow` | `fun(props: KompotLazyProps)` | нет | Виртуализует горизонтальный список. Использует тот же LazyState и контракт item, что LazyColumn. |
| `LazyGrid` | `fun(props: KompotLazyGridProps)` | нет | Виртуализует сетку с заданным числом columns. Нужна ограниченная область просмотра по оси прокрутки. |
| `Popup` | `fun(props: KompotPopupProps, content: KompotContent)` | нет | Рисует содержимое отдельным слоем относительно якоря с placement и z. Не добавляет закрытие, затемнение и управление состоянием - это делают Window/Menu/Dialog. |
| `state` | `fun<T>(initial: T, eq?: fun(a: T, b: T): boolean): KompotState<T>` | нет | Состояние, принадлежащее владельцу компонента; тип определяет текстовую модель или положение прокрутки. |
| `form` | `fun(initial: table): table<any, KompotState<any>>` | нет | Фиксированный набор состояний полей; для новой схемы пересоздайте через K.key. |
| `new_state` | `fun<T>(initial: T, eq?: fun(a: T, b: T): boolean): KompotState<T>` | нет | Создаёт состояние вне композиции. Подходит для модели, переживающей закрытие окна; не создавайте новое состояние на каждой перекомпозиции. |
| `remember` | `fun<T>(initial: fun(): T, ...: any): T` | нет | Запоминает результат initial() до изменения переданных ключей. Не наблюдает внешние данные сам по себе и не запускает очистку ресурсов. |
| `effect` | `fun(fn: function, ...: any)` | нет | Выполняет побочное действие после применения кадра; результатом может быть функция очистки. Ключи определяют повторный запуск, а удаление области вызывает очистку. |
| `on_dispose` | `fun(fn: fun())` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_frame` | `fun(fn: fun(dt: number))` | нет | Раз в кадр; удаляется вместе с компонентом. |
| `key` | `fun(key: any, content: KompotContent)` | нет | Задаёт устойчивую идентичность поддерева. Используйте ID предмета, если его положение в списке может измениться; для намеренного сброса состояния меняйте ключ. |
| `component` | `fun<T>(fn: T): T` | нет | Создаёт отдельную область композиции для функции. Её хуки, подписки и очистка живут независимо от соседних компонентов. |
| `provide` | `fun<T>(local_value: KompotLocal<T>, value: T, content: KompotContent)` | нет | Предоставляет значение Local детям. Чтение local_value:get() выбирает ближайший провайдер, иначе default. |
| `local_of` | `fun<T>(default: T, name?: string): KompotLocal<T>` | нет | Создаёт ключ локального значения с default и именем. Это ключ провайдера, а не State и не копия текущего значения. |
| `untracked` | `fun<T>(fn: fun(...: any): T, ...: any): T` | нет | Выполняет функцию без регистрации реактивных зависимостей текущей области. Полезен при служебном чтении, которое не должно вызывать перекомпозицию. |
| `is_state` | `fun(value: any): boolean` | нет | Проверяет, является ли значение State Kompot. Это не проверка TransitionState и не способ прочитать значение. |
| `poll` | `fun<T>(getter: fun(): T, eq?: fun(a: T, b: T): boolean): T` | нет | Читает значение нереактивного источника каждый кадр и перестраивает область при изменении. Для обычного State достаточно чтения .value. |
| `animate` | `fun<T>(target: T, spec?: KompotAnimationSpec): T` | нет | Анимирует одно число или массив чисел к новой цели. Выбирайте transition, когда нужно дождаться завершения нескольких каналов вместе. |
| `transition_state` | `fun<T>(initial: T): KompotTransitionState<T>` | нет | Запоминает состояние перехода в компоненте. Владельцу разрешено менять только target_state; завершение публикуется через is_idle/completion. |
| `new_transition_state` | `fun<T>(initial: T): KompotTransitionState<T>` | нет | Создаёт состояние перехода вне композиции. Подходит для модели окна, которая должна сохраняться после удаления его содержимого. |
| `transition` | `fun<T>(state: KompotTransitionState<T>): KompotTransition<T>` | нет | Связывает TransitionState с группой анимаций текущего компонента. Каналы добавляются вызовами transition:animate в стабильном порядке. |
| `tween` | `fun(duration?: number, easing?: string): KompotTween` | нет | Описывает анимацию с заданной длительностью и кривой. Сам по себе не создаёт хук и ничего не запускает. |
| `spring` | `fun(stiffness?: number, damping?: number): KompotSpring` | нет | Описывает пружину через stiffness и damping. Для завершения по времени используйте tween; длительность пружины зависит от движения. |
| `snap` | `KompotSnap` | нет | Готовая спецификация мгновенного перехода. Передаётся как значение, без вызова K.snap(). |
| `clock` | `fun(): number` | нет | Возвращает время от появления области и поддерживает её обновление каждый кадр. Используйте для непрерывного движения; он не останавливается сам. |
| `after` | `fun(seconds: number, key?: any): boolean` | нет | Возвращает true после указанной задержки. Смена key перезапускает отсчёт; seconds без смены key не создаёт новый таймер. |
| `runtime` | `fun(): table` | нет | Возвращает текущий Runtime для размеров и времени композиции и низкоуровневой интеграции. Не храните ссылку как глобальный источник для другого приложения. |
| `EASING` | `table<string, fun(t: number): number>` | нет | Имена кривых: linear, in_quad, out_quad, in_out_quad, in_cubic, out_cubic, in_out_cubic, out_back, out_elastic, standard. Передаются в tween строкой. |
| `interaction` | `fun(): KompotInteraction` | нет | Запоминает общий снимок hovered/pressed/dragged/focused. Передайте его модификатору ввода и читайте значения для оформления. |
| `new_interaction` | `fun(): KompotInteraction` | нет | Создаёт внешний снимок взаимодействия без хука. Сам не подключается к вводу, пока его не передали clickable/hoverable/draggable. |
| `color` | `KompotColorApi` | нет | Чистые вычисления цвета; rgb и hex также доступны как K.rgb и K.hex. |
| `rgb` | `fun(r: number, g: number, b: number, a?: number): number[]` | нет | Создаёт цвет из нормализованных r,g,b,a в диапазоне 0..1. Для каналов 0..255 сначала разделите их на 255. |
| `hex` | `fun(value: string): number[]` | нет | Разбирает строковый цвет #RGB, #RRGGBB или #RRGGBBAA в нормализованный массив. Альфа расположена в конце строки. |
| `fonts` | `KompotFontApi` | нет | Реестр загруженных семейств и их метрик; не загрузчик файлов. |
| `BASE_THEME` | `KompotTheme` | нет | Нейтральная тема ядра без готового контракта UI. Для встроенных компонентов задайте UI.theme(). |
| `theme` | `fun(): KompotTheme` | нет | Читает тему текущего поддерева. Вне провайдера действует базовая тема ядра, а не автоматически Kompot UI. |
| `Theme` | `fun(theme: KompotTheme, content: KompotContent)` | нет | Предоставляет готовую таблицу темы детям. Для наследования настроек Kompot UI удобнее UI.Theme(opts, content). |
| `ContentColor` | `fun(color: KompotColor, content: KompotContent)` | нет | Переопределяет цвет содержимого внутри поддерева, не меняя всю тему. Явный color элемента имеет приоритет. |
| `TextStyle` | `fun(style: string\|KompotTextStyle, content: KompotContent)` | нет | Предоставляет стиль текста поддереву по имени или таблицей. Явный стиль конкретного текста можно передать прямо в K.Text. |
| `style` | `fun(name: string\|KompotTextStyle, theme?: KompotTheme): KompotTextStyle` | нет | Разрешает имя или таблицу текстового стиля в выбранной теме. Для неизвестного имени использует стиль по умолчанию. |
| `extend_theme` | `fun(base: KompotTheme, overrides: table): KompotTheme` | нет | Сливает таблицы темы рекурсивно. Цвета-массивы и функции заменяются целиком; ui заменяется таблицей, а UI.theme дополняет свой контракт отдельно. |
| `LocalTheme` | `KompotLocal<KompotTheme>` | нет | Ключ локальной текущей темы. |
| `LocalContentColor` | `KompotLocal<KompotColor>` | нет | Ключ локального цвета содержимого. |
| `LocalTextStyle` | `KompotLocal<KompotTextStyle>` | нет | Ключ локального текстового стиля. |
| `ui` | `fun(): KompotUiContract` | нет | Возвращает контракт компонентов из текущей темы. Используйте для переносимого экрана; без theme.ui возникает ошибка. |
| `args` | `fun(a: KompotProps\|KompotModifier\|KompotContent, content?: KompotContent): KompotProps, KompotContent?` | нет | Разбирает сокращённые формы вызова компонента: props, modifier или content. Возвращает props и content двумя Lua-значениями; полезен авторам компонентов. |
| `App` | `KompotApp` | нет | Низкоуровневый конструктор приложения для собственного цикла; для HUD используйте mount. |
| `text` | `KompotTextApi` | нет | Измерение и раскладка текста для ядра и внешних рендереров. |
| `preview` | `fun(name: string, opts: KompotPreviewOptions\|KompotContent, content?: KompotContent): KompotPreviewEntry` | нет | Регистрирует именованное превью модуля для Lens. Сам не открывает HUD и не монтирует интерфейс в игре. |
| `previews` | `fun(): KompotPreviewEntry[]` | нет | Возвращает зарегистрированные превью. Это реестр текущего процесса Lua, а не список живых игровых окон. |
| `mount` | `fun(opts: KompotMountOptions): KompotMountHandle` | нет | Создаёт живой интерфейс VoxelCore и возвращает handle. Без target занимает экран; при закрытии владельца вызывайте handle:dispose(). |

<a id="type-kompotapp"></a>
## `KompotApp`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `new` | `fun(opts: KompotAppOptions): KompotAppInstance` | нет | Создаёт приложение без автоматического хоста и кадров движка. Владелец передаёт measurer/backend, вызывает frame и dispose. |

<a id="type-kompotappinstance"></a>
## `KompotAppInstance`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `rt` | `table<string, any>` | нет | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `input` | `table<string, any>` | нет | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `dl` | `table[]` | нет | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `stats` | `table<string, number>` | нет | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `set_size` | `fun(self: KompotAppInstance, width: number, height: number)` | нет | Задаёт размер области приложения и запрашивает новую раскладку. Не меняет размер окна движка автоматически. |
| `frame` | `fun(self: KompotAppInstance, dt?: number, event?: table): boolean` | нет | Выполняет один кадр с dt в секундах и необязательным событием ввода. Возвращает, был ли подготовлен новый рисунок; завершает эффекты после применения. |
| `find_tag` | `fun(self: KompotAppInstance, name: string): table?` | нет | Находит размещённый элемент по метке после кадра. Для идентичности State нужен key, а не tag. |
| `dispose` | `fun(self: KompotAppInstance)` | нет | Освобождает области композиции, эффекты и backend приложения. Нужен при собственном кадровом цикле без mount. |

<a id="type-kompotappoptions"></a>
## `KompotAppOptions`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `content` | `KompotContent` | нет | Дочерняя композиция или содержимое области. Callback, строящий дерево, вызывается во время композиции. |
| `width` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `height` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `measurer` | `KompotTextMeasurer` | да | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `backend` | `any` | да | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `locals` | `table` | да | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `on_error` | `fun(message: string)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `hook_diagnostics` | `boolean` | да | Опция хоста/превью/диагностики; точный смысл и начальное значение заданы в карточке API. |
| `keyboard_navigation` | `boolean` | да | Обход по Tab; по умолчанию false. |

<a id="type-kompotarrangement"></a>
## `KompotArrangement`

`'start'|'center'|'end'|'between'|'around'|'evenly'|number`



<a id="type-kompotbasictextfieldprops"></a>
## `KompotBasicTextFieldProps`

Наследует [KompotTextInputProps](#type-kompottextinputprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `state` | `KompotState<string>` | да | Состояние, принадлежащее владельцу компонента; тип определяет текстовую модель или положение прокрутки. |
| `editor_state` | `KompotState<KompotEditorValue>` | да | Модель текста/выделения или описание нативной текстовой отрисовки. Нужны соответствующие расширения textbox VoxelCore. |

<a id="type-kompotboxprops"></a>
## `KompotBoxProps`

Наследует [KompotProps](#type-kompotprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `align` | `KompotAlign` | да | Выравнивание в контексте данного элемента: у Text - текст, у Box - дети, у Row/Column - поперечная ось. |
| `propagate_min` | `boolean` | да | Правило измерения детей. Не включает прокрутку и не создаёт бесконечную доступную область. |

<a id="type-kompotcanvas"></a>
## `KompotCanvas`

Координаты локальные, целочисленные. Методы set/line/rect/clear используют байтовые каналы 0..255 или упакованный цвет; Image options.color использует KompotColor.

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `width` | `number` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `height` | `number` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `image` | `fun(self: KompotCanvas, src: string\|KompotRaster, opts?: KompotCanvasImageOptions)` | нет | Рисует текстуру или Raster на холсте с преобразованием, UV, tint и alpha. Методы вызываются с двоеточием; регион источника задаётся в 0..1. |
| `set` | `fun(self: KompotCanvas, x: number, y: number, r: number, g?: number, b?: number, a?: number)` | нет | Записывает пиксель по локальным x,y. Каналы r,g,b,a заданы в 0..255; один r может быть упакованным цветом движка. |
| `line` | `fun(self: KompotCanvas, x1: number, y1: number, x2: number, y2: number, r: number, g?: number, b?: number, a?: number)` | нет | Рисует отрезок между целочисленными точками в координатах холста. Не создаёт отдельный элемент интерфейса. |
| `rect` | `fun(self: KompotCanvas, x: number, y: number, width: number, height: number, r: number, g?: number, b?: number, a?: number)` | нет | Рисует заполненный прямоугольник в координатах холста. Это операция пикселей, не K.Box и не модификатор. |
| `clear` | `fun(self: KompotCanvas, r?: number, g?: number, b?: number, a?: number)` | нет | Очищает холст перед новым рисунком. Без цвета заполняет прозрачностью. |

<a id="type-kompotcanvasimageoptions"></a>
## `KompotCanvasImageOptions`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `x` | `number` | да | Положение левого верхнего угла до поворота; по умолчанию 0. |
| `y` | `number` | да | Координата в пикселях; локальную или экранную систему задаёт содержащий тип/событие. |
| `width` | `number` | да | Ширина до масштаба; по умолчанию ширина источника. |
| `height` | `number` | да | Высота до масштаба; по умолчанию высота источника. |
| `angle` | `number` | да | Градусы по часовой стрелке; по умолчанию 0. |
| `scale` | `number\|{ [1]: number, [2]: number }\|{x: number, y: number}` | да | Масштаб рисунка; у nine-patch относится к толщине краёв и повторяемой фактуре. |
| `pivot` | `KompotPivot` | да | Доли размера; по умолчанию {0.5, 0.5}. |
| `alpha` | `number` | да | Непрозрачность 0..1. |
| `color` | `KompotColor` | да | Умножение цвета. |
| `region` | `number[]` | да | UV {u0, v0, u1, v1}; по умолчанию {0, 0, 1, 1}. |

<a id="type-kompotcanvasprops"></a>
## `KompotCanvasProps`

Наследует [KompotProps](#type-kompotprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `draw` | `fun(canvas: KompotCanvas, width: number, height: number)` | нет | Callback рисунка; тип определяет, получает ли он Canvas или контекст композиции поверхности. |
| `version` | `any` | да | Версия источника или кэша; смена version сообщает, что рисунок/метрики изменились. |
| `width` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `height` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |

<a id="type-kompotclickoptions"></a>
## `KompotClickOptions`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `enabled` | `boolean` | да | Политика пользовательского взаимодействия. Семантика и поддержка конкретным компонентом указаны в его карточке; эти флаги не взаимозаменяемы. |
| `interaction` | `KompotInteraction` | да | Общий Interaction, куда модификатор ввода записывает флаги для оформления. |
| `cursor` | `string` | да | Имя курсора движка для области ввода. |
| `on_long_click` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_right_click` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `focusable` | `boolean` | да | Явный локальный фокус; по умолчанию зависит от keyboard_navigation. |
| `focus_scope` | `boolean` | да | Запрос нативного фокуса либо граница области фокуса. Не включает общий обход Tab автоматически. |
| `on_escape` | `fun()` | да | Запрос отмены в верхней области фокуса. |
| `focus_index` | `integer` | да | Начальный фокус среди доступных элементов области. |
| `focus_navigation` | `'vertical'` | да | Стрелки вверх/вниз и Home/End перемещают фокус. |
| `on_focus` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_defocus` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `focus_color` | `KompotColor` | да | Цвет рамки клавиатурного фокуса; показ зависит от способа навигации. |
| `focus_radius` | `KompotShapeInput` | да | Устаревший алиас focus_shape. |
| `focus_shape` | `KompotShapeInput` | да | Приоритетнее focus_radius. |

<a id="type-kompotcolor"></a>
## `KompotColor`

`string|number[]`



<a id="type-kompotcolorapi"></a>
## `KompotColorApi`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `rgb` | `fun(r: number, g: number, b: number, a?: number): number[]` | нет | Создаёт цвет из нормализованных r,g,b,a в диапазоне 0..1. Для каналов 0..255 сначала разделите их на 255. |
| `hex` | `fun(value: string): number[]` | нет | Разбирает строковый цвет #RGB, #RRGGBB или #RRGGBBAA в нормализованный массив. Альфа расположена в конце строки. |
| `of` | `fun(value: KompotColor?): number[]?` | нет | Принимает поддерживаемый цвет и возвращает массив либо nil. Полезен на границе собственного API, принимающего строки и массивы. |
| `to_hex` | `fun(value: number[]): string` | нет | Форматирует нормализованный цвет строкой #RRGGBBAA. Не меняет исходный массив. |
| `with_alpha` | `fun(value: number[], alpha: number): number[]` | нет | Создаёт цвет с заменённой альфой. Для умножения существующей альфы используйте mul_alpha. |
| `mul_alpha` | `fun(value: number[], alpha: number): number[]` | нет | Умножает существующую альфу цвета на коэффициент. Подходит для плавного исчезновения. |
| `mix` | `fun(a: number[], b: number[], t: number): number[]` | нет | Интерполирует каналы двух цветов по t. Это вычисление значения, а не анимационный хук. |
| `over` | `fun(base: number[], over: number[]): number[]` | нет | Смешивает верхний цвет поверх базового с учётом альфы. Не задаёт порядок элементов в интерфейсе. |
| `equals` | `fun(a: number[], b: number[]): boolean` | нет | Сравнивает нормализованные цвета по каналам. Подходит как функция сравнения State с цветом. |
| `to_hsl` | `fun(value: number[]): number, number, number` | нет | Возвращает h (градусы), s и l (0..1) отдельными Lua-значениями. Используйте local h,s,l = ..., а не одну переменную для всех трёх. |
| `hsl` | `fun(h: number, s: number, l: number, a?: number): number[]` | нет | Создаёт нормализованный цвет из h,s,l и необязательной альфы. h задан в градусах, s и l в 0..1. |
| `lighten` | `fun(value: number[], amount: number): number[]` | нет | Осветляет цвет через светлоту HSL. Сохраняет альфу. |
| `darken` | `fun(value: number[], amount: number): number[]` | нет | Затемняет цвет через светлоту HSL. Сохраняет альфу. |
| `luminance` | `fun(value: number[]): number` | нет | Вычисляет относительную яркость RGB. Используется для проверки контраста, а не для изменения цвета. |
| `contrast` | `fun(a: number[], b: number[]): number` | нет | Вычисляет отношение контраста двух цветов. Для полупрозрачных цветов сначала учитывайте реальный фон. |
| `on` | `fun(background: number[], dark?: number[], light?: number[]): number[]` | нет | Выбирает тёмный или светлый цвет содержимого по контрасту с фоном. Можно передать собственную пару кандидатов. |
| `tone` | `fun(value: number[], tone: number, chroma?: number): number[]` | нет | Создаёт непрозрачный тон исходного цвета со светлотой tone в 0..100 и необязательной насыщенностью. Это вспомогательное построение палитры. |
| `palette` | `fun(value: number[], chroma?: number): table<integer, number[]>` | нет | Тоны с числовыми ключами из набора 0..100. |
| `to255` | `fun(value: number[], alpha_mul?: number): number[]` | нет | Переводит нормализованный цвет в целочисленные каналы 0..255. Нужен на границе с низкоуровневой отрисовкой движка. |
| `WHITE` | `number[]` | нет | Непрозрачный белый: {1,1,1,1}. |
| `BLACK` | `number[]` | нет | Непрозрачный чёрный: {0,0,0,1}. |
| `TRANSPARENT` | `number[]` | нет | Прозрачный чёрный: {0,0,0,0}. |

<a id="type-kompotcontent"></a>
## `KompotContent`

`fun()`



<a id="type-kompotcornersize"></a>
## `KompotCornerSize`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `unit` | `'px'\|'percent'` | нет | Дискриминатор описания: вид формы/материала/спецификации или единица измерения. |
| `value` | `number` | нет | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |

<a id="type-kompotcornervalue"></a>
## `KompotCornerValue`

`number|KompotCornerSize`

[KompotCornerSize](API_TYPES.md#type-kompotcornersize)

<a id="type-kompotcorners"></a>
## `KompotCorners`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `top_left` | `number` | да | Радиус слева сверху в пикселях; по умолчанию 0. |
| `top_right` | `number` | да | Радиус справа сверху в пикселях; по умолчанию 0. |
| `bottom_right` | `number` | да | Радиус справа снизу в пикселях; по умолчанию 0. |
| `bottom_left` | `number` | да | Радиус слева снизу в пикселях; по умолчанию 0. |

<a id="type-kompotcrossalign"></a>
## `KompotCrossAlign`

`'start'|'top'|'center'|'end'|'bottom'|number`



<a id="type-kompotdragevent"></a>
## `KompotDragEvent`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `type` | `'start'\|'move'\|'end'\|'cancel'` | нет | Вид события; допустимые значения заданы типом. |
| `x` | `number` | нет | Локальная координата X после обратного преобразования. |
| `y` | `number` | нет | Локальная координата Y после обратного преобразования. |
| `dx` | `number` | нет | Локальное смещение указателя. |
| `dy` | `number` | нет | Локальное смещение указателя. |
| `parent_x` | `number` | нет | Координата X в содержимом родителя. |
| `parent_y` | `number` | нет | Координата Y в содержимом родителя. |
| `parent_dx` | `number` | нет | Смещение указателя в координатах родителя. |
| `parent_dy` | `number` | нет | Смещение указателя в координатах родителя. |
| `velocity_x` | `number` | нет | Пиксели родителя в секунду. |
| `velocity_y` | `number` | нет | Пиксели родителя в секунду. |
| `button` | `'left'\|'right'` | нет | Кнопка мыши для жеста: left или right. |
| `accepted` | `boolean` | да | Цель приняла переносимые данные. |
| `cancelled` | `boolean` | да | Причина или флаг отмены жеста/указателя. При отмене не подтверждайте перенос как обычный end. |
| `reason` | `'escape'\|'removed'\|'blocked'\|'reset'\|'cancelled'` | да | Причина или флаг отмены жеста/указателя. При отмене не подтверждайте перенос как обычный end. |

<a id="type-kompotdragoptions"></a>
## `KompotDragOptions`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `button` | `'left'\|'right'` | да | Кнопка мыши для жеста: left или right. |
| `on_event` | `fun(event: KompotDragEvent): any` | да | На start возвращает переносимые данные; остальные результаты игнорируются. |
| `axis` | `1\|2` | да | Ограничение жеста: 1 - горизонталь, 2 - вертикаль; отсутствие разрешает обе оси. |
| `interaction` | `KompotInteraction` | да | Общий Interaction, куда модификатор ввода записывает флаги для оформления. |
| `cursor` | `string` | да | Имя курсора движка для области ввода. |

<a id="type-kompotdropoptions"></a>
## `KompotDropOptions`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `on_enter` | `fun(payload: any)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_leave` | `fun(payload: any)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_drop` | `fun(payload: any): boolean?` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |

<a id="type-kompoteditorvalue"></a>
## `KompotEditorValue`

text - строка UTF-8, anchor/caret - индексы в единицах нативного caret от 0. Это не байтовые смещения; модель обновляйте целиком.

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `text` | `string` | нет | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `anchor` | `integer` | нет | В EditorValue - границы выделения в индексах текста движка от 0; при равных значениях выделения нет. |
| `caret` | `integer` | нет | В EditorValue - границы выделения в индексах текста движка от 0; при равных значениях выделения нет. |

<a id="type-kompotflowprops"></a>
## `KompotFlowProps`

Наследует [KompotProps](#type-kompotprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `spacing` | `number` | да | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `run_spacing` | `number` | да | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `align` | `KompotCrossAlign` | да | Выравнивание в контексте данного элемента: у Text - текст, у Box - дети, у Row/Column - поперечная ось. |

<a id="type-kompotfontapi"></a>
## `KompotFontApi`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `register_family` | `fun(id: string, entries: table[]): nil` | нет | Регистрирует семейство из уже загруженных ресурсов шрифтов. Не загружает TTF и не заменяет preload.json; ID семейства включает namespace пака. |
| `info` | `fun(name: string): table?` | нет | Возвращает сведения о зарегистрированном ресурсе по имени либо nil. Не ищет произвольный файл на диске. |
| `resolve` | `fun(id: string, size: number, weight?: string): string` | нет | Находит ресурс семейства с точным размером и весом. При отсутствии сочетания возникает ошибка; автоматического масштабирования ближайшего размера нет. |
| `typography` | `fun(defaults: table<string, KompotTextStyle>, opts?: table, overrides?: table): table<string, KompotTextStyle>` | нет | Строит таблицу стилей из defaults, выбранных семейств и overrides. Не регистрирует новые размеры шрифтов автоматически. |
| `register_metrics` | `fun(metrics: table)` | нет | Подключает заранее измеренные метрики. Нужен для соответствия внешнего превью движку; не влияет на загрузку самого шрифта. |

<a id="type-kompoticonprops"></a>
## `KompotIconProps`

Наследует [KompotProps](#type-kompotprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `size` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |

<a id="type-kompotimagefit"></a>
## `KompotImageFit`

`'fill'|'contain'|'cover'`



<a id="type-kompotimageprops"></a>
## `KompotImageProps`

Наследует [KompotProps](#type-kompotprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `width` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `height` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `size` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `source_size` | `{ [1]: number, [2]: number }\|{ width: number, height: number }` | да | Размер PNG или спрайта, не всего атласа; обязателен для contain/cover. |
| `fit` | `KompotImageFit` | да | fill растягивает, contain вписывает, cover заполняет с обрезкой; по умолчанию fill. |
| `color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `region` | `number[]` | да | UV-прямоугольник {u0,v0,u1,v1} в диапазоне 0..1, не экранные координаты. |

<a id="type-kompotinteraction"></a>
## `KompotInteraction`

Флаги - отдельные State<boolean>. Их значения обновляет подключённый модификатор ввода.

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `hovered` | `KompotState<boolean>` | нет | Снимок состояния взаимодействия или State такого флага. Используется оформлением, не заменяет поведение контрола. |
| `pressed` | `KompotState<boolean>` | нет | Снимок состояния взаимодействия или State такого флага. Используется оформлением, не заменяет поведение контрола. |
| `dragged` | `KompotState<boolean>` | нет | Снимок состояния взаимодействия или State такого флага. Используется оформлением, не заменяет поведение контрола. |
| `focused` | `KompotState<boolean>` | нет | Снимок состояния взаимодействия или State такого флага. Используется оформлением, не заменяет поведение контрола. |

<a id="type-kompotlayoutprops"></a>
## `KompotLayoutProps`

Наследует [KompotProps](#type-kompotprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `measure` | `fun(children: any[], min_width: number, max_width: number, min_height: number, max_height: number, api: KompotMeasureApi): number, number` | нет | Callback измерения; возвращает width,height отдельными Lua-значениями. |

<a id="type-kompotlazygridprops"></a>
## `KompotLazyGridProps`

Наследует [KompotLazyProps](#type-kompotlazyprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `columns` | `integer` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |

<a id="type-kompotlazyprops"></a>
## `KompotLazyProps`

Наследует [KompotProps](#type-kompotprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `count` | `integer` | нет | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `item` | `fun(index: integer)` | нет | Композиция элемента по индексу Lua от 1. В lazy-списках вызывается только для нужных элементов. |
| `key_of` | `fun(index: integer): any` | да | Возвращает стабильный ключ элемента по индексу, чтобы сохранить его состояние при перестановке. |
| `state` | `KompotLazyState` | да | Состояние, принадлежащее владельцу компонента; тип определяет текстовую модель или положение прокрутки. |
| `spacing` | `number` | да | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `pad` | `number` | да | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `pad_start` | `number` | да | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `pad_end` | `number` | да | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `fill_cross` | `boolean` | да | Правило измерения детей. Не включает прокрутку и не создаёт бесконечную доступную область. |

<a id="type-kompotlazystate"></a>
## `KompotLazyState`

first начинается с 1. Пределы и оценка total уточняются по мере измерения видимых элементов.

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `first` | `integer` | нет | Индекс первого видимого элемента Lua от 1. |
| `offset` | `number` | нет | Позиция, смещение, объём или размер видимой области прокрутки. После раскладки значения уточняются. |
| `total` | `number` | нет | Позиция, смещение, объём или размер видимой области прокрутки. После раскладки значения уточняются. |
| `view` | `number` | нет | Позиция, смещение, объём или размер видимой области прокрутки. После раскладки значения уточняются. |
| `step` | `number` | нет | Предел или шаг числового контрола/прокрутки. step - величина шага, steps у Slider - число интервалов. |
| `scroll_by` | `fun(self: KompotLazyState, delta: number): number` | нет | Смещает виртуализованный список на delta пикселей. Точные размеры ещё не измеренных элементов уточняются при раскладке. |
| `scroll_to_item` | `fun(self: KompotLazyState, index: integer)` | нет | Запрашивает переход к элементу с индексом от 1. Состояние применяется связанной Lazy-раскладкой. |
| `first_visible` | `fun(self: KompotLazyState): integer` | нет | Возвращает индекс первого видимого элемента от 1. Не является индексом массива TypeScript от 0. |
| `fraction` | `fun(self: KompotLazyState): number, number` | нет | Возвращает оценку позиции и видимой доли для полосы прокрутки. До измерения списка это не точная карта всех высот. |

<a id="type-kompotlinearprops"></a>
## `KompotLinearProps`

Наследует [KompotProps](#type-kompotprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `arrangement` | `KompotArrangement` | да | Распределение детей по основной оси; число задаёт spacing, строка выбирает алгоритм распределения. |
| `spacing` | `number` | да | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `align` | `KompotCrossAlign` | да | Выравнивание в контексте данного элемента: у Text - текст, у Box - дети, у Row/Column - поперечная ось. |
| `fill_cross` | `boolean` | да | Правило измерения детей. Не включает прокрутку и не создаёт бесконечную доступную область. |

<a id="type-kompotlocal"></a>
## `KompotLocal<T>`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `default` | `T` | нет | Значение Local при отсутствии ближайшего провайдера. |
| `name` | `string` | нет | Идентификатор или имя описываемого объекта; точный namespace определяется содержащим типом. |
| `get` | `fun(self: KompotLocal<T>): T` | нет | Читает ближайшее предоставленное значение Local либо default. Вызывается с двоеточием во время композиции. |

<a id="type-kompotmeasureapi"></a>
## `KompotMeasureApi`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `INF` | `number` | нет | Бесконечная верхняя граница измерения, а не размер экрана. |
| `measure` | `fun(child: any, min_width: number, max_width: number, min_height: number, max_height: number): number, number` | нет | Callback измерения; возвращает width,height отдельными Lua-значениями. |
| `place` | `fun(child: any, x: number, y: number)` | нет | Размещает измеренного ребёнка в локальных координатах Layout. |

<a id="type-kompotmodifier"></a>
## `KompotModifier`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `is` | `fun(value: any): boolean` | нет | Проверяет, является ли значение цепочкой Modifier. Вызывается M.is(value), без двоеточия. |
| `equals` | `fun(a: KompotModifier, b: KompotModifier): boolean` | нет | Сравнивает цепочки слоёв. |
| `then_` | `fun(self: KompotModifier, other: KompotModifier): KompotModifier` | нет | Добавляет слои другой цепочки после текущих. Удобен для объединения общих и локальных модификаторов. |
| `padding` | `fun(self: KompotModifier, a: number\|KompotPadding, b?: number, c?: number, d?: number): KompotModifier` | нет | Добавляет внутреннее пространство в точке цепочки. Один аргумент задаёт все стороны; два - горизонталь и вертикаль; четыре - left,top,right,bottom. |
| `size` | `fun(self: KompotModifier, width: number, height?: number): KompotModifier` | нет | Задаёт желаемый размер; без height использует width по обеим осям. Родительские ограничения сохраняются. |
| `width` | `fun(self: KompotModifier, width: number): KompotModifier` | нет | Задаёт желаемую ширину в пикселях внутри ограничений родителя. Не означает долю свободного места - для этого нужен weight. |
| `height` | `fun(self: KompotModifier, height: number): KompotModifier` | нет | Задаёт желаемую высоту в пикселях. Для динамического содержимого без фиксированной высоты оставьте размер раскладке. |
| `size_in` | `fun(self: KompotModifier, min_width?: number, max_width?: number, min_height?: number, max_height?: number): KompotModifier` | нет | Ограничивает диапазоны ширины и высоты. Неназванные границы не задавайте вместо нуля: nil сохраняет отсутствие соответствующего ограничения. |
| `width_in` | `fun(self: KompotModifier, min?: number, max?: number): KompotModifier` | нет | Ограничивает минимальную и максимальную ширину. Подходит для кнопок и текста, растущих по содержимому. |
| `height_in` | `fun(self: KompotModifier, min?: number, max?: number): KompotModifier` | нет | Ограничивает минимальную и максимальную высоту. Для прокрутки нужно задать конечную область просмотра. |
| `required_size` | `fun(self: KompotModifier, width: number, height?: number): KompotModifier` | нет | Требует размер содержимого независимо от обычного согласования с родителем. Может выйти за доступное место; применяйте, когда это намеренно. |
| `fill_max_width` | `fun(self: KompotModifier, fraction?: number): KompotModifier` | нет | Занимает fraction доступной конечной ширины. Не получает ширину всего экрана независимо от родителя. |
| `fill_max_height` | `fun(self: KompotModifier, fraction?: number): KompotModifier` | нет | Занимает fraction доступной конечной высоты. В неограниченной оси прокрутки не создаёт конечную высоту. |
| `fill_max_size` | `fun(self: KompotModifier, fraction?: number): KompotModifier` | нет | Занимает доступный размер по двум осям. Для слоя поверх содержимого Box обычно нужен match_parent_size. |
| `wrap_content` | `fun(self: KompotModifier): KompotModifier` | нет | Снимает минимальные ограничения в этой точке цепочки, сохраняя максимальные. Используется, когда содержимое должно выбирать свой размер. |
| `aspect_ratio` | `fun(self: KompotModifier, ratio: number): KompotModifier` | нет | Выбирает размер с заданным отношением ширины к высоте. Это ограничение прямоугольника элемента, а не режим масштабирования картинки. |
| `offset` | `fun(self: KompotModifier, x?: number, y?: number): KompotModifier` | нет | Сдвигает размещение без изменения измеренного размера. Соседи не резервируют место под сдвинутое положение. |
| `weight` | `fun(self: KompotModifier, weight?: number, fill?: boolean): KompotModifier` | нет | Делит остаток места между детьми Row/Column. fill=false разрешает ребёнку быть меньше выделенной доли. |
| `match_parent_size` | `fun(self: KompotModifier): KompotModifier` | нет | Измеряет ребёнка по окончательному размеру Box, не включая его в вычисление этого размера. Работает на прямом ребёнке Box. |
| `align` | `fun(self: KompotModifier, align: KompotAlign\|KompotCrossAlign): KompotModifier` | нет | Выравнивает ребёнка Box либо по поперечной оси Row/Column. Не выравнивает текст внутри Text - для него есть Text.align. |
| `z_index` | `fun(self: KompotModifier, z: number): KompotModifier` | нет | Меняет порядок рисования и ввода соседей одного контейнера. Для всплывающих слоёв используется Popup.z. |
| `vertical_scroll` | `fun(self: KompotModifier, state: KompotScrollState): KompotModifier` | нет | Прокручивает всех существующих детей по вертикали с ScrollState. Сам не виртуализует элементы. |
| `horizontal_scroll` | `fun(self: KompotModifier, state: KompotScrollState): KompotModifier` | нет | Прокручивает содержимое по горизонтали с ScrollState. Для длинного горизонтального набора рассмотрите LazyRow. |
| `background` | `fun(self: KompotModifier, color: KompotColor, shape?: KompotShapeInput): KompotModifier` | нет | Рисует однотонный фон выбранной формы, не добавляя размер и обработку ввода. Форма фона не обрезает детей. |
| `background_image` | `fun(self: KompotModifier, paint: KompotNinePatch, tint?: KompotColor): KompotModifier` | нет | Только nine-patch; фон с cover задаётся через K.Image внутри Box. |
| `border` | `fun(self: KompotModifier, width: number, color: KompotColor, shape?: KompotShapeInput): KompotModifier` | нет | Рисует рамку внутри границ выбранной формы. Задайте ту же форму, что у фона, если их контуры должны совпадать. |
| `shadow` | `fun(self: KompotModifier, elevation?: number, shape?: KompotShapeInput, color?: KompotColor, dy?: number): KompotModifier` | нет | Рисует тень с elevation, формой, цветом и необязательным вертикальным сдвигом. Не увеличивает размер раскладки. |
| `rotate` | `fun(self: KompotModifier, angle: number, pivot?: KompotPivot): KompotModifier` | нет | Поворачивает рисунок, содержимое и области ввода вокруг pivot. Размер соседей не пересчитывается по повёрнутой рамке. |
| `scale` | `fun(self: KompotModifier, x: number, y?: number, pivot?: KompotPivot): KompotModifier` | нет | Масштабирует рисунок и ввод относительно pivot. Для изменения размера раскладки используйте size, а не scale. |
| `clip` | `fun(self: KompotModifier, shape?: KompotShapeInput): KompotModifier` | нет | Обрезает следующие слои и детей по форме. Не выбирает cover/contain и не управляет прокруткой сам по себе. |
| `alpha` | `fun(self: KompotModifier, alpha: number): KompotModifier` | нет | Умножает прозрачность поддерева. Нулевая прозрачность сама по себе не является удалением компонента или политикой отключения ввода. |
| `clickable` | `fun(self: KompotModifier, on_click?: fun(), opts?: KompotClickOptions): KompotModifier` | нет | Добавляет нажатия, обработчики правой/долгой кнопки, взаимодействие и необязательный фокус. Для обычной кнопки с оформлением удобнее UI.Button. |
| `focusable` | `fun(self: KompotModifier, on_key?: fun(key: string), opts?: KompotClickOptions): KompotModifier` | нет | Добавляет обработку клавиш в локальном фокусе. Используйте для собственного контрола, а не для включения Tab во всём приложении. |
| `block_pointer` | `fun(self: KompotModifier): KompotModifier` | нет | Создаёт непрозрачную область ввода без пользовательского действия. Подходит панели, через которую клик не должен попадать в мир. |
| `hoverable` | `fun(self: KompotModifier, target: KompotInteraction\|fun(hovered: boolean)): KompotModifier` | нет | Записывает наведение в Interaction или callback(bool). Сам не делает элемент нажимаемым. |
| `draggable` | `fun(self: KompotModifier, opts: KompotDragOptions): KompotModifier` | нет | Добавляет жест перетаскивания со start/move/end/cancel. Изменение геометрии и перенос данных принадлежат владельцу. |
| `drop_target` | `fun(self: KompotModifier, opts?: KompotDropOptions): KompotModifier` | нет | Добавляет приём переносимых данных с enter/leave/drop. Возврат false из on_drop отклоняет перенос. |
| `pointer_input` | `fun(self: KompotModifier, fn: fun(event: KompotPointerEvent)): KompotModifier` | нет | Доставляет низкоуровневые down/up/move/cancel. Для типовой кнопки или перетаскивания предпочтительнее готовый модификатор. |
| `on_wheel` | `fun(self: KompotModifier, fn: fun(delta: number): boolean?): KompotModifier` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `cursor` | `fun(self: KompotModifier, name: string): KompotModifier` | нет | Задаёт курсор над областью элемента. Это оформление указателя, не обработчик клика. |
| `on_size` | `fun(self: KompotModifier, fn: fun(width: number, height: number)): KompotModifier` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_placed` | `fun(self: KompotModifier, fn: fun(x: number, y: number, width: number, height: number)): KompotModifier` | нет | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `tag` | `fun(self: KompotModifier, name: string): KompotModifier` | нет | Присваивает диагностическую метку для App:find_tag и проверок. Не заменяет key и не сохраняет состояние при перестановке. |

<a id="type-kompotmounthandle"></a>
## `KompotMountHandle`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `disposed` | `boolean` | нет | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `app` | `KompotAppInstance` | нет | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `backend` | `table` | нет | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `host` | `any` | нет | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `fake_input` | `table` | да | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `close_pending` | `boolean` | да | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `dispose` | `fun(self: KompotMountHandle)` | нет | Завершает приложение, эффекты и нативный хост. Повторный вызов безопасен; скрытие макета без уничтожения не равно dispose. |
| `set_content` | `fun(self: KompotMountHandle, content: KompotContent)` | нет | Меняет корневую функцию и намеренно создаёт новую группу состояния. Для сохранения формы обычно достаточно менять её State. |
| `set_theme` | `fun(self: KompotMountHandle, theme: KompotTheme)` | нет | Меняет тему смонтированного приложения и прогревает её шрифты. Не создаёт второе окно. |
| `is_over` | `fun(self: KompotMountHandle, x: number, y: number): boolean` | нет | Экранная точка над областью ввода UI; после dispose возвращает false. |

<a id="type-kompotmountoptions"></a>
## `KompotMountOptions`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `content` | `KompotContent` | нет | Дочерняя композиция или содержимое области. Callback, строящий дерево, вызывается во время композиции. |
| `theme` | `KompotTheme` | да | Готовая тема интерфейса; в Preview допускается функция создания темы. |
| `target` | `any` | да | Контекст приложения/хоста, данные backend либо диагностическое состояние. Это не отдельный готовый компонент. |
| `fullscreen` | `boolean` | да | Опция хоста/превью/диагностики; точный смысл и начальное значение заданы в карточке API. |
| `interactive` | `boolean` | да | Опция хоста/превью/диагностики; точный смысл и начальное значение заданы в карточке API. |
| `z_index` | `number` | да | Геометрия, слой или поведение окна/всплывающей области. Не все параметры Window применимы к Dialog. |
| `keyboard_navigation` | `boolean` | да | Обход по Tab и фокус обычных кнопок; по умолчанию false. |
| `lock_inventory` | `boolean` | да | true блокирует инвентарь для UI; false полностью отключает блокировку. По умолчанию зависит от навигации и ввода текста. |
| `hook_diagnostics` | `boolean` | да | Подробные места вызова хуков; порядок и типы проверяются всегда. |

<a id="type-kompotninepatch"></a>
## `KompotNinePatch`

Наследует [KompotNinePatchOptions](#type-kompotninepatchoptions).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `kind` | `'nine_patch'` | нет | Дискриминатор описания: вид формы/материала/спецификации или единица измерения. |
| `src` | `string\|KompotRaster` | нет | Источник изображения либо место объявления превью. Для изображений texture/path и atlas:sprite - разные схемы. |

<a id="type-kompotninepatchoptions"></a>
## `KompotNinePatchOptions`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `source_size` | `number[]` | да | Размер PNG или спрайта: {width, height}; обязателен для строкового источника. fit не поддерживается. |
| `border` | `number\|number[]` | да | Пиксели источника: число или {left, top, right, bottom}. |
| `center` | `'stretch'\|'tile'\|'none'` | да | Способ рисования центра или краёв nine-patch: допустимые режимы указаны типом. |
| `edges` | `'stretch'\|'tile'` | да | Способ рисования центра или краёв nine-patch: допустимые режимы указаны типом. |
| `scale` | `number` | да | Масштаб рисунка; у nine-patch относится к толщине краёв и повторяемой фактуре. |

<a id="type-kompotpadding"></a>
## `KompotPadding`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `l` | `number` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |
| `t` | `number` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |
| `r` | `number` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |
| `b` | `number` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |
| `h` | `number` | да | Высота, высота строки, ширины строк или номер строки объявления; конкретный смысл определяется структурой. |
| `v` | `number` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |
| `start` | `number` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |
| `top` | `number` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |
| `end` | `number` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |
| `bottom` | `number` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |
| `horizontal` | `number` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |
| `vertical` | `number` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |

<a id="type-kompotpivot"></a>
## `KompotPivot`

`{ [1]: number, [2]: number }|{x: number, y: number}`



<a id="type-kompotplacement"></a>
## `KompotPlacement`

`'below'|'above'|'right'|'center'|'fill'|fun(anchor: KompotRect?, width: number, height: number, screen_width: number, screen_height: number, gap: number): number, number`

[KompotRect](API_TYPES.md#type-kompotrect)

<a id="type-kompotpointerevent"></a>
## `KompotPointerEvent`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `type` | `'down'\|'up'\|'move'\|'cancel'` | нет | Вид события; допустимые значения заданы типом. |
| `x` | `number` | нет | Координата в пикселях; локальную или экранную систему задаёт содержащий тип/событие. |
| `y` | `number` | нет | Координата в пикселях; локальную или экранную систему задаёт содержащий тип/событие. |
| `dx` | `number` | нет | Смещение указателя в системе координат события, в пикселях. |
| `dy` | `number` | нет | Смещение указателя в системе координат события, в пикселях. |
| `parent_x` | `number` | нет | Координата указателя в содержимом родителя. |
| `parent_y` | `number` | нет | Координата указателя в содержимом родителя. |
| `parent_dx` | `number` | нет | Смещение указателя в системе координат события, в пикселях. |
| `parent_dy` | `number` | нет | Смещение указателя в системе координат события, в пикселях. |
| `button` | `'left'\|'right'` | нет | Кнопка мыши для жеста: left или right. |
| `cancelled` | `boolean` | да | Причина или флаг отмены жеста/указателя. При отмене не подтверждайте перенос как обычный end. |
| `reason` | `string` | да | Причина или флаг отмены жеста/указателя. При отмене не подтверждайте перенос как обычный end. |

<a id="type-kompotpopupprops"></a>
## `KompotPopupProps`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `interactive` | `boolean` | да | false отключает ввод содержимого, сохраняя отрисовку. |
| `placement` | `KompotPlacement` | да | Геометрия, слой или поведение окна/всплывающей области. Не все параметры Window применимы к Dialog. |
| `gap` | `number` | да | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `key` | `any` | да | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `z` | `number` | да | Геометрия, слой или поведение окна/всплывающей области. Не все параметры Window применимы к Dialog. |

<a id="type-kompotpreviewentry"></a>
## `KompotPreviewEntry`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `name` | `string` | нет | Идентификатор или имя описываемого объекта; точный namespace определяется содержащим типом. |
| `opts` | `KompotPreviewOptions` | нет | Параметры зарегистрированного превью. |
| `content` | `KompotContent` | нет | Дочерняя композиция или содержимое области. Callback, строящий дерево, вызывается во время композиции. |
| `source` | `string` | да | Источник изображения либо место объявления превью. Для изображений texture/path и atlas:sprite - разные схемы. |
| `line` | `integer` | да | Высота, высота строки, ширины строк или номер строки объявления; конкретный смысл определяется структурой. |

<a id="type-kompotpreviewoptions"></a>
## `KompotPreviewOptions`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `width` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `height` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `theme` | `KompotTheme\|fun(): KompotTheme` | да | Готовая тема интерфейса; в Preview допускается функция создания темы. |
| `padding` | `number` | да | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `group` | `string` | да | Имя группы превью в Kompot Lens. |
| `hook_diagnostics` | `boolean` | да | Подробная диагностика хуков; по умолчанию true. |
| `keyboard_navigation` | `boolean` | да | Обход по Tab; по умолчанию false. |

<a id="type-kompotprops"></a>
## `KompotProps`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `modifier` | `KompotModifier` | да | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | да | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | да | Идентичность области композиции; не позиция на экране и не диагностический tag. |

<a id="type-kompotradius"></a>
## `KompotRadius`

`number|KompotCorners`

[KompotCorners](API_TYPES.md#type-kompotcorners)

<a id="type-kompotraster"></a>
## `KompotRaster`

Наследует [KompotRasterOptions](#type-kompotrasteroptions).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `kind` | `'raster'` | нет | Дискриминатор описания: вид формы/материала/спецификации или единица измерения. |

<a id="type-kompotrasteroptions"></a>
## `KompotRasterOptions`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `key` | `string` | да | Общий ключ ресурса с префиксом имени пака. |
| `version` | `string\|number` | да | Меняется при изменении исходных пикселей. |
| `width` | `integer` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `height` | `integer` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `draw` | `fun(canvas: KompotCanvas, width: integer, height: integer)` | нет | Callback рисунка; тип определяет, получает ли он Canvas или контекст композиции поверхности. |

<a id="type-kompotrect"></a>
## `KompotRect`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `x` | `number` | нет | Координата в пикселях; локальную или экранную систему задаёт содержащий тип/событие. |
| `y` | `number` | нет | Координата в пикселях; локальную или экранную систему задаёт содержащий тип/событие. |
| `w` | `number` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `h` | `number` | нет | Высота, высота строки, ширины строк или номер строки объявления; конкретный смысл определяется структурой. |

<a id="type-kompotscrollstate"></a>
## `KompotScrollState`

value/max/view в пикселях; step=48 по умолчанию. Для уведомления раскладки меняйте позицию через scroll_to/scroll_by, а не присваиванием value.

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `value` | `number` | нет | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |
| `max` | `number` | нет | Предел или шаг числового контрола/прокрутки. step - величина шага, steps у Slider - число интервалов. |
| `view` | `number` | нет | Позиция, смещение, объём или размер видимой области прокрутки. После раскладки значения уточняются. |
| `step` | `number` | нет | Предел или шаг числового контрола/прокрутки. step - величина шага, steps у Slider - число интервалов. |
| `scroll_by` | `fun(self: KompotScrollState, delta: number): number` | нет | Изменяет позицию на delta пикселей в пределах 0..max. Возвращает фактический сдвиг, который может быть меньше запрошенного. |
| `scroll_to` | `fun(self: KompotScrollState, value: number): number` | нет | Переходит к абсолютной позиции в пикселях с ограничением по границам. Пределы становятся известны после раскладки. |
| `fraction` | `fun(self: KompotScrollState): number, number` | нет | Возвращает долю прокрутки и долю видимой части двумя Lua-значениями. Используется Scrollbar. |

<a id="type-kompotshape"></a>
## `KompotShape`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `kind` | `'rectangle'\|'circle'\|'rounded'\|'cut'` | нет | Дискриминатор описания: вид формы/материала/спецификации или единица измерения. |

<a id="type-kompotshapeapi"></a>
## `KompotShapeApi`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `rectangle` | `fun(): KompotShape` | нет | Создаёт прямоугольную форму без скруглений. Передаётся в фон, рамку, тень и clip. |
| `circle` | `fun(): KompotShape` | нет | Круг для квадрата, капсула для прямоугольника. |
| `rounded` | `fun(size?: KompotCornerValue\|KompotShapeCorners): KompotShape` | нет | Создаёт скруглённую форму с общим или разными размерами углов. Число означает пиксели, percent - долю меньшей стороны. |
| `cut` | `fun(size?: KompotCornerValue\|KompotShapeCorners): KompotShape` | нет | Создаёт форму со срезанными углами. Толщина диагональной рамки согласована с её контуром. |
| `px` | `fun(value: number): KompotCornerSize` | нет | Описывает размер угла в пикселях. Полезен рядом с percent в таблице разных углов. |
| `percent` | `fun(value: number): KompotCornerSize` | нет | Процент меньшей стороны, 0..100. |

<a id="type-kompotshapecorners"></a>
## `KompotShapeCorners`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `top_left` | `KompotCornerValue` | да | Размер соответствующего угла; число означает пиксели, CornerSize позволяет проценты. |
| `top_right` | `KompotCornerValue` | да | Размер соответствующего угла; число означает пиксели, CornerSize позволяет проценты. |
| `bottom_right` | `KompotCornerValue` | да | Размер соответствующего угла; число означает пиксели, CornerSize позволяет проценты. |
| `bottom_left` | `KompotCornerValue` | да | Размер соответствующего угла; число означает пиксели, CornerSize позволяет проценты. |

<a id="type-kompotshapeinput"></a>
## `KompotShapeInput`

`KompotShape|KompotRadius`

[KompotRadius](API_TYPES.md#type-kompotradius), [KompotShape](API_TYPES.md#type-kompotshape)

<a id="type-kompotsnap"></a>
## `KompotSnap`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `kind` | `'snap'` | нет | Дискриминатор описания: вид формы/материала/спецификации или единица измерения. |

<a id="type-kompotspring"></a>
## `KompotSpring`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `kind` | `'spring'` | нет | Дискриминатор описания: вид формы/материала/спецификации или единица измерения. |
| `stiffness` | `number` | нет | Параметр спецификации анимации; duration в секундах, easing - имя кривой, damping - доля критического затухания. |
| `damping` | `number` | нет | Параметр спецификации анимации; duration в секундах, easing - имя кривой, damping - доля критического затухания. |

<a id="type-kompotstate"></a>
## `KompotState<T>`

value - наблюдаемое значение. set/update/patch/update_field вызываются с self. Изменение вложенной таблицы на месте не уведомляет подписчиков.

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `value` | `T` | нет | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |
| `set` | `fun(self: KompotState<T>, value: T)` | нет | Заменяет значение и уведомляет подписчиков, если оно изменилось по eq. Не мутируйте старую таблицу перед вызовом. |
| `peek` | `fun(self: KompotState<T>): T` | нет | Читает текущее значение без подписки области. В обработчике обновления удобно читать именно так. |
| `update` | `fun(self: KompotState<T>, fn: fun(value: T): T)` | нет | Вычисляет новое значение из старого и передаёт его в set. Функция должна вернуть результат, а не изменить старую таблицу на месте. |
| `patch` | `fun(self: KompotState<T>, changes: table)` | нет | Копирует таблицу и заменяет поля; функции сохраняются как значения. |
| `update_field` | `fun(self: KompotState<T>, key: any, value_or_fn: any\|fun(old: any): any)` | нет | Копирует таблицу и меняет поле; nil удаляет, функция вычисляет значение один раз. |

<a id="type-kompottextalign"></a>
## `KompotTextAlign`

`'start'|'center'|'end'`



<a id="type-kompottextapi"></a>
## `KompotTextApi`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `version` | `integer` | нет | Служебная версия общих метрик/кэша текста. |
| `chars` | `fun(text: string): string[]` | нет | Разбивает UTF-8 строку на кодовые точки. Это не разбиение на видимые графемы, слова или строки. |
| `layout` | `fun(measurer: KompotTextMeasurer, font: string, text: string\|number, max_width: number, max_lines?: integer, wrap?: boolean, ellipsis?: boolean): KompotTextLayout` | нет | Рассчитывает строки, ширины и высоту обычного текста по measurer и ограничениям. Для нативного редактируемого textbox используйте его собственную раскладку. |
| `parse_md` | `fun(text: string): table[]` | нет | Разбирает поддерживаемую разметку md в текстовые фрагменты. Это небольшой синтаксис Kompot, а не полный Markdown-документ. |
| `layout_rich` | `fun(measurer: KompotTextMeasurer, runs: table[], max_width: number, max_lines?: integer, wrap?: boolean): KompotTextLayout` | нет | Рассчитывает строки стилизованных фрагментов. Передавайте метрики всех реально используемых шрифтов. |
| `clear_cache` | `fun()` | нет | Очищает общий кэш текстовых раскладок. Не пересоздаёт State или загруженные шрифты. |
| `approx_measurer` | `fun(scale?: number): KompotTextMeasurer` | нет | Создаёт приблизительный измеритель для тестов и внешнего превью. Не обещает пиксельного совпадения с движком. |
| `register_metrics` | `fun(metrics: table<string, table>)` | нет | Добавляет измеренные метрики и инвалидирует текстовый кэш. Удобнее вызывать через API fonts при настройке семейства. |
| `metrics_measurer` | `fun(): KompotTextMeasurer` | нет | Создаёт измеритель на зарегистрированных метриках. Подходит App и внешнему рендереру без нативного GUI. |
| `field_line_height` | `fun(measurer: KompotTextMeasurer, font: string): number` | нет | Возвращает высоту строки нативного поля через measurer с предусмотренным fallback. Она может отличаться от высоты строки K.Text. |

<a id="type-kompottextinputprops"></a>
## `KompotTextInputProps`

Свойства нативного поля. Наличие свойства в базовом типе не означает, что оформленная обёртка Field передаёт его дальше.

Наследует [KompotProps](#type-kompotprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `value` | `string` | да | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |
| `on_change` | `fun(text: string)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_submit` | `fun(text: string)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `hint` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `font` | `string\|false` | да | Имя загруженного ресурса шрифта, не путь к TTF. В поле font=false выбирает шрифт движка. |
| `color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `lines` | `integer` | да | lines задаёт высоту поля в строках; max_lines ограничивает отрисовку Text. Не ограничивают длину модели текста. |
| `pad` | `number` | да | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `width` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `focus` | `boolean` | да | Запрос нативного фокуса либо граница области фокуса. Не включает общий обход Tab автоматически. |
| `on_focus` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_defocus` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `syntax` | `'lua'\|string` | да | Перенос, многоточие, разметка или подсветка. Поддерживаемые значения и нативные ограничения описаны в TEXT_INPUT. |
| `line_numbers` | `boolean` | да | Показывать номера строк. Это оформление поля, а не изменение исходного текста. |
| `enabled` | `boolean` | да | Нельзя фокусировать, выделять или менять недоступное поле. |
| `editable` | `boolean` | да | Политика пользовательского взаимодействия. Семантика и поддержка конкретным компонентом указаны в его карточке; эти флаги не взаимозаменяемы. |
| `wrap` | `boolean` | да | Перенос, многоточие, разметка или подсветка. Поддерживаемые значения и нативные ограничения описаны в TEXT_INPUT. |
| `presentation` | `any` | да | Модель текста/выделения или описание нативной текстовой отрисовки. Нужны соответствующие расширения textbox VoxelCore. |
| `editor_state` | `KompotState<KompotEditorValue>` | да | Модель текста/выделения или описание нативной текстовой отрисовки. Нужны соответствующие расширения textbox VoxelCore. |
| `editor_value` | `KompotEditorValue` | да | Модель текста/выделения или описание нативной текстовой отрисовки. Нужны соответствующие расширения textbox VoxelCore. |
| `on_selection_change` | `fun(anchor: number, caret: number)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |

<a id="type-kompottextlayout"></a>
## `KompotTextLayout`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `lines` | `table[]` | нет | Измеренные строки текста. |
| `widths` | `number[]` | нет | Высота, высота строки, ширины строк или номер строки объявления; конкретный смысл определяется структурой. |
| `w` | `number` | нет | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `h` | `number` | нет | Высота, высота строки, ширины строк или номер строки объявления; конкретный смысл определяется структурой. |
| `lh` | `number` | нет | Высота, высота строки, ширины строк или номер строки объявления; конкретный смысл определяется структурой. |
| `rich` | `boolean` | да | Фрагменты или флаг стилизованной текстовой раскладки. |

<a id="type-kompottextmeasurer"></a>
## `KompotTextMeasurer`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `width` | `fun(self: KompotTextMeasurer, font: string, text: string): number` | нет | Возвращает ширину текста в указанном шрифте. В собственном backend реализация обязана согласовываться с реальной отрисовкой. |
| `line_height` | `fun(self: KompotTextMeasurer, font: string): number` | нет | Возвращает высоту строки K.Text. Для textbox может использоваться другая высота field_line_height. |
| `field_line_height` | `fun(self: KompotTextMeasurer, font: string): number` | да | Необязательный метод высоты строки нативного поля. Если отсутствует, K.text.field_line_height использует предусмотренный fallback. |

<a id="type-kompottextprops"></a>
## `KompotTextProps`

Наследует [KompotProps](#type-kompotprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `style` | `string\|KompotTextStyle` | да | Имя или описание стиля текста; default_style задаёт fallback темы. |
| `color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `align` | `KompotTextAlign` | да | Выравнивание в контексте данного элемента: у Text - текст, у Box - дети, у Row/Column - поперечная ось. |
| `max_lines` | `integer` | да | lines задаёт высоту поля в строках; max_lines ограничивает отрисовку Text. Не ограничивают длину модели текста. |
| `wrap` | `boolean` | да | Перенос, многоточие, разметка или подсветка. Поддерживаемые значения и нативные ограничения описаны в TEXT_INPUT. |
| `ellipsis` | `boolean` | да | Перенос, многоточие, разметка или подсветка. Поддерживаемые значения и нативные ограничения описаны в TEXT_INPUT. |
| `font` | `string` | да | Имя загруженного ресурса шрифта, не путь к TTF. В поле font=false выбирает шрифт движка. |
| `bold_font` | `string` | да | Имя загруженного ресурса шрифта, не путь к TTF. В поле font=false выбирает шрифт движка. |
| `markup` | `'md'` | да | Перенос, многоточие, разметка или подсветка. Поддерживаемые значения и нативные ограничения описаны в TEXT_INPUT. |
| `spans` | `KompotTextSpan[]` | да | Фрагменты или флаг стилизованной текстовой раскладки. |

<a id="type-kompottextspan"></a>
## `KompotTextSpan`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `text` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `[1]` | `string` | да | Первый позиционный элемент Lua-таблицы. В TS-массивах доступ к нему имеет индекс 0. |
| `color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `style` | `string\|KompotTextStyle` | да | Имя или описание стиля текста; default_style задаёт fallback темы. |
| `font` | `string` | да | Имя загруженного ресурса шрифта, не путь к TTF. В поле font=false выбирает шрифт движка. |
| `bold` | `boolean` | да | В TextStyle - имя ресурса жирного шрифта, в TextSpan - флаг жирного начертания. |

<a id="type-kompottextstyle"></a>
## `KompotTextStyle`

font - загруженный ресурс конкретного размера. family/size/weight участвуют в fonts.typography; само наличие TTF не создаёт ресурсы всех размеров.

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `font` | `string` | нет | Имя загруженного ресурса шрифта, не путь к TTF. В поле font=false выбирает шрифт движка. |
| `bold` | `string` | да | В TextStyle - имя ресурса жирного шрифта, в TextSpan - флаг жирного начертания. |
| `size` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `family` | `string` | да | Зарегистрированное семейство или вес шрифта; у Modifier.weight другой контракт деления свободного места. |
| `weight` | `string` | да | Зарегистрированное семейство или вес шрифта; у Modifier.weight другой контракт деления свободного места. |

<a id="type-kompottheme"></a>
## `KompotTheme`

Контейнер дизайн-системы. Ядро не приписывает произвольным полям семантику; базовая тема не предоставляет ui/icons автоматически.

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `name` | `string` | да | Идентификатор или имя описываемого объекта; точный namespace определяется содержащим типом. |
| `dark` | `boolean` | да | Свойство темы: режим, плотность, принадлежность встроенной системе или прозрачность панели. |
| `colors` | `table<string, number[]>` | нет | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `type` | `table<string, KompotTextStyle>` | нет | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |
| `default_style` | `string` | да | Имя или описание стиля текста; default_style задаёт fallback темы. |
| `icons` | `string` | да | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |
| `fonts` | `string[]` | да | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |
| `ui` | `KompotUiContract` | да | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |
| `[string]` | `any` | нет | Пользовательские поля таблицы. Их наличие не означает, что каждый встроенный компонент читает такое свойство. |

<a id="type-kompottransition"></a>
## `KompotTransition<T>`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `animate` | `fun<V>(self: KompotTransition<T>, value_of: fun(state: T): V, spec?: KompotAnimationSpec): V` | нет | Число или массив чисел; каналы принадлежат одной группе. |

<a id="type-kompottransitionstate"></a>
## `KompotTransitionState<T>`

target_state записывается владельцем; current_state, is_idle и completion доступны только для чтения. Это не State с полем value.

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `target_state` | `T` | нет | Записываемая цель перехода. |
| `current_state` | `T` | нет | Последнее завершённое состояние; только чтение. |
| `is_idle` | `boolean` | нет | Завершены все анимации; только чтение. |
| `completion` | `integer` | нет | Число завершений после применения кадра; изначально 0, только чтение. |

<a id="type-kompottween"></a>
## `KompotTween`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `kind` | `'tween'` | нет | Дискриминатор описания: вид формы/материала/спецификации или единица измерения. |
| `duration` | `number` | нет | Параметр спецификации анимации; duration в секундах, easing - имя кривой, damping - доля критического затухания. |
| `easing` | `string` | нет | Параметр спецификации анимации; duration в секундах, easing - имя кривой, damping - доля критического затухания. |

<a id="type-kompotuiactionhintprops"></a>
## `KompotUiActionHintProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `binding` | `string` | да | Подпись клавиши или описание подсказки действия HUD; ввод регистрирует игровой код. |
| `text` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `detail` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |

<a id="type-kompotuiapi"></a>
## `KompotUiApi`

Наследует [KompotUiContract](#type-kompotuicontract).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `VERSION` | `string` | нет | Внутренняя версия дизайн-системы, не версия всего пака Kompot. |
| `theme` | `fun(opts?: KompotUiThemeOptions): KompotUiTheme` | нет | Создаёт самостоятельную тему Kompot UI из настроек. Не наследует текущую вложенную тему автоматически; для этого используйте UI.Theme. |
| `Theme` | `fun(opts: KompotUiThemeOptions, content: KompotContent)` | нет | Наследует текущую тему Kompot UI и предоставляет детям переопределения. В чужой теме отправной точкой является DEFAULT встроенной системы. |
| `current` | `fun(): KompotUiTheme` | нет | Возвращает активную тему Kompot UI либо DEFAULT в чужой дизайн-системе. Для произвольной темы поддерева используйте K.theme. |
| `DEFAULT` | `KompotUiTheme` | нет | Готовая стандартная тема встроенной дизайн-системы. |
| `PALETTE` | `table<string, KompotColor>` | нет | Исходные цвета Kompot UI, по роли - один цвет, а не вложенный набор палитр. |
| `TYPE` | `table<string, KompotTextStyle>` | нет | Стандартные текстовые стили. |
| `METRICS` | `table<string, number>` | нет | Стандартные размеры comfortable; для действующей темы читайте UI.current().metrics. |
| `MOTION` | `table<string, KompotAnimationSpec>` | нет | Стандартные спецификации анимаций; текущие переопределения находятся в UI.current().motion. |
| `tokens` | `table` | нет | Низкоуровневые токены и построитель темы. Для прикладного экрана используйте UI.theme/UI.Theme. |
| `components` | `table<string, function>` | нет | Таблица реализаций встроенных компонентов. Оформление настраивайте через тему; замена этой общей таблицы влияет на весь процесс. |
| `ui` | `KompotUiContract` | нет | Стандартная реализация переносимого контракта. Для текущего контракта поддерева вызывайте K.ui(). |
| `ToolButton` | `fun(props: KompotUiIconButtonProps)` | нет | Компактная кнопка панели инструментов с выделением выбранного инструмента. Её размеры берутся из tool_w/tool_h темы. |
| `Choice` | `fun(props: KompotUiChoiceProps)` | нет | Показывает варианты кнопками и выбирает по value. Для выбора по индексу используйте Segmented, для длинного списка Select. |
| `Stepper` | `fun(props: KompotUiStepperProps)` | нет | Показывает подпись, значение и отдельные кнопки минус/плюс. Шаг и границы вычисляет владелец через on_minus/on_plus. |
| `Field` | `fun(props: KompotUiFieldProps)` | нет | Оформляет BasicTextField рамкой и цветами темы. Без подписи; для подписи сверху используйте TextField, слева - LabeledField. |
| `LabeledField` | `fun(props: KompotUiLabeledFieldProps)` | нет | Размещает подпись слева от Field. label_width относится к подписи, field_width - к самому полю. |
| `VectorField` | `fun(props: KompotUiVectorFieldProps)` | нет | Показывает три текстовых поля X/Y/Z. Передаёт индекс оси и строку; преобразование и проверка чисел принадлежат владельцу. |
| `Window` | `fun(props: KompotUiWindowProps, content: KompotContent)` | нет | Окно отдельного слоя с запросом закрытия и необязательными перемещением и изменением размеров. Видимость управляется visible или visible_state. |
| `MenuBar` | `fun(props: KompotUiMenuBarProps)` | нет | Строка меню с brand, menus и actions. Без open хранит открытый индекс внутри; при переданном open состояние меняет on_open владельца. |
| `MenuDivider` | `fun(props?: KompotUiProps)` | нет | Разделитель пунктов Menu. Не принимает настройки толщины или цвета; для обычной линии нужен Divider. |
| `Bar` | `fun(props: KompotUiBarProps)` | нет | Оформленная строка состояния с текстом слева и справа. Не закрепляется к краю экрана сама: положение задаёт раскладка. |
| `Toast` | `fun(props: KompotUiToastProps)` | нет | Уведомление, видимость которого определяется непустым text. Не имеет собственного таймера скрытия; очистите text в модели. |
| `ListRow` | `fun(props: KompotUiListRowProps)` | нет | Строка-кнопка с необязательным действием удаления. on_delete только сообщает о намерении; список меняет владелец. |
| `Slot` | `fun(props: KompotUiItemSlotProps)` | нет | Простая ячейка картинки/иконки с бейджем и нажатиями. Для предмета, durability и drag-and-drop нужен ItemSlot. |
| `ItemSlot` | `fun(props: KompotUiItemSlotProps)` | нет | Показывает предмет, количество, прочность, редкость и состояния ячейки. Перенос передаёт payload, а реальное изменение инвентаря выполняет владелец. |
| `InventoryGrid` | `fun(props: KompotUiInventoryProps)` | нет | Строит сетку предметов с пропусками и перетаскиванием внутри drag_group. on_move должен проверить и изменить модель; count нужен для пустых ячеек после конца items. |
| `Hotbar` | `fun(props: KompotUiHotbarProps)` | нет | Показывает ряд ячеек быстрого доступа и необязательное имя выбранного предмета. Не регистрирует цифровые клавиши автоматически. |
| `ResourceBar` | `fun(props: KompotUiResourceBarProps)` | нет | Показывает значение относительно max с подписью и сегментами. Используйте для здоровья/энергии; ProgressBar принимает уже нормализованную долю. |
| `ActionHint` | `fun(props: KompotUiActionHintProps)` | нет | Рисует binding, действие и detail. Это подсказка, а не подписка на событие клавиши. |
| `ItemDetails` | `fun(props: KompotUiItemDetailsProps)` | нет | Показывает сведения выбранного предмета и actions(item). Не выбирает предмет и не изменяет его данные. |
| `MachinePanel` | `fun(props: KompotUiMachinePanelProps)` | нет | Собирает вход, выход, прогресс и энергию устройства. Запуск, остановка, рецепты и перемещение предметов остаются в модели игры. |
| `HUD` | `fun(props: KompotUiHudProps)` | нет | Раскладывает ресурсы, prompt и Hotbar поверх экрана. Пустая область не блокирует мир; игровая модель и привязки клавиш остаются у владельца. |
| `Card` | `fun(props: KompotUiCardProps, content: KompotContent)` | нет | Контейнер-карточка с необязательным нажатием. Раскладку своего содержимого задавайте внутри. |
| `Section` | `fun(text: string, props?: KompotUiProps)` | нет | Заголовок раздела со стилем темы. Для произвольного заголовка со своим цветом используйте K.Text. |
| `Hint` | `fun(text: string, props?: KompotTextProps)` | нет | Поясняющий текст цвета dim. Для ошибки используйте supporting/error поля либо K.Text с нужным цветом. |
| `Key` | `fun(text: string)` | нет | Рисует колпачок клавиши. Не регистрирует клавишу и не создаёт привязку ввода. |
| `Preview` | `fun(props: KompotUiPreviewProps)` | нет | Оформляет картинку рамкой и placeholder. Это компонент миниатюры, а не регистрация превью K.preview. |
| `SplitPane` | `fun(props: KompotUiSplitPaneProps)` | нет | Делит конечную область на две части с перетаскиваемой границей. size управляется снаружи, default_size применяется к внутреннему состоянию. |
| `Lua` | `fun(code: string\|KompotUiLuaProps, props?: KompotUiLuaProps)` | нет | Показывает неизменяемый код с подсветкой, прокруткой и необязательным изменением высоты. Это просмотрщик, не редактор кода и не операция копирования в буфер. |
| `key_chips` | `fun(items: {[1]: string, [2]: string}[]): string` | нет | Формирует строку разметки из пар клавиша/действие. Для отображения передайте её в Bar или K.Text с markup=md. |
| `open_gallery` | `fun()` | нет | Открывает встроенную галерею F12 через HUD движка. Нужен клиентский контекст; в headless-превью используйте K.preview. |

<a id="type-kompotuibadgeprops"></a>
## `KompotUiBadgeProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `count` | `string\|number` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `height` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `padding` | `number` | да | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |

<a id="type-kompotuibarprops"></a>
## `KompotUiBarProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `text` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `right` | `string` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |
| `height` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |

<a id="type-kompotuibuttonprops"></a>
## `KompotUiButtonProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `focusable` | `boolean` | да | Явный локальный фокус независимо от общей навигации. |
| `text` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `icon` | `string` | да | Значок и его размер. Короткое имя разрешается через тему, явный atlas:sprite используется как ресурс. |
| `on_click` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_right_click` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `variant` | `'default'\|'primary'\|'secondary'\|'danger'\|'ghost'\|'toggle'\|string` | да | Вариант оформления конкретного компонента; набор не универсален для всех UI.*. |
| `selected` | `boolean` | да | Состояние выделения, опасное оформление или компактный режим; конкретный эффект зависит от компонента. |
| `size` | `'sm'\|'md'\|'lg'\|number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `align` | `'start'\|'center'` | да | Выравнивание в контексте данного элемента: у Text - текст, у Box - дети, у Row/Column - поперечная ось. |
| `trailing` | `string` | да | Дополнение строки справа: текст/композиция или подсказка сочетания клавиш. Shortcut сам не регистрирует ввод. |
| `compact` | `boolean` | да | Состояние выделения, опасное оформление или компактный режим; конкретный эффект зависит от компонента. |
| `min_width` | `number` | да | Граница допустимого размера в пикселях; не команда масштабировать рисунок. |
| `press_offset` | `number` | да | Сдвиг содержимого нажатой Button в пикселях; 0 отключает сдвиг. |
| `padding` | `number` | да | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `spacing` | `number` | да | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `text_style` | `string\|KompotTextStyle` | да | Имя или описание стиля текста; default_style задаёт fallback темы. |
| `icon_size` | `number` | да | Значок и его размер. Короткое имя разрешается через тему, явный atlas:sprite используется как ресурс. |
| `radius` | `KompotShapeInput` | да | Форма рисунка или обрезки. Рисование формы само по себе не обрезает детей. |

<a id="type-kompotuicardprops"></a>
## `KompotUiCardProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `on_click` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `selected` | `boolean` | да | Состояние выделения, опасное оформление или компактный режим; конкретный эффект зависит от компонента. |
| `padding` | `number` | да | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `radius` | `KompotShapeInput` | да | Форма рисунка или обрезки. Рисование формы само по себе не обрезает детей. |

<a id="type-kompotuichoicedefaults"></a>
## `KompotUiChoiceDefaults`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `options` | `(KompotUiOption\|{[1]: any, [2]: string}\|string)[]` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `selected` | `any` | да | Состояние выделения, опасное оформление или компактный режим; конкретный эффект зависит от компонента. |
| `on_select` | `fun(value: any)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `columns` | `integer` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `size` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |

<a id="type-kompotuichoiceprops"></a>
## `KompotUiChoiceProps`

Наследует [KompotUiChoiceDefaults](#type-kompotuichoicedefaults).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `options` | `(KompotUiOption\|{[1]: any, [2]: string}\|string)[]` | нет | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |

<a id="type-kompotuicomponentdefaults"></a>
## `KompotUiComponentDefaults`

Набор только тех компонентов, которые читают T.props. Поля частичные; значения экземпляра имеют приоритет над defaults темы.

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `Button` | `KompotUiButtonProps` | да | Частичные свойства UI.Button; см. поддерживаемые параметры компонента. |
| `IconButton` | `KompotUiIconButtonDefaults` | да | Частичные свойства UI.IconButton; см. поддерживаемые параметры компонента. |
| `ToolButton` | `KompotUiIconButtonDefaults` | да | Частичные свойства UI.ToolButton; см. поддерживаемые параметры компонента. |
| `Checkbox` | `KompotUiToggleProps` | да | Частичные свойства UI.Checkbox; см. поддерживаемые параметры компонента. |
| `Switch` | `KompotUiToggleProps` | да | Частичные свойства UI.Switch; см. поддерживаемые параметры компонента. |
| `Choice` | `KompotUiChoiceDefaults` | да | Частичные свойства UI.Choice; см. поддерживаемые параметры компонента. |
| `Segmented` | `KompotUiSegmentedDefaults` | да | Частичные свойства UI.Segmented; см. поддерживаемые параметры компонента. |
| `Select` | `KompotUiSelectDefaults` | да | Частичные свойства UI.Select; см. поддерживаемые параметры компонента. |
| `Slider` | `KompotUiSliderProps` | да | Частичные свойства UI.Slider; см. поддерживаемые параметры компонента. |
| `Tabs` | `KompotUiTabsDefaults` | да | Частичные свойства UI.Tabs; см. поддерживаемые параметры компонента. |
| `Field` | `KompotUiFieldProps` | да | Частичные свойства UI.Field; см. поддерживаемые параметры компонента. |
| `TextField` | `KompotUiFieldProps` | да | Частичные свойства UI.TextField; см. поддерживаемые параметры компонента. |
| `LabeledField` | `KompotUiLabeledFieldProps` | да | Частичные свойства UI.LabeledField; см. поддерживаемые параметры компонента. |
| `VectorField` | `KompotUiVectorFieldProps` | да | Частичные свойства UI.VectorField; см. поддерживаемые параметры компонента. |
| `Panel` | `KompotUiPanelProps` | да | Частичные свойства UI.Panel; см. поддерживаемые параметры компонента. |
| `Window` | `KompotUiWindowProps` | да | Частичные свойства UI.Window; см. поддерживаемые параметры компонента. |
| `Dialog` | `KompotUiDialogProps` | да | Частичные свойства UI.Dialog; см. поддерживаемые параметры компонента. |
| `Menu` | `KompotUiMenuProps` | да | Частичные свойства UI.Menu; см. поддерживаемые параметры компонента. |
| `MenuItem` | `KompotUiMenuItemProps` | да | Частичные свойства UI.MenuItem; см. поддерживаемые параметры компонента. |
| `MenuBar` | `KompotUiMenuBarProps` | да | Частичные свойства UI.MenuBar; см. поддерживаемые параметры компонента. |
| `Bar` | `KompotUiBarProps` | да | Частичные свойства UI.Bar; см. поддерживаемые параметры компонента. |
| `Toast` | `KompotUiToastProps` | да | Частичные свойства UI.Toast; см. поддерживаемые параметры компонента. |
| `Card` | `KompotUiCardProps` | да | Частичные свойства UI.Card; см. поддерживаемые параметры компонента. |
| `ListItem` | `KompotUiListItemProps` | да | Частичные свойства UI.ListItem; см. поддерживаемые параметры компонента. |
| `ListRow` | `KompotUiListRowProps` | да | Частичные свойства UI.ListRow; см. поддерживаемые параметры компонента. |
| `SplitPane` | `KompotUiSplitPaneDefaults` | да | Частичные свойства UI.SplitPane; см. поддерживаемые параметры компонента. |
| `Preview` | `KompotUiPreviewProps` | да | Частичные свойства UI.Preview; см. поддерживаемые параметры компонента. |
| `ProgressBar` | `KompotUiProgressProps` | да | Частичные свойства UI.ProgressBar; см. поддерживаемые параметры компонента. |
| `Badge` | `KompotUiBadgeProps` | да | Частичные свойства UI.Badge; см. поддерживаемые параметры компонента. |
| `Divider` | `KompotUiDividerProps` | да | Частичные свойства UI.Divider; см. поддерживаемые параметры компонента. |
| `Hint` | `KompotTextProps` | да | Частичные свойства UI.Hint; см. поддерживаемые параметры компонента. |
| `Key` | `KompotUiKeyProps` | да | Частичные свойства UI.Key; см. поддерживаемые параметры компонента. |
| `Section` | `KompotUiProps` | да | Частичные свойства UI.Section; см. поддерживаемые параметры компонента. |
| `Slot` | `KompotUiItemSlotProps` | да | Частичные свойства UI.Slot; см. поддерживаемые параметры компонента. |
| `ItemSlot` | `KompotUiItemSlotProps` | да | Частичные свойства UI.ItemSlot; см. поддерживаемые параметры компонента. |
| `Stepper` | `KompotUiStepperProps` | да | Частичные свойства UI.Stepper; см. поддерживаемые параметры компонента. |
| `Tooltip` | `KompotUiTooltipDefaults` | да | Частичные свойства UI.Tooltip; см. поддерживаемые параметры компонента. |
| `Scrollbar` | `KompotUiScrollbarDefaults` | да | Частичные свойства UI.Scrollbar; см. поддерживаемые параметры компонента. |

<a id="type-kompotuicontract"></a>
## `KompotUiContract`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `Button` | `fun(props: KompotUiButtonProps, content?: KompotContent)` | нет | Кнопка с текстом, значком и необязательным содержимым. on_click сообщает о действии; данные и последствия принадлежат владельцу. |
| `IconButton` | `fun(props: KompotUiIconButtonProps)` | нет | Кнопка со значком без текстовой подписи. Для подсказки используйте tooltip; icon обязателен. |
| `Checkbox` | `fun(props: KompotUiToggleProps)` | нет | Управляемый флажок. on_change получает новое boolean; компонент сам не присваивает checked владельцу. |
| `Switch` | `fun(props: KompotUiToggleProps)` | нет | Управляемый переключатель boolean. По смыслу аналогичен Checkbox, отличается оформлением. |
| `Tabs` | `fun(props: KompotUiTabsProps)` | нет | Выбирает вкладку по индексу от 1. Не переключает содержимое экрана самостоятельно: его строит владелец по selected. |
| `Divider` | `fun(props?: KompotUiDividerProps)` | нет | Рисует горизонтальную или вертикальную линию с inset. Вертикальной линии нужна определённая высота родителя. |
| `Badge` | `fun(props: KompotUiBadgeProps)` | нет | Рисует небольшую метку-счётчик. Число не изменяется компонентом и не связано с инвентарём автоматически. |
| `ProgressBar` | `fun(props: KompotUiProgressProps)` | нет | Показывает progress в диапазоне 0..1. Отсутствие progress включает непрерывную индикацию ожидания. |
| `Tooltip` | `fun(props: KompotUiTooltipProps, content: KompotContent)` | нет | Показывает подсказку после наведения на обёрнутое содержимое. Не заменяет обработчик клика и не меняет состояние цели. |
| `Dialog` | `fun(props: KompotUiDialogProps, content?: KompotContent)` | нет | Модальное подтверждение по центру с текстом и действиями. Для произвольной геометрии используйте Window; confirm не скрывает диалог автоматически. |
| `Scrollbar` | `fun(props: KompotUiScrollbarProps)` | нет | Рисует и позволяет двигать полосу существующего ScrollState/LazyState. Сам не делает соседнее содержимое прокручиваемым. |
| `MenuItem` | `fun(props: KompotUiMenuItemProps)` | нет | Пункт меню с текстом, значком и shortcut. Сам не закрывает Menu: обработчик должен обновить expanded владельца. |
| `Slider` | `fun(props: KompotUiSliderProps)` | нет | Управляемый числовой ползунок. step задаёт квантование; steps у переносимого контракта означает число интервалов диапазона. |
| `TextField` | `fun(props: KompotUiFieldProps)` | нет | Добавляет к Field подпись сверху, supporting и сообщение об ошибке. Использует тот же контракт владения текстом. |
| `Segmented` | `fun(props: KompotUiSegmentedProps)` | нет | Показывает сегменты и выбирает индекс от 1. Даже если у варианта есть свои данные, callback получает индекс. |
| `Select` | `fun(props: KompotUiSelectProps)` | нет | Открывает прокручиваемый список и выбирает значение варианта. Открытие хранится внутри, selected - у владельца; disabled и read_only запрещают выбор. |
| `Panel` | `fun(props: KompotUiPanelProps, content: KompotContent)` | нет | Панель с заголовком, фоном и содержимым. Блокирует указатель; не является всплывающим окном и сама не закрывается. |
| `ListItem` | `fun(props: KompotUiListItemProps)` | нет | Переносимая строка с headline, supporting, icon и trailing. Для простой кнопки-строки с удалением удобнее ListRow. |
| `Menu` | `fun(props: KompotUiMenuProps, content: KompotContent)` | нет | Всплывающее меню с запросом отмены, прокруткой и локальным фокусом. expanded/expanded_state меняет владелец. |
| `[string]` | `function` | нет | Пользовательские поля таблицы. Их наличие не означает, что каждый встроенный компонент читает такое свойство. |

<a id="type-kompotuidialogaction"></a>
## `KompotUiDialogAction`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `text` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `on_click` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `variant` | `string` | да | Вариант оформления конкретного компонента; набор не универсален для всех UI.*. |

<a id="type-kompotuidialogprops"></a>
## `KompotUiDialogProps`

Тип наследует описание Window для совместимости аннотаций. Dialog фактически читает visible/visible_state, on_close/on_dismiss, title/text, confirm/dismiss/cancel, accent/variant/icon/width; геометрию окна используйте через Window.

Наследует [KompotUiWindowProps](#type-kompotuiwindowprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `text` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `confirm` | `KompotUiDialogAction` | да | Описание кнопки действия диалога; точный порядок запросов закрытия указан у UI.Dialog. |
| `dismiss` | `KompotUiDialogAction` | да | Описание кнопки действия диалога; точный порядок запросов закрытия указан у UI.Dialog. |
| `cancel` | `KompotUiDialogAction` | да | Устаревший алиас dismiss; приоритет у dismiss. |

<a id="type-kompotuidividerprops"></a>
## `KompotUiDividerProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `vertical` | `boolean` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |
| `thickness` | `number` | да | Толщина/отступ линии в пикселях; не границы исходника nine-patch. |
| `inset` | `number` | да | Толщина/отступ линии в пикселях; не границы исходника nine-patch. |
| `color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |

<a id="type-kompotuifieldprops"></a>
## `KompotUiFieldProps`

Field передаёт текстовую модель и события, но управляет pad и высотой сам. focus/color/editor_value из базового TextInputProps не являются отдельными настройками Field.

Наследует [KompotTextInputProps](#type-kompottextinputprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `surface` | `KompotUiSurfaceStyle` | да | Оформление поверхности, роли и переопределения состояний/вариантов. Не передают владельцу события и не меняют правила ввода. |
| `radius` | `KompotShapeInput` | да | Форма рисунка или обрезки. Рисование формы само по себе не обрезает детей. |
| `state` | `KompotState<string>` | да | Состояние, принадлежащее владельцу компонента; тип определяет текстовую модель или положение прокрутки. |
| `label` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `label_width` | `number` | да | Ширина подписи или поля в пикселях, а не общий размер строки. |
| `tooltip` | `string` | да | Текст всплывающей подсказки для элемента либо кнопки удаления. |
| `supporting` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `error` | `string\|boolean` | да | Признак ошибки или строка сообщения; поле/Select используют её для оформления и пояснения. |
| `height` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |

<a id="type-kompotuihotbarprops"></a>
## `KompotUiHotbarProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `items` | `table<integer, KompotUiItem>` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `count` | `integer` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `size` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `selected` | `integer` | да | Состояние выделения, опасное оформление или компактный режим; конкретный эффект зависит от компонента. |
| `show_name` | `boolean` | да | Показывать имя выбранного предмета в Hotbar. |
| `on_select` | `fun(index: integer)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |

<a id="type-kompotuihudprops"></a>
## `KompotUiHudProps`

Наследует [KompotUiHotbarProps](#type-kompotuihotbarprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `prompt` | `KompotUiActionHintProps` | да | Подпись клавиши или описание подсказки действия HUD; ввод регистрирует игровой код. |
| `health` | `number` | да | Текущее или максимальное значение ресурса; ResourceBar вычисляет и ограничивает долю. |
| `health_max` | `number` | да | Текущее или максимальное значение ресурса; ResourceBar вычисляет и ограничивает долю. |
| `energy` | `number` | да | Текущее или максимальное значение ресурса; ResourceBar вычисляет и ограничивает долю. |
| `energy_max` | `number` | да | Текущее или максимальное значение ресурса; ResourceBar вычисляет и ограничивает долю. |
| `experience` | `number` | да | Текущее или максимальное значение ресурса; ResourceBar вычисляет и ограничивает долю. |
| `experience_max` | `number` | да | Текущее или максимальное значение ресурса; ResourceBar вычисляет и ограничивает долю. |

<a id="type-kompotuiiconbuttondefaults"></a>
## `KompotUiIconButtonDefaults`

Наследует [KompotUiButtonProps](#type-kompotuibuttonprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `tint` | `KompotColor` | да | Цвет значка ToolButton. |

<a id="type-kompotuiiconbuttonprops"></a>
## `KompotUiIconButtonProps`

Наследует [KompotUiIconButtonDefaults](#type-kompotuiiconbuttondefaults).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `icon` | `string` | нет | Значок и его размер. Короткое имя разрешается через тему, явный atlas:sprite используется как ресурс. |

<a id="type-kompotuiinventoryprops"></a>
## `KompotUiInventoryProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `items` | `table<integer, KompotUiItem>` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `count` | `number` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `columns` | `number` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `size` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `gap` | `number` | да | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `selected` | `number` | да | Состояние выделения, опасное оформление или компактный режим; конкретный эффект зависит от компонента. |
| `on_select` | `fun(index: number)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_right_click` | `fun(index: number)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_move` | `fun(from: number, to: number, item: KompotUiItem): boolean?` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `accepts` | `fun(target: number, payload: any): boolean` | да | Проверяет допустимость переноса; аргументы заданы сигнатурой. Перенос данных выполняет обработчик события. |
| `drag_group` | `any` | да | Группа допустимого переноса либо префикс диагностических меток ячеек. |
| `slot_props` | `KompotUiItemSlotProps` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `tag_prefix` | `string` | да | Группа допустимого переноса либо префикс диагностических меток ячеек. |

<a id="type-kompotuiitem"></a>
## `KompotUiItem`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `id` | `string` | да | Идентификатор или имя описываемого объекта; точный namespace определяется содержащим типом. |
| `name` | `string` | да | Идентификатор или имя описываемого объекта; точный namespace определяется содержащим типом. |
| `src` | `string` | да | Источник изображения либо место объявления превью. Для изображений texture/path и atlas:sprite - разные схемы. |
| `count` | `number` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `durability` | `number` | да | Прочность как доля 0..1 либо цвет редкости предмета. |
| `rarity` | `KompotColor` | да | Прочность как доля 0..1 либо цвет редкости предмета. |
| `description` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |

<a id="type-kompotuiitemdetailsprops"></a>
## `KompotUiItemDetailsProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `item` | `KompotUiItem` | да | Композиция элемента по индексу Lua от 1. В lazy-списках вызывается только для нужных элементов. |
| `width` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `actions` | `fun(item: KompotUiItem?)` | да | Дочерняя композиция или содержимое области. Callback, строящий дерево, вызывается во время композиции. |

<a id="type-kompotuiitemslotprops"></a>
## `KompotUiItemSlotProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `item` | `KompotUiItem` | да | Композиция элемента по индексу Lua от 1. В lazy-списках вызывается только для нужных элементов. |
| `size` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `selected` | `boolean` | да | Состояние выделения, опасное оформление или компактный режим; конкретный эффект зависит от компонента. |
| `locked` | `boolean` | да | Политика пользовательского взаимодействия. Семантика и поддержка конкретным компонентом указаны в его карточке; эти флаги не взаимозаменяемы. |
| `enabled` | `boolean` | да | Политика пользовательского взаимодействия. Семантика и поддержка конкретным компонентом указаны в его карточке; эти флаги не взаимозаменяемы. |
| `keycap` | `string\|number` | да | Текст клавиши или метка-счётчик на ячейке. Не является привязкой ввода. |
| `placeholder` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `tooltip` | `string` | да | Текст всплывающей подсказки для элемента либо кнопки удаления. |
| `on_click` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_right_click` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_drag_event` | `fun(event: KompotDragEvent, item: KompotUiItem): any` | да | Возвращает переносимые данные на start. |
| `drag_button` | `'left'\|'right'` | да | Кнопка мыши для жеста: left или right. |
| `accepts` | `fun(payload: any): boolean` | да | Проверяет допустимость переноса; аргументы заданы сигнатурой. Перенос данных выполняет обработчик события. |
| `on_drop` | `fun(payload: any): boolean?` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `src` | `string` | да | Источник изображения либо место объявления превью. Для изображений texture/path и atlas:sprite - разные схемы. |
| `icon` | `string` | да | Значок и его размер. Короткое имя разрешается через тему, явный atlas:sprite используется как ресурс. |
| `badge` | `string\|number` | да | Текст клавиши или метка-счётчик на ячейке. Не является привязкой ввода. |

<a id="type-kompotuikeyprops"></a>
## `KompotUiKeyProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `height` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `padding` | `number` | да | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |

<a id="type-kompotuilabeledfieldprops"></a>
## `KompotUiLabeledFieldProps`

Наследует [KompotUiFieldProps](#type-kompotuifieldprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `label_width` | `number` | да | Ширина подписи или поля в пикселях, а не общий размер строки. |
| `field_width` | `number` | да | Ширина подписи или поля в пикселях, а не общий размер строки. |

<a id="type-kompotuilistitemprops"></a>
## `KompotUiListItemProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `headline` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `supporting` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `icon` | `string` | да | Значок и его размер. Короткое имя разрешается через тему, явный atlas:sprite используется как ресурс. |
| `trailing` | `string\|KompotContent` | да | Дополнение строки справа: текст/композиция или подсказка сочетания клавиш. Shortcut сам не регистрирует ввод. |
| `on_click` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `selected` | `boolean` | да | Состояние выделения, опасное оформление или компактный режим; конкретный эффект зависит от компонента. |

<a id="type-kompotuilistrowprops"></a>
## `KompotUiListRowProps`

Наследует [KompotUiButtonProps](#type-kompotuibuttonprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `on_delete` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `delete_tooltip` | `string` | да | Текст всплывающей подсказки для элемента либо кнопки удаления. |

<a id="type-kompotuiluaprops"></a>
## `KompotUiLuaProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `code` | `string` | да | Исходная строка Lua для просмотра. Компонент не исполняет её. |
| `title` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `font` | `string\|false` | да | Имя загруженного ресурса шрифта, не путь к TTF. В поле font=false выбирает шрифт движка. |
| `line_numbers` | `boolean` | да | Показывать номера строк. Это оформление поля, а не изменение исходного текста. |
| `lines` | `integer` | да | lines задаёт высоту поля в строках; max_lines ограничивает отрисовку Text. Не ограничивают длину модели текста. |
| `height` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `height_state` | `KompotState<number\|nil>` | да | Общая высота при повторном создании компонента. |
| `scroll_past_end` | `boolean` | да | Запас прокрутки в одну строку (по умолчанию true). |
| `resizable` | `boolean` | да | Ручка изменения высоты с ограничением по экрану. |
| `min_height` | `number` | да | Минимальная высота в пикселях (по умолчанию 120). |
| `max_height` | `number` | да | Максимальная высота (по умолчанию 70% экрана). |
| `presentation` | `any` | да | Модель текста/выделения или описание нативной текстовой отрисовки. Нужны соответствующие расширения textbox VoxelCore. |

<a id="type-kompotuimachinepanelprops"></a>
## `KompotUiMachinePanelProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `title` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `width` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `input` | `KompotUiItem` | да | Предмет входного слота машины. |
| `output` | `KompotUiItem` | да | Состояние машины: предметы, подпись рецепта, текст статуса и флаг работы; не игровая логика обработки. |
| `on_input` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_output` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `accepts` | `fun(payload: any): boolean` | да | Проверяет допустимость переноса; аргументы заданы сигнатурой. Перенос данных выполняет обработчик события. |
| `on_drop` | `fun(payload: any): boolean?` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `recipe` | `string` | да | Состояние машины: предметы, подпись рецепта, текст статуса и флаг работы; не игровая логика обработки. |
| `progress` | `number` | да | Нормализованный прогресс или число сегментов ResourceBar; модель работы устройства отдельная. |
| `energy` | `number` | да | Текущее или максимальное значение ресурса; ResourceBar вычисляет и ограничивает долю. |
| `max_energy` | `number` | да | Текущее или максимальное значение ресурса; ResourceBar вычисляет и ограничивает долю. |
| `status` | `string` | да | Состояние машины: предметы, подпись рецепта, текст статуса и флаг работы; не игровая логика обработки. |
| `running` | `boolean` | да | Состояние машины: предметы, подпись рецепта, текст статуса и флаг работы; не игровая логика обработки. |
| `on_start` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `content` | `KompotContent` | да | Дочерняя композиция или содержимое области. Callback, строящий дерево, вызывается во время композиции. |

<a id="type-kompotuimenubarprops"></a>
## `KompotUiMenuBarProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `brand` | `string` | да | Описание меню, подпись MenuBar и управляемый индекс открытого меню; nil означает закрыто. |
| `menus` | `{text: string, width?: number, menu_width?: number, items?: KompotUiMenuItemProps[]}[]` | да | Описание меню, подпись MenuBar и управляемый индекс открытого меню; nil означает закрыто. |
| `actions` | `KompotContent` | да | Дочерняя композиция или содержимое области. Callback, строящий дерево, вызывается во время композиции. |
| `open` | `integer` | да | Описание меню, подпись MenuBar и управляемый индекс открытого меню; nil означает закрыто. |
| `on_open` | `fun(index: integer?)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |

<a id="type-kompotuimenuitemprops"></a>
## `KompotUiMenuItemProps`

Наследует [KompotUiButtonProps](#type-kompotuibuttonprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `shortcut` | `string` | да | Дополнение строки справа: текст/композиция или подсказка сочетания клавиш. Shortcut сам не регистрирует ввод. |
| `danger` | `boolean` | да | Состояние выделения, опасное оформление или компактный режим; конкретный эффект зависит от компонента. |
| `divider` | `boolean` | да | Рисует разделитель меню вместо обычного пункта. |

<a id="type-kompotuimenuprops"></a>
## `KompotUiMenuProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `expanded` | `boolean` | да | Управляемая видимость. Для наблюдения за окончанием анимации передайте соответствующий TransitionState. |
| `expanded_state` | `KompotTransitionState<boolean>` | да | Вместо expanded для наблюдения за переходом. |
| `on_dismiss` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `width` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `placement` | `KompotPlacement` | да | Геометрия, слой или поведение окна/всплывающей области. Не все параметры Window применимы к Dialog. |
| `gap` | `number` | да | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `max_height` | `number` | да | По умолчанию 60% экрана; длинное меню прокручивается. |
| `focus_index` | `integer` | да | Начальный фокус среди доступных пунктов (по умолчанию 1). |

<a id="type-kompotuioption"></a>
## `KompotUiOption`

Объект варианта с value/text. Альтернативы: строка либо позиционная пара {value,text}; типизированный VCTS Select выводит тип value.

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `value` | `any` | нет | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |
| `text` | `string` | нет | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `icon` | `string` | да | Значок и его размер. Короткое имя разрешается через тему, явный atlas:sprite используется как ресурс. |
| `tooltip` | `string` | да | Текст всплывающей подсказки для элемента либо кнопки удаления. |
| `enabled` | `boolean` | да | Политика пользовательского взаимодействия. Семантика и поддержка конкретным компонентом указаны в его карточке; эти флаги не взаимозаменяемы. |

<a id="type-kompotuipanelprops"></a>
## `KompotUiPanelProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `title` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `markup` | `'md'` | да | Перенос, многоточие, разметка или подсветка. Поддерживаемые значения и нативные ограничения описаны в TEXT_INPUT. |
| `icon` | `string` | да | Значок и его размер. Короткое имя разрешается через тему, явный atlas:sprite используется как ресурс. |
| `accent` | `string\|KompotColor` | да | Семантический акцент, таблица именованных акцентов или тон уведомления. Имя акцента должно быть определено темой мода. |
| `header` | `KompotContent` | да | Дочерняя композиция или содержимое области. Callback, строящий дерево, вызывается во время композиции. |
| `width` | `number\|false` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `variant` | `'plain'\|'flat'\|'accent'` | да | Вариант оформления конкретного компонента; набор не универсален для всех UI.*. |
| `padding` | `number` | да | Внутренние отступы или отступы концов списка в пикселях; порядок модификаторов остаётся значимым. |
| `spacing` | `number` | да | Промежуток в пикселях; run_spacing разделяет строки FlowRow, gap у всплывающего слоя отделяет его от якоря. |
| `background` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `radius` | `KompotShapeInput` | да | Форма рисунка или обрезки. Рисование формы само по себе не обрезает детей. |
| `fill_height` | `boolean` | да | Правило измерения детей. Не включает прокрутку и не создаёт бесконечную доступную область. |
| `title_modifier` | `KompotModifier` | да | Модификатор отдельной части компонента. Поддерживается только там, где эта часть явно предоставлена API. |
| `content_modifier` | `KompotModifier` | да | Модификатор отдельной части компонента. Поддерживается только там, где эта часть явно предоставлена API. |

<a id="type-kompotuipreviewprops"></a>
## `KompotUiPreviewProps`

Наследует [KompotImageProps](#type-kompotimageprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `src` | `string` | да | Источник изображения либо место объявления превью. Для изображений texture/path и atlas:sprite - разные схемы. |
| `placeholder` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `tooltip` | `string` | да | Текст всплывающей подсказки для элемента либо кнопки удаления. |

<a id="type-kompotuiprogressprops"></a>
## `KompotUiProgressProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `progress` | `number` | да | Нормализованный прогресс или число сегментов ResourceBar; модель работы устройства отдельная. |
| `color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `height` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |

<a id="type-kompotuiprops"></a>
## `KompotUiProps`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `radius` | `KompotShapeInput` | да | Форма рисунка или обрезки. Рисование формы само по себе не обрезает детей. |
| `surface` | `KompotUiSurfaceStyle` | да | Оформление экземпляра поверх темы. |
| `modifier` | `KompotModifier` | да | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `mod` | `KompotModifier` | да | Цепочка раскладки, рисунка и ввода. Для Kompot UI используйте modifier; alias mod поддерживают базовые элементы ядра. |
| `key` | `any` | да | Идентичность области композиции; не позиция на экране и не диагностический tag. |
| `enabled` | `boolean` | да | Политика пользовательского взаимодействия. Семантика и поддержка конкретным компонентом указаны в его карточке; эти флаги не взаимозаменяемы. |
| `tooltip` | `string` | да | Текст всплывающей подсказки для элемента либо кнопки удаления. |

<a id="type-kompotuiresourcebarprops"></a>
## `KompotUiResourceBarProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `label` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `value` | `number` | да | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |
| `max` | `number` | да | Предел или шаг числового контрола/прокрутки. step - величина шага, steps у Slider - число интервалов. |
| `kind` | `string` | да | Дискриминатор описания: вид формы/материала/спецификации или единица измерения. |
| `color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `segments` | `integer` | да | Нормализованный прогресс или число сегментов ResourceBar; модель работы устройства отдельная. |
| `height` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `text` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `compact` | `boolean` | да | Состояние выделения, опасное оформление или компактный режим; конкретный эффект зависит от компонента. |

<a id="type-kompotuiscrollbardefaults"></a>
## `KompotUiScrollbarDefaults`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `state` | `KompotScrollState\|KompotLazyState` | да | Состояние, принадлежащее владельцу компонента; тип определяет текстовую модель или положение прокрутки. |

<a id="type-kompotuiscrollbarprops"></a>
## `KompotUiScrollbarProps`

Наследует [KompotUiScrollbarDefaults](#type-kompotuiscrollbardefaults).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `state` | `KompotScrollState\|KompotLazyState` | нет | Состояние, принадлежащее владельцу компонента; тип определяет текстовую модель или положение прокрутки. |

<a id="type-kompotuisegmenteddefaults"></a>
## `KompotUiSegmentedDefaults`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `options` | `(string\|KompotUiSegmentedOption)[]` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `selected` | `integer` | да | Индекс, а не значение Choice. |
| `on_select` | `fun(index: integer)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |

<a id="type-kompotuisegmentedoption"></a>
## `KompotUiSegmentedOption`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `text` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `[1]` | `string` | да | Первый позиционный элемент Lua-таблицы. В TS-массивах доступ к нему имеет индекс 0. |
| `icon` | `string` | да | Значок и его размер. Короткое имя разрешается через тему, явный atlas:sprite используется как ресурс. |

<a id="type-kompotuisegmentedprops"></a>
## `KompotUiSegmentedProps`

Наследует [KompotUiSegmentedDefaults](#type-kompotuisegmenteddefaults).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `options` | `(string\|KompotUiSegmentedOption)[]` | нет | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |

<a id="type-kompotuiselectdefaults"></a>
## `KompotUiSelectDefaults`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `options` | `(KompotUiOption\|{[1]: any, [2]: string}\|string)[]` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `selected` | `any` | да | Значение принадлежит владельцу. |
| `on_select` | `fun(value: any)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `label` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `hint` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `read_only` | `boolean` | да | Политика пользовательского взаимодействия. Семантика и поддержка конкретным компонентом указаны в его карточке; эти флаги не взаимозаменяемы. |
| `error` | `boolean\|string` | да | Признак ошибки или строка сообщения; поле/Select используют её для оформления и пояснения. |
| `width` | `number` | да | Ширина выпадающего списка; по умолчанию ширина поля. |
| `max_height` | `number` | да | Максимальная высота списка в пикселях. |

<a id="type-kompotuiselectprops"></a>
## `KompotUiSelectProps`

Наследует [KompotUiSelectDefaults](#type-kompotuiselectdefaults).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `options` | `(KompotUiOption\|{[1]: any, [2]: string}\|string)[]` | нет | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |

<a id="type-kompotuiskin"></a>
## `KompotUiSkin`

Наследует [KompotNinePatchOptions](#type-kompotninepatchoptions).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `src` | `string\|KompotRaster` | нет | Источник изображения либо место объявления превью. Для изображений texture/path и atlas:sprite - разные схемы. |
| `midtone` | `number` | да | Яркость исходной текстуры; должна быть больше нуля. |
| `tint` | `false` | да | false сохраняет исходный цвет текстуры. |

<a id="type-kompotuiskininput"></a>
## `KompotUiSkinInput`

`false|string|KompotNinePatch|KompotUiSkin`

[KompotNinePatch](API_TYPES.md#type-kompotninepatch), [KompotUiSkin](API_TYPES.md#type-kompotuiskin)

<a id="type-kompotuisliderprops"></a>
## `KompotUiSliderProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `value` | `number` | да | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |
| `min` | `number` | да | Предел или шаг числового контрола/прокрутки. step - величина шага, steps у Slider - число интервалов. |
| `max` | `number` | да | Предел или шаг числового контрола/прокрутки. step - величина шага, steps у Slider - число интервалов. |
| `step` | `number` | да | Предел или шаг числового контрола/прокрутки. step - величина шага, steps у Slider - число интервалов. |
| `steps` | `integer` | да | Предел или шаг числового контрола/прокрутки. step - величина шага, steps у Slider - число интервалов. |
| `on_change` | `fun(value: number)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_change_end` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `label` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `format` | `fun(value: number): string` | да | Форматирует значение в отображаемый текст; не изменяет значение. |

<a id="type-kompotuisplitpanedefaults"></a>
## `KompotUiSplitPaneDefaults`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `first` | `KompotContent` | да | Дочерняя композиция или содержимое области. Callback, строящий дерево, вызывается во время композиции. |
| `second` | `KompotContent` | да | Дочерняя композиция или содержимое области. Callback, строящий дерево, вызывается во время композиции. |
| `orientation` | `'horizontal'\|'vertical'` | да | Направление разделения SplitPane: horizontal или vertical. |
| `default_size` | `number` | да | Размер/предел области или разделителя SplitPane в пикселях; default_size относится к внутреннему состоянию. |
| `size` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `on_change` | `fun(size: number)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `divider_modifier` | `KompotModifier` | да | Модификатор отдельной части компонента. Поддерживается только там, где эта часть явно предоставлена API. |
| `divider_size` | `number` | да | Размер/предел области или разделителя SplitPane в пикселях; default_size относится к внутреннему состоянию. |
| `min_first` | `number` | да | Размер/предел области или разделителя SplitPane в пикселях; default_size относится к внутреннему состоянию. |
| `min_second` | `number` | да | Размер/предел области или разделителя SplitPane в пикселях; default_size относится к внутреннему состоянию. |
| `max_first` | `number` | да | Размер/предел области или разделителя SplitPane в пикселях; default_size относится к внутреннему состоянию. |
| `step` | `number` | да | Предел или шаг числового контрола/прокрутки. step - величина шага, steps у Slider - число интервалов. |

<a id="type-kompotuisplitpaneprops"></a>
## `KompotUiSplitPaneProps`

Наследует [KompotUiSplitPaneDefaults](#type-kompotuisplitpanedefaults).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `first` | `KompotContent` | нет | Дочерняя композиция или содержимое области. Callback, строящий дерево, вызывается во время композиции. |
| `second` | `KompotContent` | нет | Дочерняя композиция или содержимое области. Callback, строящий дерево, вызывается во время композиции. |

<a id="type-kompotuistepperprops"></a>
## `KompotUiStepperProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `label` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `value` | `number\|string` | да | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |
| `on_minus` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_plus` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `minus` | `string` | да | Подписи кнопок Stepper; арифметику выполняют on_plus/on_minus. |
| `plus` | `string` | да | Подписи кнопок Stepper; арифметику выполняют on_plus/on_minus. |

<a id="type-kompotuisurfacecontext"></a>
## `KompotUiSurfaceContext`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `role` | `string` | нет | Имя роли оформления, например button или field, а не имя компонента Lua. |
| `variant` | `string` | да | Вариант оформления конкретного компонента; набор не универсален для всех UI.*. |
| `kind` | `string` | нет | Дискриминатор описания: вид формы/материала/спецификации или единица измерения. |
| `color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `content_color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `shape` | `KompotShapeInput` | нет | Форма рисунка или обрезки. Рисование формы само по себе не обрезает детей. |
| `border_width` | `number` | нет | Толщина/отступ линии в пикселях; не границы исходника nine-patch. |
| `border_color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `enabled` | `boolean` | нет | Политика пользовательского взаимодействия. Семантика и поддержка конкретным компонентом указаны в его карточке; эти флаги не взаимозаменяемы. |
| `hovered` | `boolean` | да | Снимок состояния взаимодействия или State такого флага. Используется оформлением, не заменяет поведение контрола. |
| `pressed` | `boolean` | да | Снимок состояния взаимодействия или State такого флага. Используется оформлением, не заменяет поведение контрола. |
| `dragged` | `boolean` | да | Снимок состояния взаимодействия или State такого флага. Используется оформлением, не заменяет поведение контрола. |
| `focused` | `boolean` | да | Снимок состояния взаимодействия или State такого флага. Используется оформлением, не заменяет поведение контрола. |
| `selected` | `boolean` | да | Состояние выделения, опасное оформление или компактный режим; конкретный эффект зависит от компонента. |
| `error` | `boolean` | да | Признак ошибки или строка сообщения; поле/Select используют её для оформления и пояснения. |
| `disabled` | `boolean` | нет | Снимок состояния взаимодействия или State такого флага. Используется оформлением, не заменяет поведение контрола. |
| `skin` | `KompotUiSkinInput` | да | Оформление поверхности, роли и переопределения состояний/вариантов. Не передают владельцу события и не меняют правила ввода. |
| `text_style` | `string\|KompotTextStyle` | да | Имя или описание стиля текста; default_style задаёт fallback темы. |
| `press_offset` | `number` | да | Сдвиг содержимого нажатой Button в пикселях; 0 отключает сдвиг. |
| `focus_color` | `KompotColor` | да | Цвет рамки клавиатурного фокуса; показ зависит от способа навигации. |
| `modifier` | `KompotModifier` | нет | Заполнение родителя без изменения его размеров. |

<a id="type-kompotuisurfacestyle"></a>
## `KompotUiSurfaceStyle`

Объединение: default -> роль -> variant -> surface экземпляра -> активные states. Явный radius экземпляра приоритетнее формы поверхности.

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `skin` | `KompotUiSkinInput` | да | false включает однотонную поверхность. |
| `color` | `KompotColor\|false` | да | Цвет заливки или оттенок текстуры; false убирает заливку. |
| `content_color` | `KompotColor` | да | Основной текст Button, IconButton, Field, Checkbox, Switch, MenuItem, Tabs и ListItem. |
| `shape` | `KompotShapeInput` | да | Форма рисунка или обрезки. Рисование формы само по себе не обрезает детей. |
| `border_width` | `number` | да | Толщина/отступ линии в пикселях; не границы исходника nine-patch. |
| `border_color` | `KompotColor` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `text_style` | `string\|KompotTextStyle` | да | Стиль текста кнопки. |
| `press_offset` | `number` | да | Сдвиг содержимого нажатой кнопки. |
| `focus_color` | `KompotColor` | да | Цвет рамки клавиатурного фокуса кнопки. |
| `draw` | `fun(surface: KompotUiSurfaceContext)\|false` | да | Композиция фона; false возвращает встроенную отрисовку. |
| `states` | `table<'selected'\|'hovered'\|'focused'\|'pressed'\|'dragged'\|'error'\|'disabled', KompotUiSurfaceStyle>` | да | Оформление поверхности, роли и переопределения состояний/вариантов. Не передают владельцу события и не меняют правила ввода. |
| `variants` | `table<string, KompotUiSurfaceStyle>` | да | Оформление поверхности, роли и переопределения состояний/вариантов. Не передают владельцу события и не меняют правила ввода. |

<a id="type-kompotuitabsdefaults"></a>
## `KompotUiTabsDefaults`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `indicator` | `boolean` | да | false скрывает полосу выбранной вкладки. |
| `indicator_height` | `number` | да | Толщина индикатора выбранной вкладки в пикселях. |
| `tabs` | `(string\|{text: string, icon?: string})[]` | да | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |
| `selected` | `integer` | да | Состояние выделения, опасное оформление или компактный режим; конкретный эффект зависит от компонента. |
| `on_select` | `fun(index: integer)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |

<a id="type-kompotuitabsprops"></a>
## `KompotUiTabsProps`

Наследует [KompotUiTabsDefaults](#type-kompotuitabsdefaults).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `tabs` | `(string\|{text: string, icon?: string})[]` | нет | Данные списка/сетки/выбора или свойства ячеек. Индексы Lua от 1; для разреженного items задавайте count явно. |

<a id="type-kompotuitheme"></a>
## `KompotUiTheme`

Готовая таблица встроенной темы. ui переопределяет переносимый K.ui(), а не прямые вызовы UI.Button и других реализаций.

Наследует [KompotTheme](#type-kompottheme).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `kompot_ui` | `true` | нет | Свойство темы: режим, плотность, принадлежность встроенной системе или прозрачность панели. |
| `density` | `'compact'\|'comfortable'` | нет | Свойство темы: режим, плотность, принадлежность встроенной системе или прозрачность панели. |
| `accents` | `table<string, KompotColor>` | нет | Семантический акцент, таблица именованных акцентов или тон уведомления. Имя акцента должно быть определено темой мода. |
| `skin` | `table<string, KompotUiSkinInput>` | нет | Оформление поверхности, роли и переопределения состояний/вариантов. Не передают владельцу события и не меняют правила ввода. |
| `surfaces` | `table<string, KompotUiSurfaceStyle>` | нет | Оформление поверхности, роли и переопределения состояний/вариантов. Не передают владельцу события и не меняют правила ввода. |
| `shapes` | `table<string, KompotShapeInput>` | нет | Форма рисунка или обрезки. Рисование формы само по себе не обрезает детей. |
| `components` | `KompotUiComponentDefaults` | нет | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |
| `metrics` | `table<string, number>` | нет | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |
| `motion` | `table<string, KompotAnimationSpec>` | нет | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |
| `ui` | `KompotUiContract` | нет | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |

<a id="type-kompotuithemeoptions"></a>
## `KompotUiThemeOptions`

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `accent` | `string\|KompotColor` | да | Семантический акцент, таблица именованных акцентов или тон уведомления. Имя акцента должно быть определено темой мода. |
| `dark` | `boolean` | да | Свойство темы: режим, плотность, принадлежность встроенной системе или прозрачность панели. |
| `density` | `'compact'\|'comfortable'` | да | Свойство темы: режим, плотность, принадлежность встроенной системе или прозрачность панели. |
| `colors` | `table<string, KompotColor>` | да | Цвет или набор цветов. Строка #RRGGBBAA и массив {r,g,b,a} в 0..1 не равны байтовым каналам Canvas. |
| `skin` | `table<'panel'\|'button'\|'button_pressed'\|'inset', KompotUiSkinInput>` | да | Оформление поверхности, роли и переопределения состояний/вариантов. Не передают владельцу события и не меняют правила ввода. |
| `surfaces` | `table<string, KompotUiSurfaceStyle>` | да | Роли оформления; default применяется ко всем. |
| `shapes` | `table<string, KompotShapeInput>` | да | Форма рисунка или обрезки. Рисование формы само по себе не обрезает детей. |
| `components` | `KompotUiComponentDefaults` | да | Свойства компонентов по умолчанию. |
| `metrics` | `table<string, number>` | да | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |
| `motion` | `table<string, KompotAnimationSpec>` | да | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |
| `accents` | `table<string, KompotColor>` | да | Семантический акцент, таблица именованных акцентов или тон уведомления. Имя акцента должно быть определено темой мода. |
| `type` | `table<string, KompotTextStyle>` | да | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |
| `default_style` | `string` | да | Имя или описание стиля текста; default_style задаёт fallback темы. |
| `icons` | `string` | да | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |
| `fonts` | `string[]` | да | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |
| `panel_alpha` | `number` | да | Свойство темы: режим, плотность, принадлежность встроенной системе или прозрачность панели. |
| `ui` | `table<string, function>` | да | Таблица токенов/ресурсов/реализаций темы. Имена шрифтов и атласов должны соответствовать загруженным ресурсам. |
| `[string]` | `any` | нет | Пользовательские поля таблицы. Их наличие не означает, что каждый встроенный компонент читает такое свойство. |

<a id="type-kompotuitoastprops"></a>
## `KompotUiToastProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `text` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `width` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `top` | `number` | да | Сторона или направление; в Padding это отступ в пикселях. В других структурах смысл определяется типом. |
| `icon` | `string\|false` | да | Значок и его размер. Короткое имя разрешается через тему, явный atlas:sprite используется как ресурс. |
| `accent` | `string\|KompotColor` | да | Семантический акцент, таблица именованных акцентов или тон уведомления. Имя акцента должно быть определено темой мода. |
| `variant` | `'plain'\|'accent'` | да | Вариант оформления конкретного компонента; набор не универсален для всех UI.*. |
| `tone` | `'neutral'\|'info'\|'success'\|'warning'\|'error'` | да | Семантический акцент, таблица именованных акцентов или тон уведомления. Имя акцента должно быть определено темой мода. |

<a id="type-kompotuitoggleprops"></a>
## `KompotUiToggleProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `checked` | `boolean` | да | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |
| `on_change` | `fun(value: boolean)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `label` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |

<a id="type-kompotuitooltipdefaults"></a>
## `KompotUiTooltipDefaults`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `max_width` | `number` | да | Максимальная ширина подсказки; по умолчанию 360. |
| `suppressed` | `boolean` | да | Временно скрывает подсказку независимо от наведения. |
| `text` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `delay` | `number` | да | Задержка появления подсказки в секундах. |
| `placement` | `KompotPlacement` | да | Геометрия, слой или поведение окна/всплывающей области. Не все параметры Window применимы к Dialog. |

<a id="type-kompotuitooltipprops"></a>
## `KompotUiTooltipProps`

Наследует [KompotUiTooltipDefaults](#type-kompotuitooltipdefaults).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `text` | `string` | нет | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |

<a id="type-kompotuivectorfieldprops"></a>
## `KompotUiVectorFieldProps`

Наследует [KompotUiProps](#type-kompotuiprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `label` | `string` | да | Отображаемый текст. hint/placeholder используются при отсутствии содержимого; supporting - дополнительное пояснение. |
| `values` | `(string\|number)[]` | да | Значение, переданное владельцем. Тип и контракт конкретного выбора заданы в карточке API. |
| `on_change` | `fun(axis: integer, text: string)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_submit` | `fun(axis: integer, text: string)` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_focus` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `on_defocus` | `fun()` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `label_width` | `number` | да | Ширина подписи или поля в пикселях, а не общий размер строки. |

<a id="type-kompotuiwindowprops"></a>
## `KompotUiWindowProps`

Window передаёт Panel только явно выбранные параметры. Индивидуальные surface/radius/padding/background не передаются; оформление общей панели задаётся темой.

Наследует [KompotUiPanelProps](#type-kompotuipanelprops).

| Поле/метод | Тип | Необязательно | Описание |
|---|---|---|---|
| `visible` | `boolean` | да | Управляемая видимость. Для наблюдения за окончанием анимации передайте соответствующий TransitionState. |
| `visible_state` | `KompotTransitionState<boolean>` | да | Вместо visible для наблюдения за переходом. |
| `on_close` | `fun()` | да | Запрос закрытия; visible меняет владелец. |
| `close_text` | `string` | да | Подпись кнопки закрытия Window; кнопка появляется при переданном on_close. |
| `on_dismiss` | `fun()` | да | Запрос от клика снаружи или Escape; по умолчанию on_close. |
| `placement` | `KompotPlacement` | да | Геометрия, слой или поведение окна/всплывающей области. Не все параметры Window применимы к Dialog. |
| `bounds` | `{x: number, y: number, width: number, height: number}` | да | Геометрия, слой или поведение окна/всплывающей области. Не все параметры Window применимы к Dialog. |
| `on_bounds_change` | `fun(bounds: {x: number, y: number, width: number, height: number})` | да | Событие с аргументами из сигнатуры. Модель меняет владелец; callback не строит дерево UI. |
| `draggable` | `boolean` | да | Геометрия, слой или поведение окна/всплывающей области. Не все параметры Window применимы к Dialog. |
| `resizable` | `boolean` | да | Геометрия, слой или поведение окна/всплывающей области. Не все параметры Window применимы к Dialog. |
| `modal` | `boolean` | да | Геометрия, слой или поведение окна/всплывающей области. Не все параметры Window применимы к Dialog. |
| `min_width` | `number` | да | Граница допустимого размера в пикселях; не команда масштабировать рисунок. |
| `min_height` | `number` | да | Граница допустимого размера в пикселях; не команда масштабировать рисунок. |
| `max_width` | `number` | да | Граница допустимого размера в пикселях; не команда масштабировать рисунок. |
| `max_height` | `number` | да | Граница допустимого размера в пикселях; не команда масштабировать рисунок. |
| `height` | `number` | да | Размер в пикселях; size обычно задаёт обе стороны, конкретный приоритет указан в карточке компонента. |
| `z` | `number` | да | Геометрия, слой или поведение окна/всплывающей области. Не все параметры Window применимы к Dialog. |
