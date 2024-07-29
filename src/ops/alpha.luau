-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/ops/alpha.js
local Color = require('../Color')

type PrivateColor = Color.PrivateColor

function Color:alpha(a: number?, mutate: boolean?): any
    local self: PrivateColor = self :: any

    if type(a) == 'number' then
        if mutate then
            self._rgb[4] = a
            return self
        end
        return Color.new({
            self._rgb[1],
            self._rgb[2],
            self._rgb[3],
            a,
        }, 'rgb')
    end
    return self._rgb[4]
end

return nil
