-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/cmyk/cmyk2rgb.js
local unpack_ = require('../../utils').unpack

local function cmyk2rgb(...: any)
    local args = unpack_(table.pack(...), 'cmyk')
    local c, m, y, k = table.unpack(args, 1, 4)
    local alpha = if #args > 4 then args[5] else 1
    if k == 1 then
        return { 0, 0, 0, alpha }
    end
    return {
        if c >= 1 then 0 else 255 * (1 - c) * (1 - k), -- r
        if m >= 1 then 0 else 255 * (1 - m) * (1 - k), -- g
        if y >= 1 then 0 else 255 * (1 - y) * (1 - k), -- b
        alpha,
    }
end

return cmyk2rgb
