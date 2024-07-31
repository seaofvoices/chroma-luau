-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/chroma.js
local BlendTypes = require('./types/blend-types')
local Color = require('./Color')
local CubehelixTypes = require('./types/cubehelix-types')
local InterpolationMode = require('./types/interpolation-mode')
local ScaleTypes = require('./types/scale-types')
local analyze = require('./utils/analyze')

export type Color = Color.Color
export type AsColor = Color.AsColor
export type ColorMode = Color.ColorMode
type Blend = BlendTypes.Blend
export type Cubehelix = CubehelixTypes.Cubehelix
export type Scale = ScaleTypes.Scale
type AnalyzeResult = analyze.AnalyzeResult
export type InterpolationMode = InterpolationMode.InterpolationMode

type ColorTriplet<T> =
    (({ number } | T) -> Color)
    & ((number, number, number) -> Color)
    & ((number, number, number, number) -> Color)

export type Chroma = ((...any) -> Color) & {
    version: string,
    Color: typeof(Color),

    -- cmyk
    cmyk: ColorTriplet<{ c: number, m: number, y: number, k: number }>,
    -- css
    css: (string) -> Color,
    -- gl
    gl: ColorTriplet<{ r: number, g: number, b: number }>,
    -- hcg
    hcg: ColorTriplet<{ h: number, c: number, g: number }>,

    -- hex
    hex: (string) -> Color,
    -- hsi
    hsi: ColorTriplet<{ h: number, s: number, i: number }>,
    -- hsl
    hsl: ColorTriplet<{ h: number, s: number, l: number }>,
    -- hsv
    hsv: ColorTriplet<{ h: number, s: number, v: number }>,
    -- lab
    lab: ColorTriplet<{ l: number, a: number, b: number }>,
    -- lch
    lch: ColorTriplet<{ l: number, c: number, h: number }>,
    hcl: ColorTriplet<{ h: number, c: number, l: number }>,
    -- named
    -- num
    num: (number) -> Color,
    -- oklab
    oklab: ColorTriplet<{ l: number, a: number, b: number }>,
    -- oklch
    oklch: ColorTriplet<{ l: number, c: number, h: number }>,
    -- rgb
    rgb: ColorTriplet<{ r: number, g: number, b: number }>,
    -- temp
    temperature: (number) -> Color,
    kelvin: (number) -> Color,
    temp: (number) -> Color,
    -- roblox Color3
    roblox: (Color3, opacity: number?) -> Color,

    -- generators -- > create new colors
    average: (colors: { AsColor }, mode: string?, weights: { number }?) -> Color,
    bezier: (colors: { AsColor }) -> ((number) -> Color) & { scale: Scale },
    blend: Blend,
    cubehelix: (
        start: number?,
        rotations: number?,
        hue: number | { number }?,
        gamma: number?,
        lightness: number | { number }?
    ) -> Cubehelix,
    mix: (col1: AsColor, col2: AsColor, f: number?, mode: InterpolationMode?) -> Color,
    interpolate: (col1: AsColor, col2: AsColor, f: number?, mode: InterpolationMode?) -> Color,
    random: () -> Color,
    scale: (colors: string | { AsColor }?) -> Scale,

    -- other utility methods
    analyze: (data: { number? }, key: string?) -> AnalyzeResult,
    contrast: (AsColor, AsColor) -> number,
    deltaE: (AsColor, AsColor, number?, number?, number?) -> number,
    distance: (AsColor, AsColor, mode: string?) -> number,
    limits: (data: { number? } | AnalyzeResult, mode_: string?, num_: number?) -> { number },
    valid: (...any) -> boolean,

    -- scale
    scales: {
        cool: () -> Scale,
        hot: () -> Scale,
    },

    -- colors
    colors: typeof(require('./colors/w3cx11')),
    brewer: typeof(require('./colors/colorbrewer')),
}

local chromaMetatable = {
    __call = function(self, ...: any)
        return self.Color.new(...)
    end,
}
local chroma = setmetatable({}, chromaMetatable)

chroma.Color = Color
chroma.version = '2.4.2'

return chroma :: Chroma
