-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/utils/clip_rgb.js

local limit = require('./limit')

local function clip_rgb(rgb: { [number]: number, _clipped: boolean?, _unclipped: { number }? })
    rgb._clipped = false
    -- deviation: replace Array.slice(rgb, 0) with manual unpack
    rgb._unclipped = { rgb[1], rgb[2], rgb[3], rgb[4] }

    -- deviation: simplify for loop
    for i = 1, 3 do
        if rgb[i] < 0 or rgb[i] > 255 then
            rgb._clipped = true
        end
        rgb[i] = limit(rgb[i], 0, 255)
    end
    rgb[4] = limit(rgb[4], 0, 1)
    return rgb
end

return clip_rgb
