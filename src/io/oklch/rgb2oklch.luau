-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/oklch/rgb2oklch.js
local unpack_ = require('../../utils').unpack
local lab2lch = require('../lch/lab2lch')
local rgb2oklab = require('../oklab/rgb2oklab')

local function rgb2oklch(...: any): { number }
    local rgb = unpack_(table.pack(...), 'rgb')
    local r, g, b = rgb[1], rgb[2], rgb[3]
    local lab = rgb2oklab(r, g, b)
    local l, a, b_ = lab[1], lab[2], lab[3]
    return lab2lch(l, a, b_)
end

return rgb2oklch
