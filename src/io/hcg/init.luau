-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hcg/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local rgb2hcg = require('./rgb2hcg')
local utils = require('../../utils')

local unpack_ = utils.unpack

type Color = Color.Color
type PrivateColor = Color.PrivateColor

function Color:hcg(): { number }
    local self: PrivateColor = self :: any
    return rgb2hcg(self._rgb)
end

function chroma.hcg(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'hcg'
    return Color.new(unpack(args, 1, args.n + 1))
end

input.format.hcg = require('./hcg2rgb')

table.insert(input.autodetect, {
    p = 19,
    test = function(...: any): string?
        local args = unpack_(table.pack(...), 'hcg')
        -- deviation: use default type function
        if type(args) == 'table' and #args == 3 then
            return 'hcg'
        end
        return nil
    end,
})

return nil
