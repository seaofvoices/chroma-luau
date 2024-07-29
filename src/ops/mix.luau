-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/ops/mix.js
local Color = require('../Color')
local InterpolationMode = require('../types/interpolation-mode')
local mix = require('../generator/mix')

type Color = Color.Color
type AsColor = Color.AsColor
type InterpolationMode = InterpolationMode.InterpolationMode

function Color:interpolate(col2: AsColor, f: number?, mode: InterpolationMode?): Color
    return mix(self, col2, f or 0.5, mode)
end

Color.mix = Color.interpolate

return nil
