-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/oklch/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local rgb2oklch = require('./rgb2oklch')
local utils = require('../../utils')

local unpack_ = utils.unpack

type Color = Color.Color
type PrivateColor = Color.PrivateColor

function Color:oklch(): { number }
    local self: PrivateColor = self :: any
    return rgb2oklch(self._rgb)
end

function chroma.oklch(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'oklch'
    return Color.new(unpack(args, 1, args.n + 1))
end

input.format.oklch = require('./oklch2rgb')

table.insert(input.autodetect, {
    p = 37,
    test = function(...: any): string?
        local args = unpack_(table.pack(...), 'oklch')
        -- deviation: use default type function
        if type(args) == 'table' and #args == 3 then
            return 'oklch'
        end
        return nil
    end,
})

return nil
