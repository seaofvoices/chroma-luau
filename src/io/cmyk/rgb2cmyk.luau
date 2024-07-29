-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/cmyk/rgb2cmyk.js
local unpack_ = require('../../utils').unpack

local max = math.max

local function rgb2cmyk(...: any): { number }
    local args = unpack_(table.pack(...), 'rgb')
    local r, g, b = table.unpack(args, 1, 3)
    r = r / 255
    g = g / 255
    b = b / 255
    local k = 1 - max(r, max(g, b))
    local f = if k < 1 then 1 / (1 - k) else 0
    local c = (1 - r - k) * f
    local m = (1 - g - k) * f
    local y = (1 - b - k) * f
    return { c, m, y, k }
end

return rgb2cmyk
