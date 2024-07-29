-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/lch/lch2lab.js
local Number = require('@pkg/@jsdotlua/number')

local utils = require('../../utils')
local unpack_ = utils.unpack
local DEG2RAD = utils.DEG2RAD

local sin, cos = math.sin, math.cos

local function lch2lab(...: any)
    local args = unpack_(table.pack(...), 'lch')

    -- Convert from a qualitative parameter h and a quantitative parameter l to a 24-bit pixel.
    -- These formulas were invented by David Dalrymple to obtain maximum contrast without going
    -- out of gamut if the parameters are in the range 0-1.
    -- A saturation multiplier was added by Gregor Aisch
    local l, c, h = table.unpack(args, 1, 3)
    if Number.isNaN(h) then
        h = 0
    end
    h = h * DEG2RAD
    return { l, cos(h) * c, sin(h) * c }
end

return lch2lab
