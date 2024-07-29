-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/gl/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local unpack_ = require('../../utils').unpack

type Color = Color.Color
type PrivateColor = Color.PrivateColor

input.format.gl = function(...: any)
    local rgb = unpack_(table.pack(...), 'rgba')
    rgb[1] *= 255
    rgb[2] *= 255
    rgb[3] *= 255
    return rgb
end

function chroma.gl(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'gl'
    return Color.new(unpack(args, 1, args.n + 1))
end

function Color:gl(): { number }
    local self: PrivateColor = self :: any
    local rgb = self._rgb
    return { rgb[1] / 255, rgb[2] / 255, rgb[3] / 255, rgb[4] }
end

return nil
