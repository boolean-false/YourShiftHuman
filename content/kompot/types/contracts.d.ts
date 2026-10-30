// Сгенерировано tools/build_vcts_types.py из annotations/ и types/refinements.d.ts.
// LuaMultiReturn предоставляет VCTS SDK. Имена модулей не меняются при сборке.
import type { KompotRuntime, KompotInputEvent, KompotFontEntry, KompotFontInfo, KompotTypographyOptions, KompotUiTokens, KompotUiComponents, KompotFieldInput, KompotVisibility, KompotExpansion, KompotSelectProps, KompotChoiceProps, KompotThemePatch } from "./refinements";
export type KompotCallable = (this: void, ...args: never[]) => unknown;

export interface KompotCorners {
    /** Радиус слева сверху в пикселях; по умолчанию 0. */
    top_left?: number;
    /** Радиус справа сверху в пикселях; по умолчанию 0. */
    top_right?: number;
    /** Радиус справа снизу в пикселях; по умолчанию 0. */
    bottom_right?: number;
    /** Радиус слева снизу в пикселях; по умолчанию 0. */
    bottom_left?: number;
}

export type KompotRadius = number | KompotCorners;

export interface KompotCornerSize {
    unit: 'px' | 'percent';
    value: number;
}

export type KompotCornerValue = number | KompotCornerSize;

export interface KompotShapeCorners {
    top_left?: KompotCornerValue;
    top_right?: KompotCornerValue;
    bottom_right?: KompotCornerValue;
    bottom_left?: KompotCornerValue;
}

export interface KompotShape {
    kind: 'rectangle' | 'circle' | 'rounded' | 'cut';
}

export type KompotShapeInput = KompotShape | KompotRadius;

export interface KompotShapeApi {
    rectangle: ((this: void) => KompotShape);
    /** Круг для квадрата, капсула для прямоугольника. */
    circle: ((this: void) => KompotShape);
    rounded: ((this: void, size?: KompotCornerValue | KompotShapeCorners) => KompotShape);
    cut: ((this: void, size?: KompotCornerValue | KompotShapeCorners) => KompotShape);
    px: ((this: void, value: number) => KompotCornerSize);
    /** Процент меньшей стороны, 0..100. */
    percent: ((this: void, value: number) => KompotCornerSize);
}

export type KompotColor = string | (number)[];

export type KompotContent = ((this: void) => void);

export type KompotAlign = 'top_start' | 'top_center' | 'top_end' | 'center_start' | 'center' | 'center_end' | 'bottom_start' | 'bottom_center' | 'bottom_end';

export type KompotCrossAlign = 'start' | 'top' | 'center' | 'end' | 'bottom' | number;

export type KompotArrangement = 'start' | 'center' | 'end' | 'between' | 'around' | 'evenly' | number;

export type KompotTextAlign = 'start' | 'center' | 'end';

export type KompotImageFit = 'fill' | 'contain' | 'cover';

export type KompotPlacement = 'below' | 'above' | 'right' | 'center' | 'fill' | ((this: void, anchor: (KompotRect) | undefined, width: number, height: number, screen_width: number, screen_height: number, gap: number) => LuaMultiReturn<[number, number]>);

export interface KompotRect {
    x: number;
    y: number;
    w: number;
    h: number;
}

export interface KompotPadding {
    l?: number;
    t?: number;
    r?: number;
    b?: number;
    h?: number;
    v?: number;
    start?: number;
    top?: number;
    end?: number;
    bottom?: number;
    horizontal?: number;
    vertical?: number;
}

export interface KompotState<T> {
    value: T;
    set: ((this: KompotState<T>, value: T) => void);
    peek: ((this: KompotState<T>) => T);
    update: ((this: KompotState<T>, fn: ((this: void, value: T) => T)) => void);
    /** Копирует таблицу и заменяет поля; функции сохраняются как значения. */
    patch: ((this: KompotState<T>, changes: T extends object ? Partial<T> : never) => void);
    /** Копирует таблицу и меняет поле; nil удаляет, функция вычисляет значение один раз. */
    update_field: (<P extends keyof T>(this: KompotState<T>, key: P, value: T[P] | ((this: void, old: T[P]) => T[P])) => void);
}

export interface KompotLocal<T> {
    default: T;
    name: string;
    get: ((this: KompotLocal<T>) => T);
}

export interface KompotInteraction {
    hovered: KompotState<boolean>;
    pressed: KompotState<boolean>;
    dragged: KompotState<boolean>;
    focused: KompotState<boolean>;
}

export interface KompotClickOptions {
    enabled?: boolean;
    interaction?: KompotInteraction;
    cursor?: string;
    on_long_click?: ((this: void) => void);
    on_right_click?: ((this: void) => void);
    /** Явный локальный фокус; по умолчанию зависит от keyboard_navigation. */
    focusable?: boolean;
    focus_scope?: boolean;
    /** Запрос отмены в верхней области фокуса. */
    on_escape?: ((this: void) => void);
    /** Начальный фокус среди доступных элементов области. */
    focus_index?: number;
    /** Стрелки вверх/вниз и Home/End перемещают фокус. */
    focus_navigation?: 'vertical';
    on_focus?: ((this: void) => void);
    on_defocus?: ((this: void) => void);
    focus_color?: KompotColor;
    /** Устаревший алиас focus_shape. */
    focus_radius?: KompotShapeInput;
    /** Приоритетнее focus_radius. */
    focus_shape?: KompotShapeInput;
}

export type KompotPivot = [number, number] | { x: number; y: number };

export interface KompotDragEvent {
    type: 'start' | 'move' | 'end' | 'cancel';
    /** Локальная координата X после обратного преобразования. */
    x: number;
    /** Локальная координата Y после обратного преобразования. */
    y: number;
    /** Локальное смещение указателя. */
    dx: number;
    /** Локальное смещение указателя. */
    dy: number;
    /** Координата X в содержимом родителя. */
    parent_x: number;
    /** Координата Y в содержимом родителя. */
    parent_y: number;
    /** Смещение указателя в координатах родителя. */
    parent_dx: number;
    /** Смещение указателя в координатах родителя. */
    parent_dy: number;
    /** Пиксели родителя в секунду. */
    velocity_x: number;
    /** Пиксели родителя в секунду. */
    velocity_y: number;
    button: 'left' | 'right';
    /** Цель приняла переносимые данные. */
    accepted?: boolean;
    cancelled?: boolean;
    reason?: 'escape' | 'removed' | 'blocked' | 'reset' | 'cancelled';
}

export interface KompotDragOptions {
    button?: 'left' | 'right';
    /** На start возвращает переносимые данные; остальные результаты игнорируются. */
    on_event?: ((this: void, event: KompotDragEvent) => unknown);
    axis?: 1 | 2;
    interaction?: KompotInteraction;
    cursor?: string;
}

export interface KompotDropOptions {
    on_enter?: ((this: void, payload: unknown) => void);
    on_leave?: ((this: void, payload: unknown) => void);
    on_drop?: ((this: void, payload: unknown) => boolean | void);
}

export interface KompotPointerEvent {
    type: 'down' | 'up' | 'move' | 'cancel';
    x: number;
    y: number;
    dx: number;
    dy: number;
    parent_x: number;
    parent_y: number;
    parent_dx: number;
    parent_dy: number;
    button: 'left' | 'right';
    cancelled?: boolean;
    reason?: string;
}

export interface KompotModifier {
    is: ((this: void, value: unknown) => boolean);
    /** Сравнивает цепочки слоёв. */
    equals: ((this: void, a: KompotModifier, b: KompotModifier) => boolean);
    then_: ((this: KompotModifier, other: KompotModifier) => KompotModifier);
    padding: ((this: KompotModifier, a: number | KompotPadding, b?: number, c?: number, d?: number) => KompotModifier);
    size: ((this: KompotModifier, width: number, height?: number) => KompotModifier);
    width: ((this: KompotModifier, width: number) => KompotModifier);
    height: ((this: KompotModifier, height: number) => KompotModifier);
    size_in: ((this: KompotModifier, min_width?: number, max_width?: number, min_height?: number, max_height?: number) => KompotModifier);
    width_in: ((this: KompotModifier, min?: number, max?: number) => KompotModifier);
    height_in: ((this: KompotModifier, min?: number, max?: number) => KompotModifier);
    required_size: ((this: KompotModifier, width: number, height?: number) => KompotModifier);
    fill_max_width: ((this: KompotModifier, fraction?: number) => KompotModifier);
    fill_max_height: ((this: KompotModifier, fraction?: number) => KompotModifier);
    fill_max_size: ((this: KompotModifier, fraction?: number) => KompotModifier);
    wrap_content: ((this: KompotModifier) => KompotModifier);
    aspect_ratio: ((this: KompotModifier, ratio: number) => KompotModifier);
    offset: ((this: KompotModifier, x?: number, y?: number) => KompotModifier);
    weight: ((this: KompotModifier, weight?: number, fill?: boolean) => KompotModifier);
    match_parent_size: ((this: KompotModifier) => KompotModifier);
    align: ((this: KompotModifier, align: KompotAlign | KompotCrossAlign) => KompotModifier);
    z_index: ((this: KompotModifier, z: number) => KompotModifier);
    vertical_scroll: ((this: KompotModifier, state: KompotScrollState) => KompotModifier);
    horizontal_scroll: ((this: KompotModifier, state: KompotScrollState) => KompotModifier);
    background: ((this: KompotModifier, color: KompotColor, shape?: KompotShapeInput) => KompotModifier);
    /** Только nine-patch; фон с cover задаётся через K.Image внутри Box. */
    background_image: ((this: KompotModifier, paint: KompotNinePatch, tint?: KompotColor) => KompotModifier);
    border: ((this: KompotModifier, width: number, color: KompotColor, shape?: KompotShapeInput) => KompotModifier);
    shadow: ((this: KompotModifier, elevation?: number, shape?: KompotShapeInput, color?: KompotColor, dy?: number) => KompotModifier);
    rotate: ((this: KompotModifier, angle: number, pivot?: KompotPivot) => KompotModifier);
    scale: ((this: KompotModifier, x: number, y?: number, pivot?: KompotPivot) => KompotModifier);
    clip: ((this: KompotModifier, shape?: KompotShapeInput) => KompotModifier);
    alpha: ((this: KompotModifier, alpha: number) => KompotModifier);
    clickable: ((this: KompotModifier, on_click?: ((this: void) => void), opts?: KompotClickOptions) => KompotModifier);
    focusable: ((this: KompotModifier, on_key?: ((this: void, key: string) => void), opts?: KompotClickOptions) => KompotModifier);
    block_pointer: ((this: KompotModifier) => KompotModifier);
    hoverable: ((this: KompotModifier, target: KompotInteraction | ((this: void, hovered: boolean) => void)) => KompotModifier);
    draggable: ((this: KompotModifier, opts: KompotDragOptions) => KompotModifier);
    drop_target: ((this: KompotModifier, opts?: KompotDropOptions) => KompotModifier);
    pointer_input: ((this: KompotModifier, fn: ((this: void, event: KompotPointerEvent) => void)) => KompotModifier);
    on_wheel: ((this: KompotModifier, fn: (this: void, delta: number) => boolean | void) => KompotModifier);
    cursor: ((this: KompotModifier, name: string) => KompotModifier);
    on_size: ((this: KompotModifier, fn: ((this: void, width: number, height: number) => void)) => KompotModifier);
    on_placed: ((this: KompotModifier, fn: ((this: void, x: number, y: number, width: number, height: number) => void)) => KompotModifier);
    tag: ((this: KompotModifier, name: string) => KompotModifier);
}

export interface KompotProps {
    modifier?: KompotModifier;
    mod?: KompotModifier;
    key?: unknown;
}

export interface KompotBoxProps extends KompotProps {
    align?: KompotAlign;
    propagate_min?: boolean;
}

export interface KompotLinearProps extends KompotProps {
    arrangement?: KompotArrangement;
    spacing?: number;
    align?: KompotCrossAlign;
    fill_cross?: boolean;
}

export interface KompotFlowProps extends KompotProps {
    spacing?: number;
    run_spacing?: number;
    align?: KompotCrossAlign;
}

export interface KompotTextStyle {
    font: string;
    bold?: string;
    size?: number;
    color?: KompotColor;
    family?: string;
    weight?: string;
}

export interface KompotTextSpan {
    text?: string;
    1?: string;
    color?: KompotColor;
    style?: string | KompotTextStyle;
    font?: string;
    bold?: boolean;
}

export interface KompotTextProps extends KompotProps {
    style?: string | KompotTextStyle;
    color?: KompotColor;
    align?: KompotTextAlign;
    max_lines?: number;
    wrap?: boolean;
    ellipsis?: boolean;
    font?: string;
    bold_font?: string;
    markup?: 'md';
    spans?: (KompotTextSpan)[];
}

export interface KompotImageProps extends KompotProps {
    width?: number;
    height?: number;
    size?: number;
    /** Размер PNG или спрайта, не всего атласа; обязателен для contain/cover. */
    source_size?: [number, number] | { width: number; height: number };
    /** fill растягивает, contain вписывает, cover заполняет с обрезкой; по умолчанию fill. */
    fit?: KompotImageFit;
    color?: KompotColor;
    region?: (number)[];
}

export interface KompotIconProps extends KompotProps {
    size?: number;
    color?: KompotColor;
}

export interface KompotCanvasImageOptions {
    /** Положение левого верхнего угла до поворота; по умолчанию 0. */
    x?: number;
    y?: number;
    /** Ширина до масштаба; по умолчанию ширина источника. */
    width?: number;
    /** Высота до масштаба; по умолчанию высота источника. */
    height?: number;
    /** Градусы по часовой стрелке; по умолчанию 0. */
    angle?: number;
    scale?: number | [number, number] | { x: number; y: number };
    /** Доли размера; по умолчанию {0.5, 0.5}. */
    pivot?: KompotPivot;
    /** Непрозрачность 0..1. */
    alpha?: number;
    /** Умножение цвета. */
    color?: KompotColor;
    /** UV {u0, v0, u1, v1}; по умолчанию {0, 0, 1, 1}. */
    region?: (number)[];
}

export interface KompotCanvas {
    width: number;
    height: number;
    image: ((this: KompotCanvas, src: string | KompotRaster, opts?: KompotCanvasImageOptions) => void);
    set: ((this: KompotCanvas, x: number, y: number, r: number, g?: number, b?: number, a?: number) => void);
    line: ((this: KompotCanvas, x1: number, y1: number, x2: number, y2: number, r: number, g?: number, b?: number, a?: number) => void);
    rect: ((this: KompotCanvas, x: number, y: number, width: number, height: number, r: number, g?: number, b?: number, a?: number) => void);
    clear: ((this: KompotCanvas, r?: number, g?: number, b?: number, a?: number) => void);
}

export interface KompotRasterOptions {
    /** Общий ключ ресурса с префиксом имени пака. */
    key?: string;
    /** Меняется при изменении исходных пикселей. */
    version?: string | number;
    width: number;
    height: number;
    draw: ((this: void, canvas: KompotCanvas, width: number, height: number) => void);
}

export interface KompotRaster extends KompotRasterOptions {
    kind: 'raster';
}

export interface KompotNinePatchOptions {
    /** Размер PNG или спрайта: {width, height}; обязателен для строкового источника. fit не поддерживается. */
    source_size?: (number)[];
    /** Пиксели источника: число или {left, top, right, bottom}. */
    border?: number | (number)[];
    center?: 'stretch' | 'tile' | 'none';
    edges?: 'stretch' | 'tile';
    scale?: number;
}

export interface KompotNinePatch extends KompotNinePatchOptions {
    kind: 'nine_patch';
    src: string | KompotRaster;
}

export interface KompotCanvasProps extends KompotProps {
    draw: ((this: void, canvas: KompotCanvas, width: number, height: number) => void);
    version?: unknown;
    width?: number;
    height?: number;
}

export interface KompotMeasureApi {
    INF: number;
    measure: ((this: void, child: unknown, min_width: number, max_width: number, min_height: number, max_height: number) => LuaMultiReturn<[number, number]>);
    place: ((this: void, child: unknown, x: number, y: number) => void);
}

export interface KompotLayoutProps extends KompotProps {
    measure: ((this: void, children: (unknown)[], min_width: number, max_width: number, min_height: number, max_height: number, api: KompotMeasureApi) => LuaMultiReturn<[number, number]>);
}

export interface KompotTextInputProps extends KompotProps {
    value?: string;
    on_change?: ((this: void, text: string) => void);
    on_submit?: ((this: void, text: string) => void);
    hint?: string;
    font?: string | false;
    color?: KompotColor;
    lines?: number;
    pad?: number;
    width?: number;
    focus?: boolean;
    on_focus?: ((this: void) => void);
    on_defocus?: ((this: void) => void);
    syntax?: 'lua' | string;
    line_numbers?: boolean;
    /** Нельзя фокусировать, выделять или менять недоступное поле. */
    enabled?: boolean;
    editable?: boolean;
    wrap?: boolean;
    presentation?: unknown;
    editor_state?: KompotState<KompotEditorValue>;
    editor_value?: KompotEditorValue;
    on_selection_change?: ((this: void, anchor: number, caret: number) => void);
}

export interface KompotEditorValue {
    text: string;
    anchor: number;
    caret: number;
}

export interface KompotBasicTextFieldProps extends KompotTextInputProps {
    state?: KompotState<string>;
    editor_state?: KompotState<KompotEditorValue>;
}

export interface KompotScrollState {
    value: number;
    max: number;
    view: number;
    step: number;
    scroll_by: ((this: KompotScrollState, delta: number) => number);
    scroll_to: ((this: KompotScrollState, value: number) => number);
    fraction: ((this: KompotScrollState) => LuaMultiReturn<[number, number]>);
}

export interface KompotLazyState {
    first: number;
    offset: number;
    total: number;
    view: number;
    step: number;
    scroll_by: ((this: KompotLazyState, delta: number) => number);
    scroll_to_item: ((this: KompotLazyState, index: number) => void);
    first_visible: ((this: KompotLazyState) => number);
    fraction: ((this: KompotLazyState) => LuaMultiReturn<[number, number]>);
}

export interface KompotLazyProps extends KompotProps {
    count: number;
    item: ((this: void, index: number) => void);
    key_of?: ((this: void, index: number) => unknown);
    state?: KompotLazyState;
    spacing?: number;
    pad?: number;
    pad_start?: number;
    pad_end?: number;
    fill_cross?: boolean;
}

export interface KompotLazyGridProps extends KompotLazyProps {
    columns?: number;
}

export interface KompotPopupProps {
    /** false отключает ввод содержимого, сохраняя отрисовку. */
    interactive?: boolean;
    placement?: KompotPlacement;
    gap?: number;
    key?: unknown;
    z?: number;
}

export interface KompotTheme {
    name?: string;
    dark?: boolean;
    colors: Partial<Record<string, (number)[]>>;
    type: Partial<Record<string, KompotTextStyle>>;
    default_style?: string;
    icons?: string;
    fonts?: (string)[];
    ui?: KompotUiContract;
    [key: string]: unknown;
}

export interface KompotTween {
    kind: 'tween';
    duration: number;
    easing: string;
}

export interface KompotSpring {
    kind: 'spring';
    stiffness: number;
    damping: number;
}

export interface KompotSnap {
    kind: 'snap';
}

export type KompotAnimationSpec = KompotTween | KompotSpring | KompotSnap;

export interface KompotTransitionState<T> {
    /** Записываемая цель перехода. */
    target_state: T;
    /** Последнее завершённое состояние; только чтение. */
    readonly current_state: T;
    /** Завершены все анимации; только чтение. */
    readonly is_idle: boolean;
    /** Число завершений после применения кадра; изначально 0, только чтение. */
    readonly completion: number;
}

export interface KompotTransition<T> {
    animate: <V extends number | number[]>(this: KompotTransition<T>, value_of: (this: void, state: T) => V, spec?: KompotAnimationSpec) => V;
}

export interface KompotPreviewOptions {
    width?: number;
    height?: number;
    theme?: KompotTheme | ((this: void) => KompotTheme);
    padding?: number;
    group?: string;
    /** Подробная диагностика хуков; по умолчанию true. */
    hook_diagnostics?: boolean;
    /** Обход по Tab; по умолчанию false. */
    keyboard_navigation?: boolean;
}

export interface KompotPreviewEntry {
    name: string;
    opts: KompotPreviewOptions;
    content: KompotContent;
    source?: string;
    line?: number;
}

export interface KompotMountOptions {
    content: KompotContent;
    theme?: KompotTheme;
    target?: unknown;
    fullscreen?: boolean;
    interactive?: boolean;
    z_index?: number;
    /** Обход по Tab и фокус обычных кнопок; по умолчанию false. */
    keyboard_navigation?: boolean;
    /** true блокирует инвентарь для UI; false полностью отключает блокировку. По умолчанию зависит от навигации и ввода текста. */
    lock_inventory?: boolean;
    /** Подробные места вызова хуков; порядок и типы проверяются всегда. */
    hook_diagnostics?: boolean;
}

export interface KompotMountHandle {
    disposed: boolean;
    app: KompotAppInstance;
    backend: Record<string | number, unknown>;
    host: unknown;
    fake_input?: Record<string | number, unknown>;
    close_pending?: boolean;
    dispose: ((this: KompotMountHandle) => void);
    set_content: ((this: KompotMountHandle, content: KompotContent) => void);
    set_theme: ((this: KompotMountHandle, theme: KompotTheme) => void);
    /** Экранная точка над областью ввода UI; после dispose возвращает false. */
    is_over: ((this: KompotMountHandle, x: number, y: number) => boolean);
}

export interface KompotColorApi {
    rgb: ((this: void, r: number, g: number, b: number, a?: number) => (number)[]);
    hex: ((this: void, value: string) => (number)[]);
    of: ((this: void, value: (KompotColor) | undefined) => ((number)[]) | undefined);
    to_hex: ((this: void, value: (number)[]) => string);
    with_alpha: ((this: void, value: (number)[], alpha: number) => (number)[]);
    mul_alpha: ((this: void, value: (number)[], alpha: number) => (number)[]);
    mix: ((this: void, a: (number)[], b: (number)[], t: number) => (number)[]);
    over: ((this: void, base: (number)[], over: (number)[]) => (number)[]);
    equals: ((this: void, a: (number)[], b: (number)[]) => boolean);
    to_hsl: ((this: void, value: (number)[]) => LuaMultiReturn<[number, number, number]>);
    hsl: ((this: void, h: number, s: number, l: number, a?: number) => (number)[]);
    lighten: ((this: void, value: (number)[], amount: number) => (number)[]);
    darken: ((this: void, value: (number)[], amount: number) => (number)[]);
    luminance: ((this: void, value: (number)[]) => number);
    contrast: ((this: void, a: (number)[], b: (number)[]) => number);
    on: ((this: void, background: (number)[], dark?: (number)[], light?: (number)[]) => (number)[]);
    tone: ((this: void, value: (number)[], tone: number, chroma?: number) => (number)[]);
    /** Тоны с числовыми ключами из набора 0..100. */
    palette: ((this: void, value: (number)[], chroma?: number) => Partial<Record<number, (number)[]>>);
    to255: ((this: void, value: (number)[], alpha_mul?: number) => (number)[]);
    WHITE: (number)[];
    BLACK: (number)[];
    TRANSPARENT: (number)[];
}

export interface KompotFontApi {
    register_family: ((this: void, id: string, entries: KompotFontEntry[]) => void);
    info: ((this: void, name: string) => KompotFontInfo | undefined);
    resolve: ((this: void, id: string, size: number, weight?: string) => string);
    typography: ((this: void, defaults: Record<string, KompotTextStyle>, opts?: KompotTypographyOptions, overrides?: Record<string, Partial<KompotTextStyle>>) => Record<string, KompotTextStyle>);
    register_metrics: ((this: void, metrics: Record<string | number, unknown>) => void);
}

export interface KompotTextMeasurer {
    width: ((this: KompotTextMeasurer, font: string, text: string) => number);
    line_height: ((this: KompotTextMeasurer, font: string) => number);
    field_line_height?: ((this: KompotTextMeasurer, font: string) => number);
}

export interface KompotTextLayout {
    lines: (Record<string | number, unknown>)[];
    widths: (number)[];
    w: number;
    h: number;
    lh: number;
    rich?: boolean;
}

export interface KompotTextApi {
    version: number;
    chars: ((this: void, text: string) => (string)[]);
    layout: ((this: void, measurer: KompotTextMeasurer, font: string, text: string | number, max_width: number, max_lines?: number, wrap?: boolean, ellipsis?: boolean) => KompotTextLayout);
    parse_md: ((this: void, text: string) => (Record<string | number, unknown>)[]);
    layout_rich: ((this: void, measurer: KompotTextMeasurer, runs: (Record<string | number, unknown>)[], max_width: number, max_lines?: number, wrap?: boolean) => KompotTextLayout);
    clear_cache: ((this: void) => void);
    approx_measurer: ((this: void, scale?: number) => KompotTextMeasurer);
    register_metrics: ((this: void, metrics: Partial<Record<string, Record<string | number, unknown>>>) => void);
    metrics_measurer: ((this: void) => KompotTextMeasurer);
    field_line_height: ((this: void, measurer: KompotTextMeasurer, font: string) => number);
}

export interface KompotAppOptions {
    content: KompotContent;
    width?: number;
    height?: number;
    measurer?: KompotTextMeasurer;
    backend?: unknown;
    locals?: Record<string | number, unknown>;
    on_error?: ((this: void, message: string) => void);
    hook_diagnostics?: boolean;
    /** Обход по Tab; по умолчанию false. */
    keyboard_navigation?: boolean;
}

export interface KompotApp {
    new: ((this: void, opts: KompotAppOptions) => KompotAppInstance);
}

export interface KompotAppInstance {
    rt: KompotRuntime;
    input: Partial<Record<string, unknown>>;
    dl: (Record<string | number, unknown>)[];
    stats: Partial<Record<string, number>>;
    set_size: ((this: KompotAppInstance, width: number, height: number) => void);
    frame: ((this: KompotAppInstance, dt?: number, event?: KompotInputEvent) => boolean);
    find_tag: ((this: KompotAppInstance, name: string) => (Record<string | number, unknown>) | undefined);
    dispose: ((this: KompotAppInstance) => void);
}

export interface KompotApi {
    VERSION: string;
    /** Копия таблицы с заменой полей; вложенные значения общие, метатаблица не копируется. */
    copy: (<T extends object, U extends object = {}>(this: void, source: T, changes?: U) => Omit<T, keyof U> & U);
    Modifier: KompotModifier;
    M: KompotModifier;
    Shape: KompotShapeApi;
    /** Копирует и проверяет радиусы углов. */
    rounded_corners: ((this: void, radius?: KompotRadius) => KompotRadius);
    /** Рамки и повторение. source - texture/path или atlas:sprite; для cover используйте K.Image. */
    nine_patch: ((this: void, source: string | KompotRaster, opts?: KompotNinePatchOptions) => KompotNinePatch);
    raster: ((this: void, opts: KompotRasterOptions) => KompotRaster);
    Box: ((this: void, a: KompotBoxProps | KompotModifier | KompotContent, content?: KompotContent) => void);
    Row: ((this: void, a: KompotLinearProps | KompotModifier | KompotContent, content?: KompotContent) => void);
    Column: ((this: void, a: KompotLinearProps | KompotModifier | KompotContent, content?: KompotContent) => void);
    FlowRow: ((this: void, a: KompotFlowProps | KompotModifier | KompotContent, content?: KompotContent) => void);
    Spacer: ((this: void, width: number | KompotModifier, height?: number) => void);
    Text: ((this: void, text: string | number | undefined, props?: KompotTextProps) => void);
    /** source - texture/path или atlas:sprite, без префикса пака. Поддерживает fit и фоновый слой в Box. */
    Image: ((this: void, source: string, props?: KompotImageProps) => void);
    Icon: ((this: void, name: string, props?: KompotIconProps) => void);
    Canvas: ((this: void, props: KompotCanvasProps) => void);
    Layout: ((this: void, props: KompotLayoutProps, content: KompotContent) => void);
    TextInput: ((this: void, props: KompotTextInputProps) => void);
    BasicTextField: ((this: void, props: KompotBasicTextFieldProps & KompotFieldInput) => void);
    new_text_field_state: ((this: void, initial?: string) => KompotState<KompotEditorValue>);
    text_field_state: ((this: void, initial?: string) => KompotState<KompotEditorValue>);
    scroll_state: ((this: void, initial?: number) => KompotScrollState);
    lazy_state: ((this: void) => KompotLazyState);
    LazyColumn: ((this: void, props: KompotLazyProps) => void);
    LazyRow: ((this: void, props: KompotLazyProps) => void);
    LazyGrid: ((this: void, props: KompotLazyGridProps) => void);
    Popup: ((this: void, props: KompotPopupProps, content: KompotContent) => void);
    state: (<T>(this: void, initial: T | ((this: void) => T), eq?: (this: void, a: T, b: T) => boolean) => KompotState<T>);
    /** Фиксированный набор состояний полей; для новой схемы пересоздайте через K.key. */
    form: (<T extends object>(this: void, initial: T) => { [P in keyof T]: KompotState<T[P]> });
    new_state: (<T>(this: void, initial: T, eq?: ((this: void, a: T, b: T) => boolean)) => KompotState<T>);
    remember: (<T>(this: void, initial: ((this: void) => T), ...args: (unknown)[]) => T);
    effect: ((this: void, fn: (this: void) => void | ((this: void) => void), ...deps: unknown[]) => void);
    on_dispose: ((this: void, fn: ((this: void) => void)) => void);
    /** Раз в кадр; удаляется вместе с компонентом. */
    on_frame: ((this: void, fn: ((this: void, dt: number) => void)) => void);
    key: ((this: void, key: unknown, content: KompotContent) => void);
    component: (<A extends unknown[], R>(this: void, fn: (this: void, ...args: A) => R) => (this: void, ...args: A) => R);
    provide: (<T>(this: void, local_value: KompotLocal<T>, value: T, content: KompotContent) => void);
    local_of: (<T>(this: void, defaultValue: T, name?: string) => KompotLocal<T>);
    untracked: (<A extends unknown[], R>(this: void, fn: (this: void, ...args: A) => R, ...args: A) => R);
    is_state: ((this: void, value: unknown) => value is KompotState<unknown>);
    poll: (<T>(this: void, getter: ((this: void) => T), eq?: ((this: void, a: T, b: T) => boolean)) => T);
    animate: (<T extends number | number[]>(this: void, target: T, spec?: KompotAnimationSpec) => T);
    transition_state: (<T>(this: void, initial: T) => KompotTransitionState<T>);
    new_transition_state: (<T>(this: void, initial: T) => KompotTransitionState<T>);
    transition: (<T>(this: void, state: KompotTransitionState<T>) => KompotTransition<T>);
    tween: ((this: void, duration?: number, easing?: string) => KompotTween);
    spring: ((this: void, stiffness?: number, damping?: number) => KompotSpring);
    snap: KompotSnap;
    clock: ((this: void) => number);
    after: ((this: void, seconds: number, key?: unknown) => boolean);
    runtime: ((this: void) => KompotRuntime);
    EASING: Partial<Record<string, ((this: void, t: number) => number)>>;
    interaction: ((this: void) => KompotInteraction);
    new_interaction: ((this: void) => KompotInteraction);
    color: KompotColorApi;
    rgb: ((this: void, r: number, g: number, b: number, a?: number) => (number)[]);
    hex: ((this: void, value: string) => (number)[]);
    fonts: KompotFontApi;
    BASE_THEME: KompotTheme;
    theme: ((this: void) => KompotTheme);
    Theme: ((this: void, theme: KompotTheme, content: KompotContent) => void);
    ContentColor: ((this: void, color: KompotColor, content: KompotContent) => void);
    TextStyle: ((this: void, style: string | KompotTextStyle, content: KompotContent) => void);
    style: ((this: void, name: string | KompotTextStyle, theme?: KompotTheme) => KompotTextStyle);
    extend_theme: (<T extends KompotTheme>(this: void, base: T, overrides: KompotThemePatch<T>) => T);
    LocalTheme: KompotLocal<KompotTheme>;
    LocalContentColor: KompotLocal<KompotColor>;
    LocalTextStyle: KompotLocal<KompotTextStyle>;
    ui: ((this: void) => KompotUiContract);
    args: ((this: void, a: KompotProps | KompotModifier | KompotContent, content?: KompotContent) => LuaMultiReturn<[KompotProps, (KompotContent) | undefined]>);
    App: KompotApp;
    text: KompotTextApi;
    preview: ((this: void, name: string, opts: KompotPreviewOptions | KompotContent, content?: KompotContent) => KompotPreviewEntry);
    previews: ((this: void) => (KompotPreviewEntry)[]);
    mount: ((this: void, opts: KompotMountOptions) => KompotMountHandle);
}

export interface KompotUiSkin extends KompotNinePatchOptions {
    src: string | KompotRaster;
    /** Яркость исходной текстуры; должна быть больше нуля. */
    midtone?: number;
    /** false сохраняет исходный цвет текстуры. */
    tint?: false;
}

export type KompotUiSkinInput = false | string | KompotNinePatch | KompotUiSkin;

export interface KompotUiSurfaceStyle {
    /** false включает однотонную поверхность. */
    skin?: KompotUiSkinInput;
    /** Цвет заливки или оттенок текстуры; false убирает заливку. */
    color?: KompotColor | false;
    /** Основной текст Button, IconButton, Field, Checkbox, Switch, MenuItem, Tabs и ListItem. */
    content_color?: KompotColor;
    shape?: KompotShapeInput;
    border_width?: number;
    border_color?: KompotColor;
    /** Стиль текста кнопки. */
    text_style?: string | KompotTextStyle;
    /** Сдвиг содержимого нажатой кнопки. */
    press_offset?: number;
    /** Цвет рамки клавиатурного фокуса кнопки. */
    focus_color?: KompotColor;
    /** Композиция фона; false возвращает встроенную отрисовку. */
    draw?: ((this: void, surface: KompotUiSurfaceContext) => void) | false;
    states?: Partial<Record<'selected' | 'hovered' | 'focused' | 'pressed' | 'dragged' | 'error' | 'disabled', KompotUiSurfaceStyle>>;
    variants?: Partial<Record<string, KompotUiSurfaceStyle>>;
}

export interface KompotUiSurfaceContext {
    role: string;
    variant?: string;
    kind: string;
    color?: KompotColor;
    content_color?: KompotColor;
    shape: KompotShapeInput;
    border_width: number;
    border_color?: KompotColor;
    enabled: boolean;
    hovered?: boolean;
    pressed?: boolean;
    dragged?: boolean;
    focused?: boolean;
    selected?: boolean;
    error?: boolean;
    disabled: boolean;
    skin?: KompotUiSkinInput;
    text_style?: string | KompotTextStyle;
    press_offset?: number;
    focus_color?: KompotColor;
    /** Заполнение родителя без изменения его размеров. */
    modifier: KompotModifier;
}

export interface KompotUiProps {
    radius?: KompotShapeInput;
    /** Оформление экземпляра поверх темы. */
    surface?: KompotUiSurfaceStyle;
    modifier?: KompotModifier;
    mod?: KompotModifier;
    key?: unknown;
    enabled?: boolean;
    tooltip?: string;
}

export interface KompotUiButtonProps extends KompotUiProps {
    /** Явный локальный фокус независимо от общей навигации. */
    focusable?: boolean;
    text?: string;
    icon?: string;
    on_click?: ((this: void) => void);
    on_right_click?: ((this: void) => void);
    variant?: 'default' | 'primary' | 'secondary' | 'danger' | 'ghost' | 'toggle' | string;
    selected?: boolean;
    size?: 'sm' | 'md' | 'lg' | number;
    align?: 'start' | 'center';
    trailing?: string;
    compact?: boolean;
    min_width?: number;
    press_offset?: number;
    padding?: number;
    spacing?: number;
    text_style?: string | KompotTextStyle;
    icon_size?: number;
    radius?: KompotShapeInput;
}

export interface KompotUiIconButtonDefaults extends KompotUiButtonProps {
    /** Цвет значка ToolButton. */
    tint?: KompotColor;
}

export interface KompotUiIconButtonProps extends KompotUiIconButtonDefaults {
    icon: string;
}

export interface KompotUiToggleProps extends KompotUiProps {
    checked?: boolean;
    on_change?: ((this: void, value: boolean) => void);
    label?: string;
}

export interface KompotUiOption {
    value: unknown;
    text: string;
    icon?: string;
    tooltip?: string;
    enabled?: boolean;
}

export interface KompotUiChoiceDefaults extends KompotUiProps {
    options?: ((KompotUiOption | [unknown, string] | string))[];
    selected?: unknown;
    on_select?: ((this: void, value: unknown) => void);
    columns?: number;
    size?: number;
}

export interface KompotUiChoiceProps extends KompotUiChoiceDefaults {
    options: ((KompotUiOption | [unknown, string] | string))[];
}

export interface KompotUiSegmentedOption {
    text?: string;
    1?: string;
    icon?: string;
}

export interface KompotUiSegmentedDefaults extends KompotUiProps {
    options?: ((string | KompotUiSegmentedOption))[];
    /** Индекс, а не значение Choice. */
    selected?: number;
    on_select?: ((this: void, index: number) => void);
}

export interface KompotUiSegmentedProps extends KompotUiSegmentedDefaults {
    options: ((string | KompotUiSegmentedOption))[];
}

export interface KompotUiSelectDefaults extends KompotUiProps {
    options?: ((KompotUiOption | [unknown, string] | string))[];
    /** Значение принадлежит владельцу. */
    selected?: unknown;
    on_select?: ((this: void, value: unknown) => void);
    label?: string;
    hint?: string;
    read_only?: boolean;
    error?: boolean | string;
    /** Ширина выпадающего списка; по умолчанию ширина поля. */
    width?: number;
    /** Максимальная высота списка в пикселях. */
    max_height?: number;
}

export interface KompotUiSelectProps extends KompotUiSelectDefaults {
    options: ((KompotUiOption | [unknown, string] | string))[];
}

export interface KompotUiSliderProps extends KompotUiProps {
    value?: number;
    min?: number;
    max?: number;
    step?: number;
    steps?: number;
    on_change?: ((this: void, value: number) => void);
    on_change_end?: ((this: void) => void);
    label?: string;
    format?: ((this: void, value: number) => string);
}

export interface KompotUiTabsDefaults extends KompotUiProps {
    /** false скрывает полосу выбранной вкладки. */
    indicator?: boolean;
    indicator_height?: number;
    tabs?: ((string | { text: string; icon?: string }))[];
    selected?: number;
    on_select?: ((this: void, index: number) => void);
}

export interface KompotUiTabsProps extends KompotUiTabsDefaults {
    tabs: ((string | { text: string; icon?: string }))[];
}

export interface KompotUiFieldProps extends KompotTextInputProps {
    surface?: KompotUiSurfaceStyle;
    radius?: KompotShapeInput;
    state?: KompotState<string>;
    label?: string;
    label_width?: number;
    tooltip?: string;
    supporting?: string;
    error?: string | boolean;
    height?: number;
}

export interface KompotUiLabeledFieldProps extends KompotUiFieldProps {
    label_width?: number;
    field_width?: number;
}

export interface KompotUiPanelProps extends KompotUiProps {
    title?: string;
    markup?: 'md';
    icon?: string;
    accent?: string | KompotColor;
    header?: KompotContent;
    width?: number | false;
    variant?: 'plain' | 'flat' | 'accent';
    padding?: number;
    spacing?: number;
    background?: KompotColor;
    radius?: KompotShapeInput;
    fill_height?: boolean;
    title_modifier?: KompotModifier;
    content_modifier?: KompotModifier;
}

export interface KompotUiWindowProps extends KompotUiPanelProps {
    visible?: boolean;
    /** Вместо visible для наблюдения за переходом. */
    visible_state?: KompotTransitionState<boolean>;
    /** Запрос закрытия; visible меняет владелец. */
    on_close?: ((this: void) => void);
    close_text?: string;
    /** Запрос от клика снаружи или Escape; по умолчанию on_close. */
    on_dismiss?: ((this: void) => void);
    placement?: KompotPlacement;
    bounds?: { x: number; y: number; width: number; height: number };
    on_bounds_change?: ((this: void, bounds: { x: number; y: number; width: number; height: number }) => void);
    draggable?: boolean;
    resizable?: boolean;
    modal?: boolean;
    min_width?: number;
    min_height?: number;
    max_width?: number;
    max_height?: number;
    height?: number;
    z?: number;
}

export interface KompotUiDialogAction {
    text?: string;
    on_click?: ((this: void) => void);
    variant?: string;
}

export interface KompotUiDialogProps extends KompotUiWindowProps {
    text?: string;
    confirm?: KompotUiDialogAction;
    dismiss?: KompotUiDialogAction;
    /** Устаревший алиас dismiss; приоритет у dismiss. */
    cancel?: KompotUiDialogAction;
}

export interface KompotUiMenuProps extends KompotUiProps {
    expanded?: boolean;
    /** Вместо expanded для наблюдения за переходом. */
    expanded_state?: KompotTransitionState<boolean>;
    on_dismiss?: ((this: void) => void);
    width?: number;
    placement?: KompotPlacement;
    gap?: number;
    /** По умолчанию 60% экрана; длинное меню прокручивается. */
    max_height?: number;
    /** Начальный фокус среди доступных пунктов (по умолчанию 1). */
    focus_index?: number;
}

export interface KompotUiMenuItemProps extends KompotUiButtonProps {
    shortcut?: string;
    danger?: boolean;
    divider?: boolean;
}

export interface KompotUiSplitPaneDefaults extends KompotUiProps {
    first?: KompotContent;
    second?: KompotContent;
    orientation?: 'horizontal' | 'vertical';
    default_size?: number;
    size?: number;
    on_change?: ((this: void, size: number) => void);
    divider_modifier?: KompotModifier;
    divider_size?: number;
    min_first?: number;
    min_second?: number;
    max_first?: number;
    step?: number;
}

export interface KompotUiSplitPaneProps extends KompotUiSplitPaneDefaults {
    first: KompotContent;
    second: KompotContent;
}

export interface KompotUiMenuBarProps extends KompotUiProps {
    brand?: string;
    menus?: ({ text: string; width?: number; menu_width?: number; items?: (KompotUiMenuItemProps)[] })[];
    actions?: KompotContent;
    open?: number;
    on_open?: ((this: void, index: (number) | undefined) => void);
}

export interface KompotUiBarProps extends KompotUiProps {
    text?: string;
    right?: string;
    height?: number;
    color?: KompotColor;
}

export interface KompotUiToastProps extends KompotUiProps {
    text?: string;
    width?: number;
    top?: number;
    icon?: string | false;
    accent?: string | KompotColor;
    variant?: 'plain' | 'accent';
    tone?: 'neutral' | 'info' | 'success' | 'warning' | 'error';
}

export interface KompotUiLuaProps extends KompotUiProps {
    code?: string;
    title?: string;
    font?: string | false;
    line_numbers?: boolean;
    lines?: number;
    height?: number;
    /** Общая высота при повторном создании компонента. */
    height_state?: KompotState<number | undefined>;
    /** Запас прокрутки в одну строку (по умолчанию true). */
    scroll_past_end?: boolean;
    /** Ручка изменения высоты с ограничением по экрану. */
    resizable?: boolean;
    /** Минимальная высота в пикселях (по умолчанию 120). */
    min_height?: number;
    /** Максимальная высота (по умолчанию 70% экрана). */
    max_height?: number;
    presentation?: unknown;
}

export interface KompotUiVectorFieldProps extends KompotUiProps {
    label?: string;
    values?: ((string | number))[];
    on_change?: ((this: void, axis: number, text: string) => void);
    on_submit?: ((this: void, axis: number, text: string) => void);
    on_focus?: ((this: void) => void);
    on_defocus?: ((this: void) => void);
    label_width?: number;
}

export interface KompotUiPreviewProps extends KompotImageProps {
    src?: string;
    placeholder?: string;
    tooltip?: string;
}

export interface KompotUiCardProps extends KompotUiProps {
    on_click?: ((this: void) => void);
    selected?: boolean;
    padding?: number;
    radius?: KompotShapeInput;
}

export interface KompotUiListItemProps extends KompotUiProps {
    headline?: string;
    supporting?: string;
    icon?: string;
    trailing?: string | KompotContent;
    on_click?: ((this: void) => void);
    selected?: boolean;
}

export interface KompotUiProgressProps extends KompotUiProps {
    progress?: number;
    color?: KompotColor;
    height?: number;
}

export interface KompotUiBadgeProps extends KompotUiProps {
    count?: string | number;
    color?: KompotColor;
    height?: number;
    padding?: number;
}

export interface KompotUiListRowProps extends KompotUiButtonProps {
    on_delete?: ((this: void) => void);
    delete_tooltip?: string;
}

export interface KompotUiDividerProps extends KompotUiProps {
    vertical?: boolean;
    thickness?: number;
    inset?: number;
    color?: KompotColor;
}

export interface KompotUiTooltipDefaults extends KompotUiProps {
    /** Максимальная ширина подсказки; по умолчанию 360. */
    max_width?: number;
    /** Временно скрывает подсказку независимо от наведения. */
    suppressed?: boolean;
    text?: string;
    delay?: number;
    placement?: KompotPlacement;
}

export interface KompotUiTooltipProps extends KompotUiTooltipDefaults {
    text: string;
}

export interface KompotUiScrollbarDefaults extends KompotUiProps {
    state?: KompotScrollState | KompotLazyState;
}

export interface KompotUiScrollbarProps extends KompotUiScrollbarDefaults {
    state: KompotScrollState | KompotLazyState;
}

export interface KompotUiStepperProps extends KompotUiProps {
    label?: string;
    value?: number | string;
    on_minus?: ((this: void) => void);
    on_plus?: ((this: void) => void);
    minus?: string;
    plus?: string;
}

export interface KompotUiKeyProps extends KompotUiProps {
    height?: number;
    padding?: number;
}

export interface KompotUiComponentDefaults {
    Button?: KompotUiButtonProps;
    IconButton?: KompotUiIconButtonDefaults;
    ToolButton?: KompotUiIconButtonDefaults;
    Checkbox?: KompotUiToggleProps;
    Switch?: KompotUiToggleProps;
    Choice?: KompotUiChoiceDefaults;
    Segmented?: KompotUiSegmentedDefaults;
    Select?: KompotUiSelectDefaults;
    Slider?: KompotUiSliderProps;
    Tabs?: KompotUiTabsDefaults;
    Field?: KompotUiFieldProps;
    TextField?: KompotUiFieldProps;
    LabeledField?: KompotUiLabeledFieldProps;
    VectorField?: KompotUiVectorFieldProps;
    Panel?: KompotUiPanelProps;
    Window?: KompotUiWindowProps;
    Dialog?: KompotUiDialogProps;
    Menu?: KompotUiMenuProps;
    MenuItem?: KompotUiMenuItemProps;
    MenuBar?: KompotUiMenuBarProps;
    Bar?: KompotUiBarProps;
    Toast?: KompotUiToastProps;
    Card?: KompotUiCardProps;
    ListItem?: KompotUiListItemProps;
    ListRow?: KompotUiListRowProps;
    SplitPane?: KompotUiSplitPaneDefaults;
    Preview?: KompotUiPreviewProps;
    ProgressBar?: KompotUiProgressProps;
    Badge?: KompotUiBadgeProps;
    Divider?: KompotUiDividerProps;
    Hint?: KompotTextProps;
    Key?: KompotUiKeyProps;
    Section?: KompotUiProps;
    Slot?: KompotUiItemSlotProps;
    ItemSlot?: KompotUiItemSlotProps;
    Stepper?: KompotUiStepperProps;
    Tooltip?: KompotUiTooltipDefaults;
    Scrollbar?: KompotUiScrollbarDefaults;
}

export interface KompotUiTheme extends KompotTheme {
    kompot_ui: true;
    density: 'compact' | 'comfortable';
    accents: Partial<Record<string, KompotColor>>;
    skin: Partial<Record<string, KompotUiSkinInput>>;
    surfaces: Partial<Record<string, KompotUiSurfaceStyle>>;
    shapes: Partial<Record<string, KompotShapeInput>>;
    components: KompotUiComponentDefaults;
    metrics: Partial<Record<string, number>>;
    motion: Partial<Record<string, KompotAnimationSpec>>;
    ui: KompotUiContract;
}

export interface KompotUiThemeOptions {
    accent?: string | KompotColor;
    dark?: boolean;
    density?: 'compact' | 'comfortable';
    colors?: Partial<Record<string, KompotColor>>;
    skin?: Partial<Record<'panel' | 'button' | 'button_pressed' | 'inset', KompotUiSkinInput>>;
    /** Роли оформления; default применяется ко всем. */
    surfaces?: Partial<Record<string, KompotUiSurfaceStyle>>;
    shapes?: Partial<Record<string, KompotShapeInput>>;
    /** Свойства компонентов по умолчанию. */
    components?: KompotUiComponentDefaults;
    metrics?: Partial<Record<string, number>>;
    motion?: Partial<Record<string, KompotAnimationSpec>>;
    accents?: Partial<Record<string, KompotColor>>;
    type?: Partial<Record<string, Partial<KompotTextStyle>>>;
    default_style?: string;
    icons?: string;
    fonts?: (string)[];
    panel_alpha?: number;
    ui?: Partial<KompotUiContract>;
    [key: string]: unknown;
}

export interface KompotUiContract {
    Button: ((this: void, props: KompotUiButtonProps, content?: KompotContent) => void);
    IconButton: ((this: void, props: KompotUiIconButtonProps) => void);
    Checkbox: ((this: void, props: KompotUiToggleProps) => void);
    Switch: ((this: void, props: KompotUiToggleProps) => void);
    Tabs: ((this: void, props: KompotUiTabsProps) => void);
    Divider: ((this: void, props?: KompotUiDividerProps) => void);
    Badge: ((this: void, props: KompotUiBadgeProps) => void);
    ProgressBar: ((this: void, props: KompotUiProgressProps) => void);
    Tooltip: ((this: void, props: KompotUiTooltipProps, content: KompotContent) => void);
    Dialog: ((this: void, props: KompotUiDialogProps & KompotVisibility, content?: KompotContent) => void);
    Scrollbar: ((this: void, props: KompotUiScrollbarProps) => void);
    MenuItem: ((this: void, props: KompotUiMenuItemProps) => void);
    Slider: ((this: void, props: KompotUiSliderProps) => void);
    TextField: ((this: void, props: KompotUiFieldProps & KompotFieldInput) => void);
    Segmented: ((this: void, props: KompotUiSegmentedProps) => void);
    Select: (<T>(this: void, props: KompotSelectProps<T>) => void);
    Panel: ((this: void, props: KompotUiPanelProps, content: KompotContent) => void);
    ListItem: ((this: void, props: KompotUiListItemProps) => void);
    Menu: ((this: void, props: KompotUiMenuProps & KompotExpansion, content: KompotContent) => void);
}

export interface KompotUiItem {
    id?: string;
    name?: string;
    src?: string;
    count?: number;
    durability?: number;
    rarity?: KompotColor;
    description?: string;
}

export interface KompotUiItemSlotProps extends KompotUiProps {
    item?: KompotUiItem;
    size?: number;
    selected?: boolean;
    locked?: boolean;
    enabled?: boolean;
    keycap?: string | number;
    placeholder?: string;
    tooltip?: string;
    on_click?: ((this: void) => void);
    on_right_click?: ((this: void) => void);
    /** Возвращает переносимые данные на start. */
    on_drag_event?: ((this: void, event: KompotDragEvent, item: KompotUiItem) => unknown);
    drag_button?: 'left' | 'right';
    accepts?: ((this: void, payload: unknown) => boolean);
    on_drop?: ((this: void, payload: unknown) => boolean | void);
    src?: string;
    icon?: string;
    badge?: string | number;
}

export interface KompotUiInventoryProps extends KompotUiProps {
    items?: Partial<Record<number, KompotUiItem>>;
    count?: number;
    columns?: number;
    size?: number;
    gap?: number;
    selected?: number;
    on_select?: ((this: void, index: number) => void);
    on_right_click?: ((this: void, index: number) => void);
    on_move?: ((this: void, from: number, to: number, item: KompotUiItem) => boolean | void);
    accepts?: ((this: void, target: number, payload: unknown) => boolean);
    drag_group?: unknown;
    slot_props?: KompotUiItemSlotProps;
    tag_prefix?: string;
}

export interface KompotUiHotbarProps extends KompotUiProps {
    items?: Partial<Record<number, KompotUiItem>>;
    count?: number;
    size?: number;
    selected?: number;
    show_name?: boolean;
    on_select?: ((this: void, index: number) => void);
}

export interface KompotUiResourceBarProps extends KompotUiProps {
    label?: string;
    value?: number;
    max?: number;
    kind?: string;
    color?: KompotColor;
    segments?: number;
    height?: number;
    text?: string;
    compact?: boolean;
}

export interface KompotUiActionHintProps extends KompotUiProps {
    binding?: string;
    text?: string;
    detail?: string;
}

export interface KompotUiItemDetailsProps extends KompotUiProps {
    item?: KompotUiItem;
    width?: number;
    actions?: ((this: void, item: (KompotUiItem) | undefined) => void);
}

export interface KompotUiMachinePanelProps extends KompotUiProps {
    title?: string;
    width?: number;
    input?: KompotUiItem;
    output?: KompotUiItem;
    on_input?: ((this: void) => void);
    on_output?: ((this: void) => void);
    accepts?: ((this: void, payload: unknown) => boolean);
    on_drop?: ((this: void, payload: unknown) => boolean | void);
    recipe?: string;
    progress?: number;
    energy?: number;
    max_energy?: number;
    status?: string;
    running?: boolean;
    on_start?: ((this: void) => void);
    content?: KompotContent;
}

export interface KompotUiHudProps extends KompotUiHotbarProps {
    prompt?: KompotUiActionHintProps;
    health?: number;
    health_max?: number;
    energy?: number;
    energy_max?: number;
    experience?: number;
    experience_max?: number;
}

export interface KompotUiApi extends KompotUiContract {
    VERSION: string;
    theme: ((this: void, opts?: KompotUiThemeOptions) => KompotUiTheme);
    Theme: ((this: void, opts: KompotUiThemeOptions, content: KompotContent) => void);
    current: ((this: void) => KompotUiTheme);
    DEFAULT: KompotUiTheme;
    PALETTE: Partial<Record<string, KompotColor>>;
    TYPE: Partial<Record<string, KompotTextStyle>>;
    METRICS: Partial<Record<string, number>>;
    MOTION: Partial<Record<string, KompotAnimationSpec>>;
    tokens: KompotUiTokens;
    components: KompotUiComponents;
    ui: KompotUiContract;
    ToolButton: ((this: void, props: KompotUiIconButtonProps) => void);
    Choice: (<T>(this: void, props: KompotChoiceProps<T>) => void);
    Stepper: ((this: void, props: KompotUiStepperProps) => void);
    Field: ((this: void, props: KompotUiFieldProps & KompotFieldInput) => void);
    LabeledField: ((this: void, props: KompotUiLabeledFieldProps & KompotFieldInput) => void);
    VectorField: ((this: void, props: KompotUiVectorFieldProps) => void);
    Window: ((this: void, props: KompotUiWindowProps & KompotVisibility, content: KompotContent) => void);
    MenuBar: ((this: void, props: KompotUiMenuBarProps) => void);
    MenuDivider: ((this: void, props?: KompotUiProps) => void);
    Bar: ((this: void, props: KompotUiBarProps) => void);
    Toast: ((this: void, props: KompotUiToastProps) => void);
    ListRow: ((this: void, props: KompotUiListRowProps) => void);
    Slot: ((this: void, props: KompotUiItemSlotProps) => void);
    ItemSlot: ((this: void, props: KompotUiItemSlotProps) => void);
    InventoryGrid: ((this: void, props: KompotUiInventoryProps) => void);
    Hotbar: ((this: void, props: KompotUiHotbarProps) => void);
    ResourceBar: ((this: void, props: KompotUiResourceBarProps) => void);
    ActionHint: ((this: void, props: KompotUiActionHintProps) => void);
    ItemDetails: ((this: void, props: KompotUiItemDetailsProps) => void);
    MachinePanel: ((this: void, props: KompotUiMachinePanelProps) => void);
    HUD: ((this: void, props: KompotUiHudProps) => void);
    Card: ((this: void, props: KompotUiCardProps, content: KompotContent) => void);
    Section: ((this: void, text: string, props?: KompotUiProps) => void);
    Hint: ((this: void, text: string, props?: KompotTextProps) => void);
    Key: ((this: void, text: string) => void);
    Preview: ((this: void, props: KompotUiPreviewProps) => void);
    SplitPane: ((this: void, props: KompotUiSplitPaneProps) => void);
    Lua: ((this: void, code: string | KompotUiLuaProps, props?: KompotUiLuaProps) => void);
    key_chips: ((this: void, items: ([string, string])[]) => string);
    open_gallery: ((this: void) => void);
}

export type * from "./refinements";
