-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/ops/premultiply.js
local Color = require('../Color')

type Color = Color.Color
type PrivateColor = Color.PrivateColor

function Color:premultiply(mutate: boolean?): Color
    local self: PrivateColor = self :: any

    local rgb = self._rgb
    local a = rgb[4]

    if mutate then
        self._rgb = { rgb[1] * a, rgb[2] * a, rgb[3] * a, a }
        return self
    else
        return Color.new({ rgb[1] * a, rgb[2] * a, rgb[3] * a, a }, 'rgb')
    end
end

return nil
