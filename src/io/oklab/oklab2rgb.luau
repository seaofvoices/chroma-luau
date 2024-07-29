-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/oklab/oklab2rgb.js
local unpack_ = require('../../utils').unpack
local pow, sign = math.pow, math.sign

-- deviation: pre-declare variables
local lrgb2rgb

--[[
 * L* [0..100]
 * a [-100..100]
 * b [-100..100]
]]
local function oklab2rgb(...: any): { number }
    local args = unpack_(table.pack(...), 'lab')
    local L, a, b = table.unpack(args, 1, 3)

    local l = pow(L + 0.3963377774 * a + 0.2158037573 * b, 3)
    local m = pow(L - 0.1055613458 * a - 0.0638541728 * b, 3)
    local s = pow(L - 0.0894841775 * a - 1.291485548 * b, 3)

    return {
        255 * lrgb2rgb(4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s),
        255 * lrgb2rgb(-1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s),
        255 * lrgb2rgb(-0.0041960863 * l - 0.7034186147 * m + 1.707614701 * s),
        if #args > 3 then args[4] else 1,
    }
end

function lrgb2rgb(c)
    local abs = math.abs(c)
    if abs > 0.0031308 then
        local cSign = sign(c)
        cSign = if cSign == 0 then 1 else cSign
        return cSign * (1.055 * pow(abs, 1 / 2.4) - 0.055)
    end
    return c * 12.92
end

return oklab2rgb
