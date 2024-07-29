-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hsv/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local rgb2hsv = require('./rgb2hsv')
local utils = require('../../utils')

local unpack_ = utils.unpack

type Color = Color.Color
type PrivateColor = Color.PrivateColor

function Color:hsv(): { number }
    local self: PrivateColor = self :: any
    return rgb2hsv(self._rgb)
end

function chroma.hsv(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'hsv'
    return Color.new(unpack(args, 1, args.n + 1))
end

input.format.hsv = require('./hsv2rgb')

table.insert(input.autodetect, {
    p = 26,
    test = function(...: any)
        local args = unpack_(table.pack(...), 'hsv')
        -- deviation: use default type function
        if type(args) == 'table' and #args == 3 then
            return 'hsv'
        end
        return nil
    end,
})

return nil
