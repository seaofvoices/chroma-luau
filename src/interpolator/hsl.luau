-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/interpolator/hsl.js
require('../io/hsl')

-- deviation: require Color for types
local Color = require('../Color')
local interpolate_hsx = require('./_hsx')

type Color = Color.Color

local function hsl(col1: Color, col2: Color, f: number): Color
    return interpolate_hsx(col1, col2, f, 'hsl')
end

-- register interpolator
require('./init').hsl = hsl

return hsl
