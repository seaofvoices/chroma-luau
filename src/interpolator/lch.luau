-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/interpolator/lch.js
require('../io/lch')

-- deviation: require Color for types
local Color = require('../Color')
local interpolate_hsx = require('./_hsx')

type Color = Color.Color

local function lch(col1: Color, col2: Color, f: number): Color
    return interpolate_hsx(col1, col2, f, 'lch')
end

-- register interpolator
require('./init').lch = lch
require('./init').hcl = lch

return lch
