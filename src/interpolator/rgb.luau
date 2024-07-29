-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/interpolator/rgb.js
local Color = require('../Color')

type Color = Color.Color
type PrivateColor = Color.PrivateColor

local function rgb(col1: Color, col2: Color, f: number): Color
    local xyz0 = (col1 :: PrivateColor)._rgb
    local xyz1 = (col2 :: PrivateColor)._rgb

    return Color.new(
        xyz0[1] + f * (xyz1[1] - xyz0[1]),
        xyz0[2] + f * (xyz1[2] - xyz0[2]),
        xyz0[3] + f * (xyz1[3] - xyz0[3]),
        'rgb'
    )
end

-- register interpolator
require('./init').rgb = rgb

return rgb
