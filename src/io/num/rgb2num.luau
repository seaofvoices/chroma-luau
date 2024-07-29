-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/num/rgb2num.js

local unpack_ = require('../../utils').unpack

local function rgb2num(...: any)
    local args = unpack_(table.pack(...), 'rgb')
    local r, g, b = table.unpack(args, 1, 3)
    return bit32.lshift(r, 16) + bit32.lshift(g, 8) + b
end

return rgb2num
