-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/interpolator/oklab.js
require('../io/oklab')

local Color = require('../Color')

type Color = Color.Color

local function oklab(col1: Color, col2: Color, f: number): Color
    local xyz0 = col1:oklab()
    local xyz1 = col2:oklab()
    return Color.new(
        xyz0[1] + f * (xyz1[1] - xyz0[1]),
        xyz0[2] + f * (xyz1[2] - xyz0[2]),
        xyz0[3] + f * (xyz1[3] - xyz0[3]),
        'oklab'
    )
end

-- register interpolator
require('./init').oklab = oklab

return oklab
