-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hsi/rgb2hsi.js
local Number = require('@pkg/@jsdotlua/number')

local utils = require('../../utils')
local unpack_ = utils.unpack
local TWOPI = utils.TWOPI

local min, sqrt, acos = math.min, math.sqrt, math.acos

local function rgb2hsi(...: any): { number }
    --[[
	borrowed from here:
	http://hummer.stanford.edu/museinfo/doc/examples/humdrum/keyscape2/rgb2hsi.cpp
	]]
    local args = unpack_(table.pack(...), 'rgb')
    local r, g, b = table.unpack(args, 1, 3)
    r /= 255
    g /= 255
    b /= 255
    local h
    local min_ = min(r, g, b)
    local i = (r + g + b) / 3
    local s = if i > 0 then 1 - min_ / i else 0
    if s == 0 then
        h = Number.NaN
    else
        h = (r - g + (r - b)) / 2
        h /= sqrt((r - g) * (r - g) + (r - b) * (g - b))
        h = acos(h)
        if b > g then
            h = TWOPI - h
        end
        h /= TWOPI
    end
    return { h * 360, s, i }
end

return rgb2hsi
