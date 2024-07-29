-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/lab/rgb2lab.js

local LAB_CONSTANTS = require('./lab-constants')
local unpack_ = require('../../utils').unpack

local pow = math.pow

-- deviation: pre-declare variables
local rgb2xyz

local function rgb2lab(...: any): { number }
    local args = table.pack(...)
    local r, g, b = table.unpack(unpack_(args, 'rgb'), 1, 3)
    local x, y, z = rgb2xyz(r, g, b)
    local l = 116 * y - 16
    return {
        if l < 0 then 0 else l,
        500 * (x - y),
        200 * (y - z),
    }
end

local function rgb_xyz(r: number): number
    if (function()
        r /= 255
        return r
    end)() <= 0.04045 then
        return r / 12.92
    end
    return pow((r + 0.055) / 1.055, 2.4)
end

local function xyz_lab(t: number): number
    if t > LAB_CONSTANTS.t3 then
        return pow(t, 1 / 3)
    end
    return t / LAB_CONSTANTS.t2 + LAB_CONSTANTS.t0
end

function rgb2xyz(r: number, g: number, b: number): (number, number, number)
    r = rgb_xyz(r)
    g = rgb_xyz(g)
    b = rgb_xyz(b)
    local x = xyz_lab((0.4124564 * r + 0.3575761 * g + 0.1804375 * b) / LAB_CONSTANTS.Xn)
    local y = xyz_lab((0.2126729 * r + 0.7151522 * g + 0.0721750 * b) / LAB_CONSTANTS.Yn)
    local z = xyz_lab((0.0193339 * r + 0.1191920 * g + 0.9503041 * b) / LAB_CONSTANTS.Zn)
    return x, y, z
end

return rgb2lab
