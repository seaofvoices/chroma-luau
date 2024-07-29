-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/named/index.js
local Color = require('../../Color')
local hex2rgb = require('../hex/hex2rgb')
local input = require('../input')
local rgb2hex = require('../hex/rgb2hex')
local w3cx11 = require('../../colors/w3cx11')

type Color = Color.Color
type PrivateColor = Color.PrivateColor

function Color:name(): string
    local self: PrivateColor = self :: any

    local hex = rgb2hex(self._rgb, 'rgb')
    for n, value in w3cx11 :: { [string]: string } do
        if value == hex then
            return string.lower(n)
        end
    end

    return hex
end

input.format.named = function(name: string): { number }
    name = string.lower(name)
    if w3cx11[name] then
        return hex2rgb(w3cx11[name])
    end
    error(`unknown color name: {name}`)
end

table.insert(input.autodetect, {
    p = 58,
    test = function(h, ...: any)
        -- deviation: use default type function
        if select('#', ...) == 0 and type(h) == 'string' and w3cx11[string.lower(h)] then
            return 'named'
        end
        return nil
    end,
})

return nil
