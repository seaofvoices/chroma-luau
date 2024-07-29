-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hsi/hsi2rgb.js
local Number = require('@pkg/@jsdotlua/number')

local utils = require('../../utils')
local unpack_ = utils.unpack
local limit = utils.limit
local TWOPI = utils.TWOPI
local PITHIRD = utils.PITHIRD

local cos = math.cos

--[[
 * hue [0..360]
 * saturation [0..1]
 * intensity [0..1]
]]
local function hsi2rgb(...: any): { number }
    --[[
	borrowed from here:
	http://hummer.stanford.edu/museinfo/doc/examples/humdrum/keyscape2/hsi2rgb.cpp
	]]
    local args = unpack_(table.pack(...), 'hsi')
    local h, s, i = table.unpack(args, 1, 3)
    local r, g, b
    if Number.isNaN(h) then
        h = 0
    end
    if Number.isNaN(s) then
        s = 0
    end
    -- normalize hue
    if h > 360 then
        h -= 360
    end
    if h < 0 then
        h += 360
    end
    h /= 360
    if h < 1 / 3 then
        b = (1 - s) / 3
        r = (1 + s * cos(TWOPI * h) / cos(PITHIRD - TWOPI * h)) / 3
        g = 1 - (b + r)
    elseif h < 2 / 3 then
        h -= 1 / 3
        r = (1 - s) / 3
        g = (1 + s * cos(TWOPI * h) / cos(PITHIRD - TWOPI * h)) / 3
        b = 1 - (r + g)
    else
        h -= 2 / 3
        g = (1 - s) / 3
        b = (1 + s * cos(TWOPI * h) / cos(PITHIRD - TWOPI * h)) / 3
        r = 1 - (g + b)
    end
    r = limit(i * r * 3)
    g = limit(i * g * 3)
    b = limit(i * b * 3)
    return {
        r * 255,
        g * 255,
        b * 255,
        if #args > 3 then args[4] else 1,
    }
end

return hsi2rgb
