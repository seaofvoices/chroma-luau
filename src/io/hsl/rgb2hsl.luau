-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hsl/rgb2hsl.js
local Number = require('@pkg/@jsdotlua/number')

local unpack_ = require('../../utils').unpack

--[[
 * supported arguments:
 * - rgb2hsl(r,g,b)
 * - rgb2hsl(r,g,b,a)
 * - rgb2hsl([r,g,b])
 * - rgb2hsl([r,g,b,a])
 * - rgb2hsl({r,g,b,a})
]]
local function rgb2hsl(...: any)
    local args = unpack_(table.pack(...), 'rgba')
    local r, g, b = table.unpack(args, 1, 3)

    r /= 255
    g /= 255
    b /= 255

    local min = math.min(r, g, b)
    local max = math.max(r, g, b)

    local l = (max + min) / 2
    local s, h

    if max == min then
        s = 0
        h = Number.NaN
    else
        s = if l < 0.5 then (max - min) / (max + min) else (max - min) / (2 - max - min)
    end

    if r == max then
        h = (g - b) / (max - min)
    elseif g == max then
        h = 2 + (b - r) / (max - min)
    elseif b == max then
        h = 4 + (r - g) / (max - min)
    end

    h *= 60
    if h < 0 then
        h += 360
    end
    if #args > 3 and args[4] ~= nil then
        return {
            h,
            s,
            l,
            args[4],
        }
    end
    return { h, s, l }
end

return rgb2hsl
