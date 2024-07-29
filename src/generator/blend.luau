-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/generator/blend.js
--[[
 * interpolates between a set of colors uzing a bezier spline
 * blend mode formulas taken from http://www.venture-ware.com/kevin/coding/lets-learn-math-photoshop-blend-modes/
 ]]
require('../io/rgb')
local BlendTypes = require('../types/blend-types')
local chroma = require('../chroma')

type Color = chroma.Color
type BlendMode = BlendTypes.BlendMode

-- deviation: use callable table
local function blendFn(blend, bottom, top, mode: BlendMode)
    if not blend[mode] then
        error(`unknown blend mode {mode}`)
    end
    return blend[mode](bottom, top)
end
local blend = setmetatable({}, { __call = blendFn })

local function blend_f(f: ({ number }, { number }) -> { number })
    return function(bottom, top)
        local c0 = chroma(top):rgb()
        local c1 = chroma(bottom):rgb()
        return chroma.rgb(f(c0, c1))
    end
end

local function each(f): ({ number }, { number }) -> { number }
    return function(c0: { number }, c1: { number }): { number }
        local out = {}
        out[1] = f(c0[1], c1[1])
        out[2] = f(c0[2], c1[2])
        out[3] = f(c0[3], c1[3])
        return out
    end
end

local function normal(a: number): number
    return a
end

local function multiply(a: number, b: number): number
    return a * b / 255
end

local function darken(a: number, b: number): number
    return if a > b then b else a
end

local function lighten(a: number, b: number): number
    return if a > b then a else b
end

local function screen(a: number, b: number): number
    return 255 * (1 - (1 - a / 255) * (1 - b / 255))
end

local function overlay(a: number, b: number): number
    return if b < 128 then 2 * a * b / 255 else 255 * (1 - 2 * (1 - a / 255) * (1 - b / 255))
end

local function burn(a: number, b: number): number
    return 255 * (1 - (1 - b / 255) / (a / 255))
end

local function dodge(a: number, b: number): number
    if a == 255 then
        return 255
    end
    a = 255 * (b / 255) / (1 - a / 255)
    return if a > 255 then 255 else a
end

-- # add = (a,b) ->
-- #     if (a + b > 255) then 255 else a + b

blend.normal = blend_f(each(normal))
blend.multiply = blend_f(each(multiply))
blend.screen = blend_f(each(screen))
blend.overlay = blend_f(each(overlay))
blend.darken = blend_f(each(darken))
blend.lighten = blend_f(each(lighten))
blend.dodge = blend_f(each(dodge))
blend.burn = blend_f(each(burn))
-- blend.add = blend_f(each(add));

type BlendFn = ({ number }, { number }) -> { number }

return blend :: ((any, any, mode: BlendMode) -> Color) & {
    normal: BlendFn,
    multiply: BlendFn,
    screen: BlendFn,
    overlay: BlendFn,
    darken: BlendFn,
    lighten: BlendFn,
    dodge: BlendFn,
    burn: BlendFn,
}
