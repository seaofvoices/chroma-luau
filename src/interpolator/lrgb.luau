-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/interpolator/lrgb.js
local Color = require('../Color')

type Color = Color.Color
type PrivateColor = Color.PrivateColor

local sqrt, pow = math.sqrt, math.pow

local function lrgb(col1: Color, col2: Color, f: number): Color
    local x1, y1, z1 = table.unpack((col1 :: PrivateColor)._rgb, 1, 3)
    local x2, y2, z2 = table.unpack((col2 :: PrivateColor)._rgb, 1, 3)
    return Color.new(
        sqrt(pow(x1, 2) * (1 - f) + pow(x2, 2) * f),
        sqrt(pow(y1, 2) * (1 - f) + pow(y2, 2) * f),
        sqrt(pow(z1, 2) * (1 - f) + pow(z2, 2) * f),
        'rgb'
    )
end

-- register interpolator
require('./init').lrgb = lrgb

return lrgb
