-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/generator/average.js
local Collections = require('@pkg/@jsdotlua/collections')
local Number = require('@pkg/@jsdotlua/number')

local Color = require('../Color')
local clip_rgb = require('../utils').clip_rgb

type Color = Color.Color
type PrivateColor = Color.PrivateColor

local Array = Collections.Array
local pow, sqrt, PI, cos, sin, atan2 = math.pow, math.sqrt, math.pi, math.cos, math.sin, math.atan2

-- deviation: pre-declare variables
local _average_lrgb

local function average(colors: { any }, mode: string?, weights: { number }?): Color
    local mode: string = if mode ~= nil then mode else 'lrgb'
    local l = #colors

    -- deviation: use table.create instead of Array.from
    local weights: { number } = if weights == nil then table.create(l, 1) else weights

    -- normalize weights
    local k = l
        / Array.reduce(weights, function(a: number, b: number): number
            return a + b
        end)
    for i in weights do
        weights[i] *= k
    end
    -- deviation: re-declare colors to avoid type errors
    local colors = Array.map(colors, function(c)
        return Color.new(c)
    end)
    if mode == 'lrgb' then
        return _average_lrgb(colors, weights)
    end
    local first = table.remove(colors, 1) :: Color
    local xyz = first:get(mode) :: { number }
    local cnt = {}
    local dx = 0
    local dy = 0
    -- initial color
    for i: number in xyz do
        xyz[i] = (xyz[i] or 0) * weights[1]
        table.insert(cnt, if Number.isNaN(xyz[i]) then 0 else weights[1])
        if string.sub(mode, i, i) == 'h' and not Number.isNaN(xyz[i]) then
            local A = xyz[i] / 180 * PI
            dx += cos(A) * weights[1]
            dy += sin(A) * weights[1]
        end
    end

    local alpha = first:alpha() * weights[1]
    for ci, c in colors do
        local xyz2 = c:get(mode) :: { number }
        alpha += c:alpha() * weights[ci + 1]

        for i in xyz do
            if not Number.isNaN(xyz2[i]) then
                cnt[i] += weights[ci + 1]
                if string.sub(mode, i, i) == 'h' then
                    local A = xyz2[i] / 180 * PI
                    dx += cos(A) * weights[ci + 1]
                    dy += sin(A) * weights[ci + 1]
                else
                    xyz[i] += xyz2[i] * weights[ci + 1]
                end
            end
        end
    end

    for i in xyz do
        if string.sub(mode, i, i) == 'h' then
            local A = atan2(dy / cnt[i], dx / cnt[i]) / PI * 180
            while A < 0 do
                A += 360
            end
            while A >= 360 do
                A -= 360
            end
            xyz[i] = A
        else
            xyz[i] = xyz[i] / cnt[i]
        end
    end

    alpha /= l
    return Color.new(xyz, mode):alpha(if alpha > 0.99999 then 1 else alpha, true)
end

function _average_lrgb(colors: { Color }, weights: { number }): Color
    local l = #colors
    local xyz = { 0, 0, 0, 0 }

    for i, col in colors do
        local f = weights[i] / l
        local rgb = (col :: PrivateColor)._rgb
        xyz[1] += pow(rgb[1], 2) * f
        xyz[2] += pow(rgb[2], 2) * f
        xyz[3] += pow(rgb[3], 2) * f
        xyz[4] += rgb[4] * f
    end

    xyz[1] = sqrt(xyz[1])
    xyz[2] = sqrt(xyz[2])
    xyz[3] = sqrt(xyz[3])

    if xyz[4] > 0.9999999 then
        xyz[4] = 1
    end

    return Color.new(clip_rgb(xyz))
end

return average
