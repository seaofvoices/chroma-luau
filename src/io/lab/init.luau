-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/lab/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local rgb2lab = require('./rgb2lab')
local utils = require('../../utils')

type Color = Color.Color
type PrivateColor = Color.PrivateColor

local unpack_ = utils.unpack

function Color:lab(): { number }
    local self: PrivateColor = self :: any
    return rgb2lab(self._rgb)
end

function chroma.lab(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'lab'
    return Color.new(unpack(args, 1, args.n + 1))
end

input.format.lab = require('./lab2rgb')

table.insert(input.autodetect, {
    p = 25,
    test = function(...: any): string?
        local args = unpack_(table.pack(...), 'lab')
        -- deviation: use default type function
        if type(args) == 'table' and #args == 3 then
            return 'lab'
        end
        return nil
    end,
})

return nil
