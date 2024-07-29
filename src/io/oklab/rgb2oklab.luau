-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/oklab/rgb2oklab.js
local unpack_ = require('../../utils').unpack

local function cbrt(value: number): number
    return value ^ (1 / 3)
end
local pow, sign = math.pow, math.sign

-- deviation: pre-declare variables
local rgb2lrgb

local function rgb2oklab(...: any)
    local args = unpack_(table.pack(...), 'rgb')
    -- OKLab color space implementation taken from
    -- https://bottosson.github.io/posts/oklab/
    local r, g, b = table.unpack(args, 1, 3)
    local lr, lg, lb =
        table.unpack({ rgb2lrgb(r / 255), rgb2lrgb(g / 255), rgb2lrgb(b / 255) }, 1, 3)
    local l = cbrt(0.4122214708 * lr + 0.5363325363 * lg + 0.0514459929 * lb)
    local m = cbrt(0.2119034982 * lr + 0.6806995451 * lg + 0.1073969566 * lb)
    local s = cbrt(0.0883024619 * lr + 0.2817188376 * lg + 0.6299787005 * lb)

    return {
        0.2104542553 * l + 0.793617785 * m - 0.0040720468 * s,
        1.9779984951 * l - 2.428592205 * m + 0.4505937099 * s,
        0.0259040371 * l + 0.7827717662 * m - 0.808675766 * s,
    }
end

function rgb2lrgb(c)
    local abs = math.abs(c)
    if abs < 0.04045 then
        return c / 12.92
    end
    local cSign = sign(c)
    cSign = if cSign == 0 then 1 else cSign
    return cSign * pow((abs + 0.055) / 1.055, 2.4)
end

return rgb2oklab
