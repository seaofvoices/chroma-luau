-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/utils/delta-e.js
local Color = require('../Color')

type AsColor = Color.AsColor

local sqrt, pow, min, max, atan2, abs, cos, sin, exp, PI =
    math.sqrt,
    math.pow,
    math.min,
    math.max,
    math.atan2,
    math.abs,
    math.cos,
    math.sin,
    math.exp,
    math.pi

local function deltaE(a: AsColor, b: AsColor, Kl_: number?, Kc_: number?, Kh_: number?): number
    local Kl: number = if Kl_ ~= nil then Kl_ else 1
    local Kc: number = if Kc_ ~= nil then Kc_ else 1
    local Kh: number = if Kh_ ~= nil then Kh_ else 1
    -- Delta E (CIE 2000)
    -- see http://www.brucelindbloom.com/index.html?Eqn_DeltaE_CIE2000.html
    local function rad2deg(rad: number): number
        return 360 * rad / (2 * PI)
    end
    local function deg2rad(deg: number): number
        return 2 * PI * deg / 360
    end
    local a = Color.new(a)
    local b = Color.new(b)
    -- deviation: manual lab unpack
    local aLab = a:lab()
    local bLab = b:lab()
    local L1, a1, b1 = aLab[1], aLab[2], aLab[3]
    local L2, a2, b2 = bLab[1], bLab[2], bLab[3]
    local avgL = (L1 + L2) / 2
    local C1 = sqrt(pow(a1, 2) + pow(b1, 2))
    local C2 = sqrt(pow(a2, 2) + pow(b2, 2))
    local avgC = (C1 + C2) / 2
    local G = 0.5 * (1 - sqrt(pow(avgC, 7) / (pow(avgC, 7) + pow(25, 7))))
    local a1p = a1 * (1 + G)
    local a2p = a2 * (1 + G)
    local C1p = sqrt(pow(a1p, 2) + pow(b1, 2))
    local C2p = sqrt(pow(a2p, 2) + pow(b2, 2))
    local avgCp = (C1p + C2p) / 2
    local arctan1 = rad2deg(atan2(b1, a1p))
    local arctan2 = rad2deg(atan2(b2, a2p))
    local h1p = if arctan1 >= 0 then arctan1 else arctan1 + 360
    local h2p = if arctan2 >= 0 then arctan2 else arctan2 + 360
    local avgHp = if abs(h1p - h2p) > 180 then (h1p + h2p + 360) / 2 else (h1p + h2p) / 2
    local T = 1
        - 0.17 * cos(deg2rad(avgHp - 30))
        + 0.24 * cos(deg2rad(2 * avgHp))
        + 0.32 * cos(deg2rad(3 * avgHp + 6))
        - 0.2 * cos(deg2rad(4 * avgHp - 63))
    local deltaHp = h2p - h1p
    deltaHp = if abs(deltaHp) <= 180
        then deltaHp
        else if h2p <= h1p then deltaHp + 360 else deltaHp - 360
    deltaHp = 2 * sqrt(C1p * C2p) * sin(deg2rad(deltaHp) / 2)
    local deltaL = L2 - L1
    local deltaCp = C2p - C1p
    local sl = 1 + 0.015 * pow(avgL - 50, 2) / sqrt(20 + pow(avgL - 50, 2))
    local sc = 1 + 0.045 * avgCp
    local sh = 1 + 0.015 * avgCp * T
    local deltaTheta = 30 * exp(-pow((avgHp - 275) / 25, 2))
    local Rc = 2 * sqrt(pow(avgCp, 7) / (pow(avgCp, 7) + pow(25, 7)))
    local Rt = -Rc * sin(2 * deg2rad(deltaTheta))
    local result = sqrt(
        pow(deltaL / (Kl * sl), 2)
            + pow(deltaCp / (Kc * sc), 2)
            + pow(deltaHp / (Kh * sh), 2)
            + Rt * (deltaCp / (Kc * sc)) * (deltaHp / (Kh * sh))
    )
    return max(0, min(100, result))
end

return deltaE
