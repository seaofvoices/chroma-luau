-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/lch/lch2rgb.js
local unpack_ = require('../../utils').unpack
local lab2rgb = require('../lab/lab2rgb')
local lch2lab = require('./lch2lab')

local function lch2rgb(...: any): { number }
    local args = unpack_(table.pack(...), 'lch')
    local l, c, h = table.unpack(args, 1, 3)
    local L, a, b_ = table.unpack(lch2lab(l, c, h), 1, 3)
    local r, g, b = table.unpack(lab2rgb(L, a, b_), 1, 3)
    return {
        r,
        g,
        b,
        if #args > 3 then args[4] else 1,
    }
end

return lch2rgb
