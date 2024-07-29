-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/oklab/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local rgb2oklab = require('./rgb2oklab')
local utils = require('../../utils')

local unpack_ = utils.unpack

type Color = Color.Color
type PrivateColor = Color.PrivateColor

function Color:oklab(): { number }
    local self: PrivateColor = self :: any
    return rgb2oklab(self._rgb)
end

function chroma.oklab(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'oklab'
    return Color.new(unpack(args, 1, args.n + 1))
end

input.format.oklab = require('./oklab2rgb')

table.insert(input.autodetect, {
    p = 38,
    test = function(...: any)
        local args = unpack_(table.pack(...), 'oklab')
        -- deviation: use default type function
        if type(args) == 'table' and #args == 3 then
            return 'oklab'
        end
        return nil
    end,
})

return nil
