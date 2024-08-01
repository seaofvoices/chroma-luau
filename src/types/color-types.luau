local InterpolationMode = require('./interpolation-mode')

export type InterpolationMode = InterpolationMode.InterpolationMode

export type ColorSpace =
    'cmyk'
    | 'css'
    | 'gl'
    | 'hcg'
    | 'hex'
    | 'hsi'
    | 'hsl'
    | 'hsv'
    | 'lab'
    | 'lch'
    | 'hcl'
    | 'name'
    | 'num'
    | 'oklab'
    | 'oklch'
    | 'rgb'
    | 'rgba'
    | 'temperature'
    | 'kelvin'
    | 'temp'

export type Color = {
    toString: (self: Color) -> string,
    -- cmyk
    cmyk: (self: Color) -> { number },
    -- css
    css: (self: Color, mode: string?) -> string,
    -- gl
    gl: (self: Color) -> { number },
    -- hcg
    hcg: (self: Color) -> { number },
    -- hex
    hex: (self: Color, mode: string?) -> string,
    -- hsi
    hsi: (self: Color) -> { number },
    -- hsl
    hsl: (self: Color) -> { number },
    -- hsv
    hsv: (self: Color) -> { number },
    -- lab
    lab: (self: Color) -> { number },
    -- lch
    lch: (self: Color) -> { number },
    hcl: (self: Color) -> { number },
    -- named
    name: (self: Color) -> string,
    -- num
    num: (self: Color) -> number,
    -- oklab
    oklab: (self: Color) -> { number },
    -- oklch
    oklch: (self: Color) -> { number },
    -- rgb
    rgb: (self: Color, round: boolean?) -> { number },
    rgba: (self: Color, round: boolean?) -> { number },
    -- temp
    temperature: (Color) -> number,
    kelvin: (Color) -> number,
    temp: (Color) -> number,
    -- roblox
    roblox: (Color) -> Color3,

    -- OPS
    -- alpha
    alpha: ((self: Color) -> number) & ((self: Color, a: number, mutate: boolean?) -> Color),
    -- clipped
    clipped: (self: Color) -> boolean,
    -- darken
    darken: (self: Color, amount: number?) -> Color,
    darker: (self: Color, amount: number?) -> Color,
    brighten: (self: Color, amount: number?) -> Color,
    brighter: (self: Color, amount: number?) -> Color,
    -- get
    get: (self: Color, mc: string) -> number | { number },
    -- luminance
    luminance: ((self: Color) -> number)
        & (self: Color, lum: number, mode: InterpolationMode?) -> Color,
    -- mix
    interpolate: (self: Color, color2: AsColor, amount: number?, mode: InterpolationMode?) -> Color,
    mix: (self: Color, color2: AsColor, amount: number?, mode: InterpolationMode?) -> Color,
    -- premultiply
    premultiply: (self: Color, mutate: boolean?) -> Color,
    -- saturate
    saturate: (self: Color, amount: number?) -> Color,
    desaturate: (self: Color, amount: number?) -> Color,
    -- set
    set: (self: Color, mc: any, value: any, mutate: boolean?) -> Color,
}

export type PrivateColor = Color & {
    _rgb: { [number]: number, _clipped: boolean? },
}

export type AsColor = Color | string | number | { number }

return nil
