-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/cmyk/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local rgb2cmyk = require('./rgb2cmyk')
local utils = require('../../utils')

local unpack_ = utils.unpack

type Color = Color.Color
type PrivateColor = Color.PrivateColor

function Color:cmyk(): { number }
    local self: PrivateColor = self :: any

    return rgb2cmyk(self._rgb)
end

function chroma.cmyk(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'cmyk'
    return Color.new(unpack(args, 1, args.n + 1))
end

input.format.cmyk = require('./cmyk2rgb')

table.insert(input.autodetect, {
    p = 29,
    test = function(...: any)
        local args = unpack_(table.pack(...), 'cmyk')

        -- deviation: use default type function
        if type(args) == 'table' and #args == 3 then
            return 'cmyk'
        end
        return nil
    end,
})

return nil
