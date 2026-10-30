---@meta _

---@class KompotCorners
---@field top_left? number Радиус слева сверху в пикселях; по умолчанию 0.
---@field top_right? number Радиус справа сверху в пикселях; по умолчанию 0.
---@field bottom_right? number Радиус справа снизу в пикселях; по умолчанию 0.
---@field bottom_left? number Радиус слева снизу в пикселях; по умолчанию 0.
---@alias KompotRadius number|KompotCorners

---@class KompotCornerSize
---@field unit 'px'|'percent'
---@field value number
---@alias KompotCornerValue number|KompotCornerSize

---@class KompotShapeCorners
---@field top_left? KompotCornerValue
---@field top_right? KompotCornerValue
---@field bottom_right? KompotCornerValue
---@field bottom_left? KompotCornerValue

---@class KompotShape
---@field kind 'rectangle'|'circle'|'rounded'|'cut'

---@alias KompotShapeInput KompotShape|KompotRadius

---@class KompotShapeApi
---@field rectangle fun(): KompotShape
---@field circle fun(): KompotShape Круг для квадрата, капсула для прямоугольника.
---@field rounded fun(size?: KompotCornerValue|KompotShapeCorners): KompotShape
---@field cut fun(size?: KompotCornerValue|KompotShapeCorners): KompotShape
---@field px fun(value: number): KompotCornerSize
---@field percent fun(value: number): KompotCornerSize Процент меньшей стороны, 0..100.

---@alias KompotColor string|number[]
---@alias KompotContent fun()
---@alias KompotAlign 'top_start'|'top_center'|'top_end'|'center_start'|'center'|'center_end'|'bottom_start'|'bottom_center'|'bottom_end'
---@alias KompotCrossAlign 'start'|'top'|'center'|'end'|'bottom'|number
---@alias KompotArrangement 'start'|'center'|'end'|'between'|'around'|'evenly'|number
---@alias KompotTextAlign 'start'|'center'|'end'
---@alias KompotImageFit 'fill'|'contain'|'cover'
---@alias KompotPlacement 'below'|'above'|'right'|'center'|'fill'|fun(anchor: KompotRect?, width: number, height: number, screen_width: number, screen_height: number, gap: number): number, number

---@class KompotRect
---@field x number
---@field y number
---@field w number
---@field h number

---@class KompotPadding
---@field l? number
---@field t? number
---@field r? number
---@field b? number
---@field h? number
---@field v? number
---@field start? number
---@field top? number
---@field end? number
---@field bottom? number
---@field horizontal? number
---@field vertical? number

---@class KompotState<T>
---@field value T
---@field set fun(self: KompotState<T>, value: T)
---@field peek fun(self: KompotState<T>): T
---@field update fun(self: KompotState<T>, fn: fun(value: T): T)
---@field patch fun(self: KompotState<T>, changes: table) Копирует таблицу и заменяет поля; функции сохраняются как значения.
---@field update_field fun(self: KompotState<T>, key: any, value_or_fn: any|fun(old: any): any) Копирует таблицу и меняет поле; nil удаляет, функция вычисляет значение один раз.

---@class KompotLocal<T>
---@field default T
---@field name string
---@field get fun(self: KompotLocal<T>): T

---@class KompotInteraction
---@field hovered KompotState<boolean>
---@field pressed KompotState<boolean>
---@field dragged KompotState<boolean>
---@field focused KompotState<boolean>

---@class KompotClickOptions
---@field enabled? boolean
---@field interaction? KompotInteraction
---@field cursor? string
---@field on_long_click? fun()
---@field on_right_click? fun()
---@field focusable? boolean Явный локальный фокус; по умолчанию зависит от keyboard_navigation.
---@field focus_scope? boolean
---@field on_escape? fun() Запрос отмены в верхней области фокуса.
---@field focus_index? integer Начальный фокус среди доступных элементов области.
---@field focus_navigation? 'vertical' Стрелки вверх/вниз и Home/End перемещают фокус.
---@field on_focus? fun()
---@field on_defocus? fun()
---@field focus_color? KompotColor
---@field focus_radius? KompotShapeInput Устаревший алиас focus_shape.
---@field focus_shape? KompotShapeInput Приоритетнее focus_radius.

---@alias KompotPivot { [1]: number, [2]: number }|{x: number, y: number}

---@class KompotDragEvent
---@field type 'start'|'move'|'end'|'cancel'
---@field x number Локальная координата X после обратного преобразования.
---@field y number Локальная координата Y после обратного преобразования.
---@field dx number Локальное смещение указателя.
---@field dy number Локальное смещение указателя.
---@field parent_x number Координата X в содержимом родителя.
---@field parent_y number Координата Y в содержимом родителя.
---@field parent_dx number Смещение указателя в координатах родителя.
---@field parent_dy number Смещение указателя в координатах родителя.
---@field velocity_x number Пиксели родителя в секунду.
---@field velocity_y number Пиксели родителя в секунду.
---@field button 'left'|'right'
---@field accepted? boolean Цель приняла переносимые данные.
---@field cancelled? boolean
---@field reason? 'escape'|'removed'|'blocked'|'reset'|'cancelled'

---@class KompotDragOptions
---@field button? 'left'|'right'
---@field on_event? fun(event: KompotDragEvent): any На start возвращает переносимые данные; остальные результаты игнорируются.
---@field axis? 1|2
---@field interaction? KompotInteraction
---@field cursor? string

---@class KompotDropOptions
---@field on_enter? fun(payload: any)
---@field on_leave? fun(payload: any)
---@field on_drop? fun(payload: any): boolean?

---@class KompotPointerEvent
---@field type 'down'|'up'|'move'|'cancel'
---@field x number
---@field y number
---@field dx number
---@field dy number
---@field parent_x number
---@field parent_y number
---@field parent_dx number
---@field parent_dy number
---@field button 'left'|'right'
---@field cancelled? boolean
---@field reason? string

---@class KompotModifier
---@field is fun(value: any): boolean
---@field equals fun(a: KompotModifier, b: KompotModifier): boolean Сравнивает цепочки слоёв.
---@field then_ fun(self: KompotModifier, other: KompotModifier): KompotModifier
---@field padding fun(self: KompotModifier, a: number|KompotPadding, b?: number, c?: number, d?: number): KompotModifier
---@field size fun(self: KompotModifier, width: number, height?: number): KompotModifier
---@field width fun(self: KompotModifier, width: number): KompotModifier
---@field height fun(self: KompotModifier, height: number): KompotModifier
---@field size_in fun(self: KompotModifier, min_width?: number, max_width?: number, min_height?: number, max_height?: number): KompotModifier
---@field width_in fun(self: KompotModifier, min?: number, max?: number): KompotModifier
---@field height_in fun(self: KompotModifier, min?: number, max?: number): KompotModifier
---@field required_size fun(self: KompotModifier, width: number, height?: number): KompotModifier
---@field fill_max_width fun(self: KompotModifier, fraction?: number): KompotModifier
---@field fill_max_height fun(self: KompotModifier, fraction?: number): KompotModifier
---@field fill_max_size fun(self: KompotModifier, fraction?: number): KompotModifier
---@field wrap_content fun(self: KompotModifier): KompotModifier
---@field aspect_ratio fun(self: KompotModifier, ratio: number): KompotModifier
---@field offset fun(self: KompotModifier, x?: number, y?: number): KompotModifier
---@field weight fun(self: KompotModifier, weight?: number, fill?: boolean): KompotModifier
---@field match_parent_size fun(self: KompotModifier): KompotModifier
---@field align fun(self: KompotModifier, align: KompotAlign|KompotCrossAlign): KompotModifier
---@field z_index fun(self: KompotModifier, z: number): KompotModifier
---@field vertical_scroll fun(self: KompotModifier, state: KompotScrollState): KompotModifier
---@field horizontal_scroll fun(self: KompotModifier, state: KompotScrollState): KompotModifier
---@field background fun(self: KompotModifier, color: KompotColor, shape?: KompotShapeInput): KompotModifier
---@field background_image fun(self: KompotModifier, paint: KompotNinePatch, tint?: KompotColor): KompotModifier Только nine-patch; фон с cover задаётся через K.Image внутри Box.
---@field border fun(self: KompotModifier, width: number, color: KompotColor, shape?: KompotShapeInput): KompotModifier
---@field shadow fun(self: KompotModifier, elevation?: number, shape?: KompotShapeInput, color?: KompotColor, dy?: number): KompotModifier
---@field rotate fun(self: KompotModifier, angle: number, pivot?: KompotPivot): KompotModifier
---@field scale fun(self: KompotModifier, x: number, y?: number, pivot?: KompotPivot): KompotModifier
---@field clip fun(self: KompotModifier, shape?: KompotShapeInput): KompotModifier
---@field alpha fun(self: KompotModifier, alpha: number): KompotModifier
---@field clickable fun(self: KompotModifier, on_click?: fun(), opts?: KompotClickOptions): KompotModifier
---@field focusable fun(self: KompotModifier, on_key?: fun(key: string), opts?: KompotClickOptions): KompotModifier
---@field block_pointer fun(self: KompotModifier): KompotModifier
---@field hoverable fun(self: KompotModifier, target: KompotInteraction|fun(hovered: boolean)): KompotModifier
---@field draggable fun(self: KompotModifier, opts: KompotDragOptions): KompotModifier
---@field drop_target fun(self: KompotModifier, opts?: KompotDropOptions): KompotModifier
---@field pointer_input fun(self: KompotModifier, fn: fun(event: KompotPointerEvent)): KompotModifier
---@field on_wheel fun(self: KompotModifier, fn: fun(delta: number): boolean?): KompotModifier
---@field cursor fun(self: KompotModifier, name: string): KompotModifier
---@field on_size fun(self: KompotModifier, fn: fun(width: number, height: number)): KompotModifier
---@field on_placed fun(self: KompotModifier, fn: fun(x: number, y: number, width: number, height: number)): KompotModifier
---@field tag fun(self: KompotModifier, name: string): KompotModifier

---@class KompotProps
---@field modifier? KompotModifier
---@field mod? KompotModifier
---@field key? any

---@class KompotBoxProps: KompotProps
---@field align? KompotAlign
---@field propagate_min? boolean

---@class KompotLinearProps: KompotProps
---@field arrangement? KompotArrangement
---@field spacing? number
---@field align? KompotCrossAlign
---@field fill_cross? boolean

---@class KompotFlowProps: KompotProps
---@field spacing? number
---@field run_spacing? number
---@field align? KompotCrossAlign

---@class KompotTextStyle
---@field font string
---@field bold? string
---@field size? number
---@field color? KompotColor
---@field family? string
---@field weight? string

---@class KompotTextSpan
---@field text? string
---@field [1]? string
---@field color? KompotColor
---@field style? string|KompotTextStyle
---@field font? string
---@field bold? boolean

---@class KompotTextProps: KompotProps
---@field style? string|KompotTextStyle
---@field color? KompotColor
---@field align? KompotTextAlign
---@field max_lines? integer
---@field wrap? boolean
---@field ellipsis? boolean
---@field font? string
---@field bold_font? string
---@field markup? 'md'
---@field spans? KompotTextSpan[]

---@class KompotImageProps: KompotProps
---@field width? number
---@field height? number
---@field size? number
---@field source_size? { [1]: number, [2]: number }|{ width: number, height: number } Размер PNG или спрайта, не всего атласа; обязателен для contain/cover.
---@field fit? KompotImageFit fill растягивает, contain вписывает, cover заполняет с обрезкой; по умолчанию fill.
---@field color? KompotColor
---@field region? number[]

---@class KompotIconProps: KompotProps
---@field size? number
---@field color? KompotColor

---@class KompotCanvasImageOptions
---@field x? number Положение левого верхнего угла до поворота; по умолчанию 0.
---@field y? number
---@field width? number Ширина до масштаба; по умолчанию ширина источника.
---@field height? number Высота до масштаба; по умолчанию высота источника.
---@field angle? number Градусы по часовой стрелке; по умолчанию 0.
---@field scale? number|{ [1]: number, [2]: number }|{x: number, y: number}
---@field pivot? KompotPivot Доли размера; по умолчанию {0.5, 0.5}.
---@field alpha? number Непрозрачность 0..1.
---@field color? KompotColor Умножение цвета.
---@field region? number[] UV {u0, v0, u1, v1}; по умолчанию {0, 0, 1, 1}.

---@class KompotCanvas
---@field width number
---@field height number
---@field image fun(self: KompotCanvas, src: string|KompotRaster, opts?: KompotCanvasImageOptions)
---@field set fun(self: KompotCanvas, x: number, y: number, r: number, g?: number, b?: number, a?: number)
---@field line fun(self: KompotCanvas, x1: number, y1: number, x2: number, y2: number, r: number, g?: number, b?: number, a?: number)
---@field rect fun(self: KompotCanvas, x: number, y: number, width: number, height: number, r: number, g?: number, b?: number, a?: number)
---@field clear fun(self: KompotCanvas, r?: number, g?: number, b?: number, a?: number)

---@class KompotRasterOptions
---@field key? string Общий ключ ресурса с префиксом имени пака.
---@field version? string|number Меняется при изменении исходных пикселей.
---@field width integer
---@field height integer
---@field draw fun(canvas: KompotCanvas, width: integer, height: integer)

---@class KompotRaster: KompotRasterOptions
---@field kind 'raster'

---@class KompotNinePatchOptions
---@field source_size? number[] Размер PNG или спрайта: {width, height}; обязателен для строкового источника. fit не поддерживается.
---@field border? number|number[] Пиксели источника: число или {left, top, right, bottom}.
---@field center? 'stretch'|'tile'|'none'
---@field edges? 'stretch'|'tile'
---@field scale? number

---@class KompotNinePatch: KompotNinePatchOptions
---@field kind 'nine_patch'
---@field src string|KompotRaster

---@class KompotCanvasProps: KompotProps
---@field draw fun(canvas: KompotCanvas, width: number, height: number)
---@field version? any
---@field width? number
---@field height? number

---@class KompotMeasureApi
---@field INF number
---@field measure fun(child: any, min_width: number, max_width: number, min_height: number, max_height: number): number, number
---@field place fun(child: any, x: number, y: number)

---@class KompotLayoutProps: KompotProps
---@field measure fun(children: any[], min_width: number, max_width: number, min_height: number, max_height: number, api: KompotMeasureApi): number, number

---@class KompotTextInputProps: KompotProps
---@field value? string
---@field on_change? fun(text: string)
---@field on_submit? fun(text: string)
---@field hint? string
---@field font? string|false
---@field color? KompotColor
---@field lines? integer
---@field pad? number
---@field width? number
---@field focus? boolean
---@field on_focus? fun()
---@field on_defocus? fun()
---@field syntax? 'lua'|string
---@field line_numbers? boolean
---@field enabled? boolean Нельзя фокусировать, выделять или менять недоступное поле.
---@field editable? boolean
---@field wrap? boolean
---@field presentation? any
---@field editor_state? KompotState<KompotEditorValue>
---@field editor_value? KompotEditorValue
---@field on_selection_change? fun(anchor: number, caret: number)

---@class KompotEditorValue
---@field text string
---@field anchor integer
---@field caret integer

---@class KompotBasicTextFieldProps: KompotTextInputProps
---@field state? KompotState<string>
---@field editor_state? KompotState<KompotEditorValue>

---@class KompotScrollState
---@field value number
---@field max number
---@field view number
---@field step number
---@field scroll_by fun(self: KompotScrollState, delta: number): number
---@field scroll_to fun(self: KompotScrollState, value: number): number
---@field fraction fun(self: KompotScrollState): number, number

---@class KompotLazyState
---@field first integer
---@field offset number
---@field total number
---@field view number
---@field step number
---@field scroll_by fun(self: KompotLazyState, delta: number): number
---@field scroll_to_item fun(self: KompotLazyState, index: integer)
---@field first_visible fun(self: KompotLazyState): integer
---@field fraction fun(self: KompotLazyState): number, number

---@class KompotLazyProps: KompotProps
---@field count integer
---@field item fun(index: integer)
---@field key_of? fun(index: integer): any
---@field state? KompotLazyState
---@field spacing? number
---@field pad? number
---@field pad_start? number
---@field pad_end? number
---@field fill_cross? boolean

---@class KompotLazyGridProps: KompotLazyProps
---@field columns? integer

---@class KompotPopupProps
---@field interactive? boolean false отключает ввод содержимого, сохраняя отрисовку.
---@field placement? KompotPlacement
---@field gap? number
---@field key? any
---@field z? number

---@class KompotTheme
---@field name? string
---@field dark? boolean
---@field colors table<string, number[]>
---@field type table<string, KompotTextStyle>
---@field default_style? string
---@field icons? string
---@field fonts? string[]
---@field ui? KompotUiContract
---@field [string] any

---@class KompotTween
---@field kind 'tween'
---@field duration number
---@field easing string

---@class KompotSpring
---@field kind 'spring'
---@field stiffness number
---@field damping number

---@class KompotSnap
---@field kind 'snap'

---@alias KompotAnimationSpec KompotTween|KompotSpring|KompotSnap

---@class KompotTransitionState<T>
---@field target_state T Записываемая цель перехода.
---@field current_state T Последнее завершённое состояние; только чтение.
---@field is_idle boolean Завершены все анимации; только чтение.
---@field completion integer Число завершений после применения кадра; изначально 0, только чтение.

---@class KompotTransition<T>
local Transition = {}

-- Число или массив чисел; каналы завершаются вместе.
---@generic T
---@generic V: number|number[]
---@param self KompotTransition<T>
---@param value_of fun(state: T): V
---@param spec? KompotAnimationSpec
---@return V
function Transition:animate(value_of, spec) end

---@class KompotPreviewOptions
---@field width? number
---@field height? number
---@field theme? KompotTheme|fun(): KompotTheme
---@field padding? number
---@field group? string
---@field hook_diagnostics? boolean Подробная диагностика хуков; по умолчанию true.
---@field keyboard_navigation? boolean Обход по Tab; по умолчанию false.

---@class KompotPreviewEntry
---@field name string
---@field opts KompotPreviewOptions
---@field content KompotContent
---@field source? string
---@field line? integer

---@class KompotMountOptions
---@field content KompotContent
---@field theme? KompotTheme
---@field target? any
---@field fullscreen? boolean
---@field interactive? boolean
---@field z_index? number
---@field keyboard_navigation? boolean Обход по Tab и фокус обычных кнопок; по умолчанию false.
---@field lock_inventory? boolean true блокирует инвентарь для UI; false полностью отключает блокировку. По умолчанию зависит от навигации и ввода текста.
---@field hook_diagnostics? boolean Подробные места вызова хуков; порядок и типы проверяются всегда.

---@class KompotMountHandle
---@field disposed boolean
---@field app KompotAppInstance
---@field backend table
---@field host any
---@field fake_input? table
---@field close_pending? boolean
---@field dispose fun(self: KompotMountHandle)
---@field set_content fun(self: KompotMountHandle, content: KompotContent)
---@field set_theme fun(self: KompotMountHandle, theme: KompotTheme)
---@field is_over fun(self: KompotMountHandle, x: number, y: number): boolean Экранная точка над областью ввода UI; после dispose возвращает false.

---@class KompotColorApi
---@field rgb fun(r: number, g: number, b: number, a?: number): number[]
---@field hex fun(value: string): number[]
---@field of fun(value: KompotColor?): number[]?
---@field to_hex fun(value: number[]): string
---@field with_alpha fun(value: number[], alpha: number): number[]
---@field mul_alpha fun(value: number[], alpha: number): number[]
---@field mix fun(a: number[], b: number[], t: number): number[]
---@field over fun(base: number[], over: number[]): number[]
---@field equals fun(a: number[], b: number[]): boolean
---@field to_hsl fun(value: number[]): number, number, number
---@field hsl fun(h: number, s: number, l: number, a?: number): number[]
---@field lighten fun(value: number[], amount: number): number[]
---@field darken fun(value: number[], amount: number): number[]
---@field luminance fun(value: number[]): number
---@field contrast fun(a: number[], b: number[]): number
---@field on fun(background: number[], dark?: number[], light?: number[]): number[]
---@field tone fun(value: number[], tone: number, chroma?: number): number[]
---@field palette fun(value: number[], chroma?: number): table<integer, number[]> Тоны с числовыми ключами из набора 0..100.
---@field to255 fun(value: number[], alpha_mul?: number): number[]
---@field WHITE number[]
---@field BLACK number[]
---@field TRANSPARENT number[]

---@class KompotFontApi
---@field register_family fun(id: string, entries: table[]): nil
---@field info fun(name: string): table?
---@field resolve fun(id: string, size: number, weight?: string): string
---@field typography fun(defaults: table<string, KompotTextStyle>, opts?: table, overrides?: table): table<string, KompotTextStyle>
---@field register_metrics fun(metrics: table)

---@class KompotTextMeasurer
---@field width fun(self: KompotTextMeasurer, font: string, text: string): number
---@field line_height fun(self: KompotTextMeasurer, font: string): number
---@field field_line_height? fun(self: KompotTextMeasurer, font: string): number

---@class KompotTextLayout
---@field lines table[]
---@field widths number[]
---@field w number
---@field h number
---@field lh number
---@field rich? boolean

---@class KompotTextApi
---@field version integer
---@field chars fun(text: string): string[]
---@field layout fun(measurer: KompotTextMeasurer, font: string, text: string|number, max_width: number, max_lines?: integer, wrap?: boolean, ellipsis?: boolean): KompotTextLayout
---@field parse_md fun(text: string): table[]
---@field layout_rich fun(measurer: KompotTextMeasurer, runs: table[], max_width: number, max_lines?: integer, wrap?: boolean): KompotTextLayout
---@field clear_cache fun()
---@field approx_measurer fun(scale?: number): KompotTextMeasurer
---@field register_metrics fun(metrics: table<string, table>)
---@field metrics_measurer fun(): KompotTextMeasurer
---@field field_line_height fun(measurer: KompotTextMeasurer, font: string): number

---@class KompotAppOptions
---@field content KompotContent
---@field width? number
---@field height? number
---@field measurer? KompotTextMeasurer
---@field backend? any
---@field locals? table
---@field on_error? fun(message: string)
---@field hook_diagnostics? boolean
---@field keyboard_navigation? boolean Обход по Tab; по умолчанию false.

---@class KompotApp
---@field new fun(opts: KompotAppOptions): KompotAppInstance

---@class KompotAppInstance
---@field rt table<string, any>
---@field input table<string, any>
---@field dl table[]
---@field stats table<string, number>
---@field set_size fun(self: KompotAppInstance, width: number, height: number)
---@field frame fun(self: KompotAppInstance, dt?: number, event?: table): boolean
---@field find_tag fun(self: KompotAppInstance, name: string): table?
---@field dispose fun(self: KompotAppInstance)

---@class KompotApi
---@field VERSION string
---@field copy fun<T>(source: T, changes?: table): T Копия таблицы с заменой полей; вложенные значения общие, метатаблица не копируется.
---@field Modifier KompotModifier
---@field M KompotModifier
---@field Shape KompotShapeApi
---@field rounded_corners fun(radius?: KompotRadius): KompotRadius Копирует и проверяет радиусы углов.
---@field nine_patch fun(source: string|KompotRaster, opts?: KompotNinePatchOptions): KompotNinePatch Рамки и повторение. source - texture/path или atlas:sprite; для cover используйте K.Image.
---@field raster fun(opts: KompotRasterOptions): KompotRaster
---@field Box fun(a: KompotBoxProps|KompotModifier|KompotContent, content?: KompotContent)
---@field Row fun(a: KompotLinearProps|KompotModifier|KompotContent, content?: KompotContent)
---@field Column fun(a: KompotLinearProps|KompotModifier|KompotContent, content?: KompotContent)
---@field FlowRow fun(a: KompotFlowProps|KompotModifier|KompotContent, content?: KompotContent)
---@field Spacer fun(width: number|KompotModifier, height?: number)
---@field Text fun(text: string|number|nil, props?: KompotTextProps)
---@field Image fun(source: string, props?: KompotImageProps) source - texture/path или atlas:sprite, без префикса пака. Поддерживает fit и фоновый слой в Box.
---@field Icon fun(name: string, props?: KompotIconProps)
---@field Canvas fun(props: KompotCanvasProps)
---@field Layout fun(props: KompotLayoutProps, content: KompotContent)
---@field TextInput fun(props: KompotTextInputProps)
---@field BasicTextField fun(props: KompotBasicTextFieldProps)
---@field new_text_field_state fun(initial?: string): KompotState<KompotEditorValue>
---@field text_field_state fun(initial?: string): KompotState<KompotEditorValue>
---@field scroll_state fun(initial?: number): KompotScrollState
---@field lazy_state fun(): KompotLazyState
---@field LazyColumn fun(props: KompotLazyProps)
---@field LazyRow fun(props: KompotLazyProps)
---@field LazyGrid fun(props: KompotLazyGridProps)
---@field Popup fun(props: KompotPopupProps, content: KompotContent)
---@field state fun<T>(initial: T, eq?: fun(a: T, b: T): boolean): KompotState<T>
---@field form fun(initial: table): table<any, KompotState<any>> Фиксированный набор состояний полей; для новой схемы пересоздайте через K.key.
---@field new_state fun<T>(initial: T, eq?: fun(a: T, b: T): boolean): KompotState<T>
---@field remember fun<T>(initial: fun(): T, ...: any): T
---@field effect fun(fn: function, ...: any)
---@field on_dispose fun(fn: fun())
---@field on_frame fun(fn: fun(dt: number)) Раз в кадр; удаляется вместе с компонентом.
---@field key fun(key: any, content: KompotContent)
---@field component fun<T>(fn: T): T
---@field provide fun<T>(local_value: KompotLocal<T>, value: T, content: KompotContent)
---@field local_of fun<T>(default: T, name?: string): KompotLocal<T>
---@field untracked fun<T>(fn: fun(...: any): T, ...: any): T
---@field is_state fun(value: any): boolean
---@field poll fun<T>(getter: fun(): T, eq?: fun(a: T, b: T): boolean): T
---@field animate fun<T>(target: T, spec?: KompotAnimationSpec): T
---@field transition_state fun<T>(initial: T): KompotTransitionState<T>
---@field new_transition_state fun<T>(initial: T): KompotTransitionState<T>
---@field transition fun<T>(state: KompotTransitionState<T>): KompotTransition<T>
---@field tween fun(duration?: number, easing?: string): KompotTween
---@field spring fun(stiffness?: number, damping?: number): KompotSpring
---@field snap KompotSnap
---@field clock fun(): number
---@field after fun(seconds: number, key?: any): boolean
---@field runtime fun(): table
---@field EASING table<string, fun(t: number): number>
---@field interaction fun(): KompotInteraction
---@field new_interaction fun(): KompotInteraction
---@field color KompotColorApi
---@field rgb fun(r: number, g: number, b: number, a?: number): number[]
---@field hex fun(value: string): number[]
---@field fonts KompotFontApi
---@field BASE_THEME KompotTheme
---@field theme fun(): KompotTheme
---@field Theme fun(theme: KompotTheme, content: KompotContent)
---@field ContentColor fun(color: KompotColor, content: KompotContent)
---@field TextStyle fun(style: string|KompotTextStyle, content: KompotContent)
---@field style fun(name: string|KompotTextStyle, theme?: KompotTheme): KompotTextStyle
---@field extend_theme fun(base: KompotTheme, overrides: table): KompotTheme
---@field LocalTheme KompotLocal<KompotTheme>
---@field LocalContentColor KompotLocal<KompotColor>
---@field LocalTextStyle KompotLocal<KompotTextStyle>
---@field ui fun(): KompotUiContract
---@field args fun(a: KompotProps|KompotModifier|KompotContent, content?: KompotContent): KompotProps, KompotContent?
---@field App KompotApp
---@field text KompotTextApi
---@field preview fun(name: string, opts: KompotPreviewOptions|KompotContent, content?: KompotContent): KompotPreviewEntry
---@field previews fun(): KompotPreviewEntry[]
---@field mount fun(opts: KompotMountOptions): KompotMountHandle
