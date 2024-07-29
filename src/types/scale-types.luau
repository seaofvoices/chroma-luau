local ColorTypes = require('./color-types')

local InterpolationMode = require('./interpolation-mode')

type Color = ColorTypes.Color
type AsColor = ColorTypes.AsColor
type ColorMode = ColorTypes.ColorMode
export type InterpolationMode = InterpolationMode.InterpolationMode

type ScaleFn<T> = (number?) -> T

export type ScaleBase<T, E> = ScaleFn<T> & E & {
    classes: (() -> { number }) & ((number | { number }) -> ScaleBase<T, E>),
    domain: (() -> { number }) & (({ number }) -> ScaleBase<T, E>),
    mode: (() -> InterpolationMode) & ((InterpolationMode) -> ScaleBase<T, E>),
    range: ({ AsColor }) -> ScaleBase<T, E>,
    spread: (() -> number) & ((number) -> ScaleBase<T, E>),
    correctLightness: (boolean?) -> ScaleBase<T, E>,
    padding: (() -> { number }) & ((number | { number }) -> ScaleBase<T, E>),
    colors: (() -> { AsColor }) & ((number) -> { string }) & ((number, string?) -> { AsColor }),
    cache: (() -> boolean) & ((boolean) -> ScaleBase<T, E>),
    gamma: (() -> number) & ((number) -> ScaleBase<T, E>),
    nodata: (() -> Color) & ((AsColor) -> ScaleBase<T, E>),
}

type ScaleExtension = {
    out: (('num' | 'temperature' | 'kelvin' | 'temp') -> ScaleBase<number, ScaleExtension>)
        & (('css' | 'hex' | 'name') -> ScaleBase<string, ScaleExtension>)
        & ((
            'cmyk'
                | 'gl'
                | 'hcg'
                | 'hsi'
                | 'hsl'
                | 'hsv'
                | 'lab'
                | 'lch'
                | 'hcl'
                | 'oklab'
                | 'oklch'
                | 'rgb'
                | 'rgba'
        ) -> ScaleBase<{ number }, ScaleExtension>),
}

export type Scale = ScaleBase<Color, ScaleExtension>

return nil
