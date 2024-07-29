-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/interpolator/lab.js
require('../io/lab')

local Color = require('../Color')

type Color = Color.Color

local function lab(col1: Color, col2: Color, f: number): Color
    local xyz0 = col1:lab()
    local xyz1 = col2:lab()

    return Color.new(
        xyz0[1] + f * (xyz1[1] - xyz0[1]),
        xyz0[2] + f * (xyz1[2] - xyz0[2]),
        xyz0[3] + f * (xyz1[3] - xyz0[3]),
        'lab'
    )
end

-- register interpolator
require('./init').lab = lab

return lab
