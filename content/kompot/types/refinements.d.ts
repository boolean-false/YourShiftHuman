// Уточнения TypeScript поверх общих аннотаций. Во время исполнения не загружаются.
import type * as C from "./contracts";

export interface KompotInputEvent {
    x?: number;
    y?: number;
    down?: boolean;
    rdown?: boolean;
    wheel?: number;
    inside?: boolean;
    key?: string;
    shift?: boolean;
    cancel?: boolean;
}

/** Размеры и время текущей композиции. */
export interface KompotRuntime {
    readonly width: number;
    readonly height: number;
    readonly time: number;
    readonly measurer: C.KompotTextMeasurer;
    readonly app: C.KompotAppInstance;
    readonly errors: string[];
    request_frame(this: KompotRuntime): void;
    invalidate(this: KompotRuntime): void;
    invalidate_layout(this: KompotRuntime): void;
}

export interface KompotFontEntry {
    name: string;
    file: string;
    size: number;
    weight?: string;
}

export interface KompotFontInfo extends KompotFontEntry {
    weight: string;
    family: string;
    absolute: boolean;
    measured: boolean;
}

export interface KompotTypographyOptions {
    family?: string;
    mono_family?: string;
}

export type KompotUiComponents = Omit<C.KompotUiApi,
    "VERSION" | "theme" | "Theme" | "current" | "DEFAULT" | "PALETTE" | "TYPE" |
    "METRICS" | "MOTION" | "tokens" | "components" | "ui" | "open_gallery" |
    "TextField" | "Segmented" | "ListItem">;

export interface KompotUiTokens {
    PALETTE: C.KompotUiApi["PALETTE"];
    TYPE: C.KompotUiApi["TYPE"];
    METRICS: C.KompotUiApi["METRICS"];
    COMPACT_METRICS: C.KompotUiApi["METRICS"];
    MOTION: C.KompotUiApi["MOTION"];
    DEFAULT: C.KompotUiTheme;
    ui: C.KompotUiContract;
    theme(this: void, opts?: C.KompotUiThemeOptions, base?: C.KompotUiTheme): C.KompotUiTheme;
    current(this: void): C.KompotUiTheme;
    props<N extends keyof C.KompotUiComponentDefaults>(this: void, name: N, props?: C.KompotUiComponentDefaults[N]): NonNullable<C.KompotUiComponentDefaults[N]>;
    props<T extends object>(this: void, name: string, props?: T): T;
    extend_surface(this: void, base: C.KompotUiSurfaceStyle, patch: C.KompotUiSurfaceStyle): C.KompotUiSurfaceStyle;
}

/** Прямые импорты сохранены для проектов, использовавших прежние декларации. */
export interface KompotScrollApi {
    new_scroll(this: void, initial?: number): C.KompotScrollState;
    new_lazy(this: void): C.KompotLazyState;
}

export interface KompotInventoryLease {
    readonly held: boolean;
    readonly seen: number;
    touch(this: KompotInventoryLease): void;
    set(this: KompotInventoryLease, block: boolean): void;
}

export interface KompotInventoryLockApi {
    new: (this: void) => KompotInventoryLease;
    watch(this: void): void;
    release_all(this: void): void;
    count(this: void): number;
}

/** Варианты владения текстом взаимоисключающие, как и в Lua API. */
export type KompotFieldInput =
    | {state: C.KompotState<string>; value?: never; editor_state?: never; editor_value?: never}
    | {editor_state: C.KompotState<C.KompotEditorValue>; state?: never; value?: never; editor_value?: never}
    | {editor_value: C.KompotEditorValue; state?: never; value?: never; editor_state?: never}
    | {value?: string; state?: never; editor_state?: never; editor_value?: never};

export type KompotVisibility =
    | {visible_state: C.KompotTransitionState<boolean>; visible?: never}
    | {visible?: boolean; visible_state?: never};

export type KompotExpansion =
    | {expanded_state: C.KompotTransitionState<boolean>; expanded?: never}
    | {expanded?: boolean; expanded_state?: never};

export type KompotOptionValue<T> = T extends string ? string : T extends number ? number : T extends boolean ? boolean : T;

export type KompotValueOption<T> = Omit<C.KompotUiOption, "value"> & {value: T};

export type KompotSelectProps<T = unknown> = Omit<C.KompotUiSelectProps, "options" | "selected" | "on_select"> & {
    options: (KompotValueOption<T> | [T, string] | Extract<T, string>)[];
    selected?: KompotOptionValue<NoInfer<T>>;
    on_select?: (this: void, value: T) => void;
};

export type KompotChoiceProps<T = unknown> = Omit<C.KompotUiChoiceProps, "options" | "selected" | "on_select"> & {
    options: (KompotValueOption<T> | [T, string] | Extract<T, string>)[];
    selected?: KompotOptionValue<NoInfer<T>>;
    on_select?: (this: void, value: T) => void;
};


/** Тема сливается рекурсивно; функции и массивы заменяются целиком. */
export type KompotThemePatch<T> = T extends C.KompotCallable ? T : T extends unknown[] ? T : T extends object ? {
    [P in keyof T]?: KompotThemePatch<T[P]>;
} : T;
