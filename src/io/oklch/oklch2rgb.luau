-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/oklch/oklch2rgb.js
local unpack_ = require('../../utils').unpack
local lch2lab = require('../lch/lch2lab')
local oklab2rgb = require('../oklab/oklab2rgb')

local function oklch2rgb(...: any): { number }
    local args = unpack_(table.pack(...), 'lch')
    local l, c, h = args[1], args[2], args[3]
    -- deviation: manual unpack
    local LaB = lch2lab(l, c, h)
    local L, a, b_ = LaB[1], LaB[2], LaB[3]
    local rgb = oklab2rgb(L, a, b_)
    local r, g, b = rgb[1], rgb[2], rgb[3]
    return { r, g, b, if #args > 3 then args[4] else 1 }
end

return oklch2rgb
