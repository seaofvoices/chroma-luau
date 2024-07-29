-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/temp/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local rgb2temperature = require('./rgb2temperature')

type PrivateColor = Color.PrivateColor
type Color = Color.Color

function Color:temperature(): number
    local self: PrivateColor = self :: any
    return rgb2temperature(self._rgb)
end

Color.kelvin = Color.temperature
Color.temp = Color.kelvin

function chroma.temperature(...)
    local args = table.pack(...)
    args[args.n + 1] = 'temp' :: any
    return Color.new(unpack(args, 1, args.n + 1))
end

chroma.kelvin = chroma.temperature
chroma.temp = chroma.kelvin

input.format.temperature = require('./temperature2rgb')
input.format.kelvin = input.format.temperature
input.format.temp = input.format.kelvin

return nil
