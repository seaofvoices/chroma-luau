-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/ops/darken.js
require('../io/lab')
local Color = require('../Color')
local LAB_CONSTANTS = require('../io/lab/lab-constants')

type PrivateColor = Color.PrivateColor

function Color:darken(amount: number?)
    local me: PrivateColor = self :: any

    local lab = me:lab()
    lab[1] -= LAB_CONSTANTS.Kn * (amount or 1)
    return Color.new(lab, 'lab'):alpha(me:alpha(), true)
end

function Color:brighten(amount: number?)
    return self:darken(-(amount or 1))
end

Color.darker = Color.darken
Color.brighter = Color.brighten

return nil
