-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/lch/rgb2lch.js
local unpack_ = require('../../utils').unpack
local lab2lch = require('./lab2lch')
local rgb2lab = require('../lab/rgb2lab')

local function rgb2lch(...: any)
    local args = unpack_(table.pack(...), 'rgb')
    local r, g, b = table.unpack(args, 1, 3)
    local l, a, b_ = table.unpack(rgb2lab(r, g, b), 1, 3)
    return lab2lch(l, a, b_)
end

return rgb2lch
