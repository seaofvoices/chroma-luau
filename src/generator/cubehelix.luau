-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/generator/cubehelix.js
-- cubehelix interpolation
-- based on D.A. Green "A colour scheme for the display of astronomical intensity images"
-- http://astron-soc.in/bulletin/11June/289392011.pdf
local CubehelixTypes = require('../types/cubehelix-types')
local chroma = require('../chroma')
local utils = require('../utils')

local clip_rgb, TWOPI = utils.clip_rgb, utils.TWOPI
local pow, sin, cos = math.pow, math.sin, math.cos

type Color = chroma.Color
type Cubehelix = CubehelixTypes.Cubehelix

local function cubehelix(
    start_: number?,
    rotations_: number?,
    hue_: number | { number }?,
    gamma_: number?,
    lightness_: number | { number }?
): Cubehelix
    local start: number = if start_ ~= nil then start_ else 300
    local rotations: number = if rotations_ ~= nil then rotations_ else -1.5
    local hue: number | { number } = if hue_ ~= nil then hue_ else 1
    local gamma: number = if gamma_ ~= nil then gamma_ else 1
    local lightness: { number } = if lightness_ ~= nil then lightness_ :: { number } else { 0, 1 }
    local dh = 0
    local dl

    -- deviation: use default type function
    if type(lightness) == 'table' then
        dl = lightness[2] - lightness[1]
    else
        dl = 0
        lightness = { lightness, lightness }
    end

    -- deviation: use callable table
    local function callF(_self, fract: number): Color
        local a = TWOPI * ((start + 120) / 360 + rotations * fract)
        local l = pow(lightness[1] + dl * fract, gamma)
        -- deviation: note if dh == 0 then hue is a number, else it is an array of number
        local h = if dh ~= 0 then (hue :: { number })[1] + fract * dh else hue :: number
        local amp = h * l * (1 - l) / 2
        local cos_a = cos(a)
        local sin_a = sin(a)
        local r = l + amp * (-0.14861 * cos_a + 1.78277 * sin_a)
        local g = l + amp * (-0.29227 * cos_a - 0.90649 * sin_a)
        local b = l + amp * (1.97294 * cos_a)
        return chroma(clip_rgb({ r * 255, g * 255, b * 255, 1 }))
    end
    local f = setmetatable({}, { __call = callF })

    function f.start(s: number?): Cubehelix | number
        if s == nil then
            return start
        end
        start = s :: number
        return f :: Cubehelix
    end

    function f.rotations(r: number?): Cubehelix | number
        if r == nil then
            return rotations
        end
        rotations = r :: number
        return f :: Cubehelix
    end

    function f.gamma(g: number?): Cubehelix | number
        if g == nil then
            return gamma
        end
        gamma = g :: number
        return f :: Cubehelix
    end

    function f.hue(h: number | { number }?)
        if h == nil then
            return hue
        end
        hue = h :: number | { number }
        -- deviation: use default type function
        if type(hue) == 'table' then
            dh = hue[2] - hue[1]
            if dh == 0 then
                hue = hue[2]
            end
        else
            dh = 0
        end
        return f :: Cubehelix
    end

    function f.lightness(h: number | { number }): Cubehelix | { number }
        if h == nil then
            return lightness
        end
        -- deviation: use default type function
        if type(h) == 'table' then
            lightness = h
            dl = h[2] - h[1]
        else
            lightness = { h, h }
            dl = 0
        end
        return f :: Cubehelix
    end

    function f.scale()
        return chroma.scale(f :: any)
    end

    f.hue(hue)

    return f :: Cubehelix
end

return cubehelix
