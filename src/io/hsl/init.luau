-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hsl/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local rgb2hsl = require('./rgb2hsl')
local utils = require('../../utils')

local unpack_ = utils.unpack

type Color = Color.Color
type PrivateColor = Color.PrivateColor

function Color:hsl(): { number }
    local self: PrivateColor = self :: any
    return rgb2hsl(self._rgb)
end

function chroma.hsl(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'hsl'
    return Color.new(unpack(args, 1, args.n + 1))
end

input.format.hsl = require('./hsl2rgb')

table.insert(input.autodetect, {
    p = 27,
    test = function(...: any)
        local args = unpack_(table.pack(...), 'hsl')
        -- deviation: use default type function
        if type(args) == 'table' and #args == 3 then
            return 'hsl'
        end
        return nil
    end,
})

return nil
