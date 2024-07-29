-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hsi/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local rgb2hsi = require('./rgb2hsi')
local utils = require('../../utils')

local unpack_ = utils.unpack

type Color = Color.Color
type PrivateColor = Color.PrivateColor

function Color:hsi(): { number }
    local self: PrivateColor = self :: any
    return rgb2hsi(self._rgb)
end

function chroma.hsi(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'hsi'
    return Color.new(unpack(args, 1, args.n + 1))
end

input.format.hsi = require('./hsi2rgb')

table.insert(input.autodetect, {
    p = 28,
    test = function(...: any)
        local args = unpack_(table.pack(...), 'hsi')
        -- deviation: use default type function
        if type(args) == 'table' and #args == 3 then
            return 'hsi'
        end
        return nil
    end,
})

return nil
