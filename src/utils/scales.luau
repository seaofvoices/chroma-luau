-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/utils/scales.js
-- some pre-defined color scales:
local chroma = require('../chroma')
require('../io/hsl')
local scale = require('../generator/scale')

return {
    cool = function()
        return scale({ chroma.hsl(180, 1, 0.9), chroma.hsl(250, 0.7, 0.4) })
    end,
    hot = function()
        -- deviation: remove unused parameter
        return scale({ '#000', '#f00', '#ff0', '#fff' }).mode('rgb')
    end,
}
