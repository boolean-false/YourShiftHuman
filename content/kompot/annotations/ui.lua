---@meta _

-- API встроенной дизайн-системы и общий контракт K.ui().

---@class KompotUiSkin: KompotNinePatchOptions
---@field src string|KompotRaster
---@field midtone? number Яркость исходной текстуры; должна быть больше нуля.
---@field tint? false false сохраняет исходный цвет текстуры.

---@alias KompotUiSkinInput false|string|KompotNinePatch|KompotUiSkin

---@class KompotUiSurfaceStyle
---@field skin? KompotUiSkinInput false включает однотонную поверхность.
---@field color? KompotColor|false Цвет заливки или оттенок текстуры; false убирает заливку.
---@field content_color? KompotColor Основной текст Button, IconButton, Field, Checkbox, Switch, MenuItem, Tabs и ListItem.
---@field shape? KompotShapeInput
---@field border_width? number
---@field border_color? KompotColor
---@field text_style? string|KompotTextStyle Стиль текста кнопки.
---@field press_offset? number Сдвиг содержимого нажатой кнопки.
---@field focus_color? KompotColor Цвет рамки клавиатурного фокуса кнопки.
---@field draw? fun(surface: KompotUiSurfaceContext)|false Композиция фона; false возвращает встроенную отрисовку.
---@field states? table<'selected'|'hovered'|'focused'|'pressed'|'dragged'|'error'|'disabled', KompotUiSurfaceStyle>
---@field variants? table<string, KompotUiSurfaceStyle>

---@class KompotUiSurfaceContext
---@field role string
---@field variant? string
---@field kind string
---@field color? KompotColor
---@field content_color? KompotColor
---@field shape KompotShapeInput
---@field border_width number
---@field border_color? KompotColor
---@field enabled boolean
---@field hovered? boolean
---@field pressed? boolean
---@field dragged? boolean
---@field focused? boolean
---@field selected? boolean
---@field error? boolean
---@field disabled boolean
---@field skin? KompotUiSkinInput
---@field text_style? string|KompotTextStyle
---@field press_offset? number
---@field focus_color? KompotColor
---@field modifier KompotModifier Заполнение родителя без изменения его размеров.

---@class KompotUiProps
---@field radius? KompotShapeInput
---@field surface? KompotUiSurfaceStyle Оформление экземпляра поверх темы.
---@field modifier? KompotModifier
---@field mod? KompotModifier
---@field key? any
---@field enabled? boolean
---@field tooltip? string

---@class KompotUiButtonProps: KompotUiProps
---@field focusable? boolean Явный локальный фокус независимо от общей навигации.
---@field text? string
---@field icon? string
---@field on_click? fun()
---@field on_right_click? fun()
---@field variant? 'default'|'primary'|'secondary'|'danger'|'ghost'|'toggle'|string
---@field selected? boolean
---@field size? 'sm'|'md'|'lg'|number
---@field align? 'start'|'center'
---@field trailing? string
---@field compact? boolean
---@field min_width? number
---@field press_offset? number
---@field padding? number
---@field spacing? number
---@field text_style? string|KompotTextStyle
---@field icon_size? number
---@field radius? KompotShapeInput

---@class KompotUiIconButtonDefaults: KompotUiButtonProps
---@field tint? KompotColor Цвет значка ToolButton.

---@class KompotUiIconButtonProps: KompotUiIconButtonDefaults
---@field icon string

---@class KompotUiToggleProps: KompotUiProps
---@field checked? boolean
---@field on_change? fun(value: boolean)
---@field label? string

---@class KompotUiOption
---@field value any
---@field text string
---@field icon? string
---@field tooltip? string
---@field enabled? boolean

---@class KompotUiChoiceDefaults: KompotUiProps
---@field options? (KompotUiOption|{[1]: any, [2]: string}|string)[]
---@field selected? any
---@field on_select? fun(value: any)
---@field columns? integer
---@field size? number

---@class KompotUiChoiceProps: KompotUiChoiceDefaults
---@field options (KompotUiOption|{[1]: any, [2]: string}|string)[]

---@class KompotUiSegmentedOption
---@field text? string
---@field [1]? string
---@field icon? string

---@class KompotUiSegmentedDefaults: KompotUiProps
---@field options? (string|KompotUiSegmentedOption)[]
---@field selected? integer Индекс, а не значение Choice.
---@field on_select? fun(index: integer)

---@class KompotUiSegmentedProps: KompotUiSegmentedDefaults
---@field options (string|KompotUiSegmentedOption)[]

---@class KompotUiSelectDefaults: KompotUiProps
---@field options? (KompotUiOption|{[1]: any, [2]: string}|string)[]
---@field selected? any Значение принадлежит владельцу.
---@field on_select? fun(value: any)
---@field label? string
---@field hint? string
---@field read_only? boolean
---@field error? boolean|string
---@field width? number Ширина выпадающего списка; по умолчанию ширина поля.
---@field max_height? number Максимальная высота списка в пикселях.

---@class KompotUiSelectProps: KompotUiSelectDefaults
---@field options (KompotUiOption|{[1]: any, [2]: string}|string)[]

---@class KompotUiSliderProps: KompotUiProps
---@field value? number
---@field min? number
---@field max? number
---@field step? number
---@field steps? integer
---@field on_change? fun(value: number)
---@field on_change_end? fun()
---@field label? string
---@field format? fun(value: number): string

---@class KompotUiTabsDefaults: KompotUiProps
---@field indicator? boolean false скрывает полосу выбранной вкладки.
---@field indicator_height? number
---@field tabs? (string|{text: string, icon?: string})[]
---@field selected? integer
---@field on_select? fun(index: integer)

---@class KompotUiTabsProps: KompotUiTabsDefaults
---@field tabs (string|{text: string, icon?: string})[]

---@class KompotUiFieldProps: KompotTextInputProps
---@field surface? KompotUiSurfaceStyle
---@field radius? KompotShapeInput
---@field state? KompotState<string>
---@field label? string
---@field label_width? number
---@field tooltip? string
---@field supporting? string
---@field error? string|boolean
---@field height? number

---@class KompotUiLabeledFieldProps: KompotUiFieldProps
---@field label_width? number
---@field field_width? number

---@class KompotUiPanelProps: KompotUiProps
---@field title? string
---@field markup? 'md'
---@field icon? string
---@field accent? string|KompotColor
---@field header? KompotContent
---@field width? number|false
---@field variant? 'plain'|'flat'|'accent'
---@field padding? number
---@field spacing? number
---@field background? KompotColor
---@field radius? KompotShapeInput
---@field fill_height? boolean
---@field title_modifier? KompotModifier
---@field content_modifier? KompotModifier

---@class KompotUiWindowProps: KompotUiPanelProps
---@field visible? boolean
---@field visible_state? KompotTransitionState<boolean> Вместо visible для наблюдения за переходом.
---@field on_close? fun() Запрос закрытия; visible меняет владелец.
---@field close_text? string
---@field on_dismiss? fun() Запрос от клика снаружи или Escape; по умолчанию on_close.
---@field placement? KompotPlacement
---@field bounds? {x: number, y: number, width: number, height: number}
---@field on_bounds_change? fun(bounds: {x: number, y: number, width: number, height: number})
---@field draggable? boolean
---@field resizable? boolean
---@field modal? boolean
---@field min_width? number
---@field min_height? number
---@field max_width? number
---@field max_height? number
---@field height? number
---@field z? number

---@class KompotUiDialogAction
---@field text? string
---@field on_click? fun()
---@field variant? string

---@class KompotUiDialogProps: KompotUiWindowProps
---@field text? string
---@field confirm? KompotUiDialogAction
---@field dismiss? KompotUiDialogAction
---@field cancel? KompotUiDialogAction Устаревший алиас dismiss; приоритет у dismiss.

---@class KompotUiMenuProps: KompotUiProps
---@field expanded? boolean
---@field expanded_state? KompotTransitionState<boolean> Вместо expanded для наблюдения за переходом.
---@field on_dismiss? fun()
---@field width? number
---@field placement? KompotPlacement
---@field gap? number
---@field max_height? number По умолчанию 60% экрана; длинное меню прокручивается.
---@field focus_index? integer Начальный фокус среди доступных пунктов (по умолчанию 1).

---@class KompotUiMenuItemProps: KompotUiButtonProps
---@field shortcut? string
---@field danger? boolean
---@field divider? boolean

---@class KompotUiSplitPaneDefaults: KompotUiProps
---@field first? KompotContent
---@field second? KompotContent
---@field orientation? 'horizontal'|'vertical'
---@field default_size? number
---@field size? number
---@field on_change? fun(size: number)
---@field divider_modifier? KompotModifier
---@field divider_size? number
---@field min_first? number
---@field min_second? number
---@field max_first? number
---@field step? number

---@class KompotUiSplitPaneProps: KompotUiSplitPaneDefaults
---@field first KompotContent
---@field second KompotContent

---@class KompotUiMenuBarProps: KompotUiProps
---@field brand? string
---@field menus? {text: string, width?: number, menu_width?: number, items?: KompotUiMenuItemProps[]}[]
---@field actions? KompotContent
---@field open? integer
---@field on_open? fun(index: integer?)

---@class KompotUiBarProps: KompotUiProps
---@field text? string
---@field right? string
---@field height? number
---@field color? KompotColor

---@class KompotUiToastProps: KompotUiProps
---@field text? string
---@field width? number
---@field top? number
---@field icon? string|false
---@field accent? string|KompotColor
---@field variant? 'plain'|'accent'
---@field tone? 'neutral'|'info'|'success'|'warning'|'error'

---@class KompotUiLuaProps: KompotUiProps
---@field code? string
---@field title? string
---@field font? string|false
---@field line_numbers? boolean
---@field lines? integer
---@field height? number
---@field height_state? KompotState<number|nil> Общая высота при повторном создании компонента.
---@field scroll_past_end? boolean Запас прокрутки в одну строку (по умолчанию true).
---@field resizable? boolean Ручка изменения высоты с ограничением по экрану.
---@field min_height? number Минимальная высота в пикселях (по умолчанию 120).
---@field max_height? number Максимальная высота (по умолчанию 70% экрана).
---@field presentation? any

---@class KompotUiVectorFieldProps: KompotUiProps
---@field label? string
---@field values? (string|number)[]
---@field on_change? fun(axis: integer, text: string)
---@field on_submit? fun(axis: integer, text: string)
---@field on_focus? fun()
---@field on_defocus? fun()
---@field label_width? number

---@class KompotUiPreviewProps: KompotImageProps
---@field src? string
---@field placeholder? string
---@field tooltip? string

---@class KompotUiCardProps: KompotUiProps
---@field on_click? fun()
---@field selected? boolean
---@field padding? number
---@field radius? KompotShapeInput

---@class KompotUiListItemProps: KompotUiProps
---@field headline? string
---@field supporting? string
---@field icon? string
---@field trailing? string|KompotContent
---@field on_click? fun()
---@field selected? boolean

---@class KompotUiProgressProps: KompotUiProps
---@field progress? number
---@field color? KompotColor
---@field height? number

---@class KompotUiBadgeProps: KompotUiProps
---@field count? string|number
---@field color? KompotColor
---@field height? number
---@field padding? number

---@class KompotUiListRowProps: KompotUiButtonProps
---@field on_delete? fun()
---@field delete_tooltip? string

---@class KompotUiDividerProps: KompotUiProps
---@field vertical? boolean
---@field thickness? number
---@field inset? number
---@field color? KompotColor

---@class KompotUiTooltipDefaults: KompotUiProps
---@field max_width? number Максимальная ширина подсказки; по умолчанию 360.
---@field suppressed? boolean Временно скрывает подсказку независимо от наведения.
---@field text? string
---@field delay? number
---@field placement? KompotPlacement

---@class KompotUiTooltipProps: KompotUiTooltipDefaults
---@field text string

---@class KompotUiScrollbarDefaults: KompotUiProps
---@field state? KompotScrollState|KompotLazyState

---@class KompotUiScrollbarProps: KompotUiScrollbarDefaults
---@field state KompotScrollState|KompotLazyState

---@class KompotUiStepperProps: KompotUiProps
---@field label? string
---@field value? number|string
---@field on_minus? fun()
---@field on_plus? fun()
---@field minus? string
---@field plus? string

---@class KompotUiKeyProps: KompotUiProps
---@field height? number
---@field padding? number

---@class KompotUiComponentDefaults
---@field Button? KompotUiButtonProps
---@field IconButton? KompotUiIconButtonDefaults
---@field ToolButton? KompotUiIconButtonDefaults
---@field Checkbox? KompotUiToggleProps
---@field Switch? KompotUiToggleProps
---@field Choice? KompotUiChoiceDefaults
---@field Segmented? KompotUiSegmentedDefaults
---@field Select? KompotUiSelectDefaults
---@field Slider? KompotUiSliderProps
---@field Tabs? KompotUiTabsDefaults
---@field Field? KompotUiFieldProps
---@field TextField? KompotUiFieldProps
---@field LabeledField? KompotUiLabeledFieldProps
---@field VectorField? KompotUiVectorFieldProps
---@field Panel? KompotUiPanelProps
---@field Window? KompotUiWindowProps
---@field Dialog? KompotUiDialogProps
---@field Menu? KompotUiMenuProps
---@field MenuItem? KompotUiMenuItemProps
---@field MenuBar? KompotUiMenuBarProps
---@field Bar? KompotUiBarProps
---@field Toast? KompotUiToastProps
---@field Card? KompotUiCardProps
---@field ListItem? KompotUiListItemProps
---@field ListRow? KompotUiListRowProps
---@field SplitPane? KompotUiSplitPaneDefaults
---@field Preview? KompotUiPreviewProps
---@field ProgressBar? KompotUiProgressProps
---@field Badge? KompotUiBadgeProps
---@field Divider? KompotUiDividerProps
---@field Hint? KompotTextProps
---@field Key? KompotUiKeyProps
---@field Section? KompotUiProps
---@field Slot? KompotUiItemSlotProps
---@field ItemSlot? KompotUiItemSlotProps
---@field Stepper? KompotUiStepperProps
---@field Tooltip? KompotUiTooltipDefaults
---@field Scrollbar? KompotUiScrollbarDefaults

---@class KompotUiTheme: KompotTheme
---@field kompot_ui true
---@field density 'compact'|'comfortable'
---@field accents table<string, KompotColor>
---@field skin table<string, KompotUiSkinInput>
---@field surfaces table<string, KompotUiSurfaceStyle>
---@field shapes table<string, KompotShapeInput>
---@field components KompotUiComponentDefaults
---@field metrics table<string, number>
---@field motion table<string, KompotAnimationSpec>
---@field ui KompotUiContract

---@class KompotUiThemeOptions
---@field accent? string|KompotColor
---@field dark? boolean
---@field density? 'compact'|'comfortable'
---@field colors? table<string, KompotColor>
---@field skin? table<'panel'|'button'|'button_pressed'|'inset', KompotUiSkinInput>
---@field surfaces? table<string, KompotUiSurfaceStyle> Роли оформления; default применяется ко всем.
---@field shapes? table<string, KompotShapeInput>
---@field components? KompotUiComponentDefaults Свойства компонентов по умолчанию.
---@field metrics? table<string, number>
---@field motion? table<string, KompotAnimationSpec>
---@field accents? table<string, KompotColor>
---@field type? table<string, KompotTextStyle>
---@field default_style? string
---@field icons? string
---@field fonts? string[]
---@field panel_alpha? number
---@field ui? table<string, function>
---@field [string] any

---@class KompotUiContract
---@field Button fun(props: KompotUiButtonProps, content?: KompotContent)
---@field IconButton fun(props: KompotUiIconButtonProps)
---@field Checkbox fun(props: KompotUiToggleProps)
---@field Switch fun(props: KompotUiToggleProps)
---@field Tabs fun(props: KompotUiTabsProps)
---@field Divider fun(props?: KompotUiDividerProps)
---@field Badge fun(props: KompotUiBadgeProps)
---@field ProgressBar fun(props: KompotUiProgressProps)
---@field Tooltip fun(props: KompotUiTooltipProps, content: KompotContent)
---@field Dialog fun(props: KompotUiDialogProps, content?: KompotContent)
---@field Scrollbar fun(props: KompotUiScrollbarProps)
---@field MenuItem fun(props: KompotUiMenuItemProps)
---@field Slider fun(props: KompotUiSliderProps)
---@field TextField fun(props: KompotUiFieldProps)
---@field Segmented fun(props: KompotUiSegmentedProps)
---@field Select fun(props: KompotUiSelectProps)
---@field Panel fun(props: KompotUiPanelProps, content: KompotContent)
---@field ListItem fun(props: KompotUiListItemProps)
---@field Menu fun(props: KompotUiMenuProps, content: KompotContent)
---@field [string] function

---@class KompotUiItem
---@field id? string
---@field name? string
---@field src? string
---@field count? number
---@field durability? number
---@field rarity? KompotColor
---@field description? string

---@class KompotUiItemSlotProps: KompotUiProps
---@field item? KompotUiItem
---@field size? number
---@field selected? boolean
---@field locked? boolean
---@field enabled? boolean
---@field keycap? string|number
---@field placeholder? string
---@field tooltip? string
---@field on_click? fun()
---@field on_right_click? fun()
---@field on_drag_event? fun(event: KompotDragEvent, item: KompotUiItem): any Возвращает переносимые данные на start.
---@field drag_button? 'left'|'right'
---@field accepts? fun(payload: any): boolean
---@field on_drop? fun(payload: any): boolean?
---@field src? string
---@field icon? string
---@field badge? string|number

---@class KompotUiInventoryProps: KompotUiProps
---@field items? table<integer, KompotUiItem>
---@field count? number
---@field columns? number
---@field size? number
---@field gap? number
---@field selected? number
---@field on_select? fun(index: number)
---@field on_right_click? fun(index: number)
---@field on_move? fun(from: number, to: number, item: KompotUiItem): boolean?
---@field accepts? fun(target: number, payload: any): boolean
---@field drag_group? any
---@field slot_props? KompotUiItemSlotProps
---@field tag_prefix? string

---@class KompotUiHotbarProps: KompotUiProps
---@field items? table<integer, KompotUiItem>
---@field count? integer
---@field size? number
---@field selected? integer
---@field show_name? boolean
---@field on_select? fun(index: integer)

---@class KompotUiResourceBarProps: KompotUiProps
---@field label? string
---@field value? number
---@field max? number
---@field kind? string
---@field color? KompotColor
---@field segments? integer
---@field height? number
---@field text? string
---@field compact? boolean

---@class KompotUiActionHintProps: KompotUiProps
---@field binding? string
---@field text? string
---@field detail? string

---@class KompotUiItemDetailsProps: KompotUiProps
---@field item? KompotUiItem
---@field width? number
---@field actions? fun(item: KompotUiItem?)

---@class KompotUiMachinePanelProps: KompotUiProps
---@field title? string
---@field width? number
---@field input? KompotUiItem
---@field output? KompotUiItem
---@field on_input? fun()
---@field on_output? fun()
---@field accepts? fun(payload: any): boolean
---@field on_drop? fun(payload: any): boolean?
---@field recipe? string
---@field progress? number
---@field energy? number
---@field max_energy? number
---@field status? string
---@field running? boolean
---@field on_start? fun()
---@field content? KompotContent

---@class KompotUiHudProps: KompotUiHotbarProps
---@field prompt? KompotUiActionHintProps
---@field health? number
---@field health_max? number
---@field energy? number
---@field energy_max? number
---@field experience? number
---@field experience_max? number

-- Остальные компоненты приходят из KompotUiContract.
---@class KompotUiApi: KompotUiContract
---@field VERSION string
---@field theme fun(opts?: KompotUiThemeOptions): KompotUiTheme
---@field Theme fun(opts: KompotUiThemeOptions, content: KompotContent)
---@field current fun(): KompotUiTheme
---@field DEFAULT KompotUiTheme
---@field PALETTE table<string, KompotColor>
---@field TYPE table<string, KompotTextStyle>
---@field METRICS table<string, number>
---@field MOTION table<string, KompotAnimationSpec>
---@field tokens table
---@field components table<string, function>
---@field ui KompotUiContract
---@field ToolButton fun(props: KompotUiIconButtonProps)
---@field Choice fun(props: KompotUiChoiceProps)
---@field Stepper fun(props: KompotUiStepperProps)
---@field Field fun(props: KompotUiFieldProps)
---@field LabeledField fun(props: KompotUiLabeledFieldProps)
---@field VectorField fun(props: KompotUiVectorFieldProps)
---@field Window fun(props: KompotUiWindowProps, content: KompotContent)
---@field MenuBar fun(props: KompotUiMenuBarProps)
---@field MenuDivider fun(props?: KompotUiProps)
---@field Bar fun(props: KompotUiBarProps)
---@field Toast fun(props: KompotUiToastProps)
---@field ListRow fun(props: KompotUiListRowProps)
---@field Slot fun(props: KompotUiItemSlotProps)
---@field ItemSlot fun(props: KompotUiItemSlotProps)
---@field InventoryGrid fun(props: KompotUiInventoryProps)
---@field Hotbar fun(props: KompotUiHotbarProps)
---@field ResourceBar fun(props: KompotUiResourceBarProps)
---@field ActionHint fun(props: KompotUiActionHintProps)
---@field ItemDetails fun(props: KompotUiItemDetailsProps)
---@field MachinePanel fun(props: KompotUiMachinePanelProps)
---@field HUD fun(props: KompotUiHudProps)
---@field Card fun(props: KompotUiCardProps, content: KompotContent)
---@field Section fun(text: string, props?: KompotUiProps)
---@field Hint fun(text: string, props?: KompotTextProps)
---@field Key fun(text: string)
---@field Preview fun(props: KompotUiPreviewProps)
---@field SplitPane fun(props: KompotUiSplitPaneProps)
---@field Lua fun(code: string|KompotUiLuaProps, props?: KompotUiLuaProps)
---@field key_chips fun(items: {[1]: string, [2]: string}[]): string
---@field open_gallery fun()
