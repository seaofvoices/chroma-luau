-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hcg/rgb2hcg.js
local Number = require('@pkg/@jsdotlua/number')
local unpack_ = require('../../utils').unpack

local function rgb2hcg(...: any): { number }
    local args = unpack_(table.pack(...), 'rgb')
    local r, g, b = table.unpack(args, 1, 3)
    local min = math.min(r, g, b)
    local max = math.max(r, g, b)
    local delta = max - min
    local c = delta * 100 / 255
    local _g = min / (255 - delta) * 100
    local h
    if delta == 0 then
        h = Number.NaN
    else
        if r == max then
            h = (g - b) / delta
        end
        if g == max then
            h = 2 + (b - r) / delta
        end
        if b == max then
            h = 4 + (r - g) / delta
        end
        h *= 60
        if h < 0 then
            h += 360
        end
    end
    return { h, c, _g }
end

return rgb2hcg
