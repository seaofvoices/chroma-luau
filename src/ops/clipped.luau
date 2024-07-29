-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/ops/clipped.js
local Color = require('../Color')

type PrivateColor = Color.PrivateColor

function Color:clipped(): boolean
    local self: PrivateColor = self :: any

    return self._rgb._clipped == true
end

return nil
