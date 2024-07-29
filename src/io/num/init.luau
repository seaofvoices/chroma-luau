-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/num/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local rgb2num = require('./rgb2num')

type Color = Color.Color
type PrivateColor = Color.PrivateColor

function Color:num(): number
    local self: PrivateColor = self :: any
    return rgb2num(self._rgb)
end

function chroma.num(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'num'
    return Color.new(unpack(args, 1, args.n + 1))
end

input.format.num = require('./num2rgb')

table.insert(input.autodetect, {
    p = 57,
    test = function(...: any): string?
        local args = table.pack(...)
        -- deviation: use default type function
        if args.n == 1 and type(args[1]) == 'number' and args[1] >= 0 and args[1] <= 0xFFFFFF then
            return 'num'
        end
        return nil
    end,
})

return nil
