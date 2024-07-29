-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/lab/lab2rgb.js

local Number = require('@pkg/@jsdotlua/number')

local LAB_CONSTANTS = require('./lab-constants')
local unpack_ = require('../../utils').unpack
local pow = math.pow

-- deviation: pre-declare variables
local xyz_rgb, lab_xyz

--[[
 * L* [0..100]
 * a [-100..100]
 * b [-100..100]
]]
local function lab2rgb(...: any): { number }
    local args = unpack_(table.pack(...), 'lab')
    local l, a, b = table.unpack(args, 1, 3)
    local x, y, z, r, g, b_

    y = (l + 16) / 116
    x = if Number.isNaN(a) then y else y + a / 500
    z = if Number.isNaN(b) then y else y - b / 200

    y = LAB_CONSTANTS.Yn * lab_xyz(y)
    x = LAB_CONSTANTS.Xn * lab_xyz(x)
    z = LAB_CONSTANTS.Zn * lab_xyz(z)

    r = xyz_rgb(3.2404542 * x - 1.5371385 * y - 0.4985314 * z) -- D65 -> sRGB
    g = xyz_rgb(-0.9692660 * x + 1.8760108 * y + 0.0415560 * z)
    b_ = xyz_rgb(0.0556434 * x - 0.2040259 * y + 1.0572252 * z)

    return { r, g, b_, if #args > 3 then args[4] else 1 }
end

function xyz_rgb(r: number): number
    return 255 * (if r <= 0.00304 then 12.92 * r else 1.055 * pow(r, 1 / 2.4) - 0.055)
end

function lab_xyz(t: number): number
    return if t > LAB_CONSTANTS.t1 then t * t * t else LAB_CONSTANTS.t2 * (t - LAB_CONSTANTS.t0)
end

return lab2rgb
