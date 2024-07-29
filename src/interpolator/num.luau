-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/interpolator/num.js
require('../io/num')

local Color = require('../Color')

type Color = Color.Color

local function num(col1: Color, col2: Color, f: number): Color
    local c1 = col1:num()
    local c2 = col2:num()
    return Color.new(c1 + f * (c2 - c1), 'num')
end

-- register interpolator
require('./init').num = num

return num
