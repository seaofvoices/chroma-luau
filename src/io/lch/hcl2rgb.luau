-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/lch/hcl2rgb.js
local Collections = require('@pkg/@jsdotlua/collections')
local Array = Collections.Array
local unpack_ = require('../../utils').unpack
local lch2rgb = require('./lch2rgb')

local function hcl2rgb(...: any)
    local args = { ... }
    local hcl = Array.reverse(unpack_(table.pack(args), 'hcl'))
    return lch2rgb(unpack(hcl))
end

return hcl2rgb
