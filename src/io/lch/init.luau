-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/lch/index.js
local Collections = require('@pkg/@jsdotlua/collections')

local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local rgb2lch = require('./rgb2lch')
local utils = require('../../utils')

local Array = Collections.Array
local unpack_ = utils.unpack

type Color = Color.Color
type PrivateColor = Color.PrivateColor

function Color:lch(): { number }
    local self: PrivateColor = self :: any
    return rgb2lch(self._rgb)
end

function Color:hcl(): { number }
    local self: PrivateColor = self :: any
    return Array.reverse(rgb2lch(self._rgb))
end

function chroma.lch(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'lch'
    return Color.new(unpack(args, 1, args.n + 1))
end

function chroma.hcl(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'hcl'
    return Color.new(unpack(args, 1, args.n + 1))
end

input.format.lch = require('./lch2rgb')
input.format.hcl = require('./hcl2rgb')

for _, m in { 'lch', 'hcl' } do
    table.insert(input.autodetect, {
        p = 24,
        test = function(...: any)
            local args = unpack_(table.pack(...), m)
            -- deviation: use default type function
            if type(args) == 'table' and #args == 3 then
                return m
            end
            return nil
        end,
    })
end

return nil
