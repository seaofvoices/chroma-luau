-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/lch/lab2lch.js
local Number = require('@pkg/@jsdotlua/number')

local utils = require('../../utils')
local unpack_ = utils.unpack
local RAD2DEG = utils.RAD2DEG

local sqrt, atan2, round = math.sqrt, math.atan2, math.round

local function lab2lch(...: any): { number }
    local args = unpack_(table.pack(...), 'lab')
    local l, a, b = table.unpack(args, 1, 3)
    local c = sqrt(a * a + b * b)
    local h = (atan2(b, a) * RAD2DEG + 360) % 360
    if round(c * 10000) == 0 then
        h = Number.NaN
    end
    return { l, c, h }
end

return lab2lch
