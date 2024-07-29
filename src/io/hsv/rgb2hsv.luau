-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hsv/rgb2hsv.js

local Number = require('@pkg/@jsdotlua/number')
local unpack_ = require('../../utils').unpack

local min, max = math.min, math.max

--[[
 * supported arguments:
 * - rgb2hsv(r,g,b)
 * - rgb2hsv([r,g,b])
 * - rgb2hsv({r,g,b})
]]
local function rgb2hsl(...: any): { number }
    local args = unpack_(table.pack(...), 'rgb')
    local r, g, b = table.unpack(args, 1, 3)
    local min_ = min(r, g, b)
    local max_ = max(r, g, b)
    local delta = max_ - min_
    local h, s, v
    v = max_ / 255.0

    if max_ == 0 then
        h = Number.NaN
        s = 0
    else
        s = delta / max_
        if r == max_ then
            h = (g - b) / delta
        end
        if g == max_ then
            h = 2 + (b - r) / delta
        end
        if b == max_ then
            h = 4 + (r - g) / delta
        end
        h *= 60
        if h < 0 then
            h += 360
        end
    end
    return { h, s, v }
end

return rgb2hsl
