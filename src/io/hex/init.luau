-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hex/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local rgb2hex = require('./rgb2hex')

type PrivateColor = Color.PrivateColor
type Color = Color.Color

function Color:hex(mode: string?)
    local self: PrivateColor = self :: any
    return rgb2hex(self._rgb, mode)
end

function chroma.hex(...: any)
    local args = table.pack(...)
    args[args.n + 1] = 'hex'
    return Color.new(unpack(args, 1, args.n + 1))
end

input.format.hex = require('./hex2rgb')

table.insert(input.autodetect, {
    p = 49,
    test = function(h, ...: any)
        local rest = table.pack(...)
        -- deviation: use default type function
        if rest.n == 0 and type(h) == 'string' and #h >= 3 and #h <= 9 then
            return 'hex'
        end
        return nil
    end,
})

return nil
