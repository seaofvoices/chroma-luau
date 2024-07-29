-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/ops/saturate.js
require('../io/lch')
local Color = require('../Color')
local LAB_CONSTANTS = require('../io/lab/lab-constants')

type Color = Color.Color
type PrivateColor = Color.PrivateColor

function Color:saturate(amount: number?): Color
    local me: PrivateColor = self :: any

    local lch = me:lch()
    lch[2] += LAB_CONSTANTS.Kn * (amount or 1)
    if lch[2] < 0 then
        lch[2] = 0
    end

    return Color.new(lch, 'lch'):alpha(me:alpha(), true)
end

function Color:desaturate(amount: number?)
    return self:saturate(-(amount or 1))
end

return nil
