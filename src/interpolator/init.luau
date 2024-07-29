-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/interpolator/index.js

-- deviation: require Color for types
local Color = require('../Color')

type Color = Color.Color

export type Interpolators = {
    hcg: (col1: Color, col2: Color, f: number) -> Color,
    hsi: (col1: Color, col2: Color, f: number) -> Color,
    hsl: (col1: Color, col2: Color, f: number) -> Color,
    hsv: (col1: Color, col2: Color, f: number) -> Color,
    lab: (col1: Color, col2: Color, f: number) -> Color,
    lch: (col1: Color, col2: Color, f: number) -> Color,
    hcl: (col1: Color, col2: Color, f: number) -> Color,
    lrgb: (col1: Color, col2: Color, f: number) -> Color,
    num: (col1: Color, col2: Color, f: number) -> Color,
    oklab: (col1: Color, col2: Color, f: number) -> Color,
    oklch: (col1: Color, col2: Color, f: number) -> Color,
    rgb: (col1: Color, col2: Color, f: number) -> Color,
}

return {} :: Interpolators
