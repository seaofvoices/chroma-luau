-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/css/css2rgb.js
local RegExp = require('@pkg/luau-regexp')
local String = require('@pkg/@jsdotlua/string')

local hsl2rgb = require('../hsl/hsl2rgb')
local input = require('../input')
require('../named')

local RE_RGB = RegExp('^rgb\\(\\s*(-?\\d+),\\s*(-?\\d+)\\s*,\\s*(-?\\d+)\\s*\\)$')
local RE_RGBA =
    RegExp('^rgba\\(\\s*(-?\\d+),\\s*(-?\\d+)\\s*,\\s*(-?\\d+)\\s*,\\s*([01]|[01]?\\.\\d+)\\)$')
local RE_RGB_PCT = RegExp(
    '^rgb\\(\\s*(-?\\d+(?:\\.\\d+)?)%,\\s*(-?\\d+(?:\\.\\d+)?)%\\s*,\\s*(-?\\d+(?:\\.\\d+)?)%\\s*\\)$'
)
local RE_RGBA_PCT = RegExp(
    '^rgba\\(\\s*(-?\\d+(?:\\.\\d+)?)%,\\s*(-?\\d+(?:\\.\\d+)?)%\\s*,\\s*(-?\\d+(?:\\.\\d+)?)%\\s*,\\s*([01]|[01]?\\.\\d+)\\)$'
)
local RE_HSL = RegExp(
    '^hsl\\(\\s*(-?\\d+(?:\\.\\d+)?),\\s*(-?\\d+(?:\\.\\d+)?)%\\s*,\\s*(-?\\d+(?:\\.\\d+)?)%\\s*\\)$'
)
local RE_HSLA = RegExp(
    '^hsla\\(\\s*(-?\\d+(?:\\.\\d+)?),\\s*(-?\\d+(?:\\.\\d+)?)%\\s*,\\s*(-?\\d+(?:\\.\\d+)?)%\\s*,\\s*([01]|[01]?\\.\\d+)\\)$'
)

local round = math.round

local function css2rgb(css: string): { number }?
    css = String.trim(string.lower(css))
    local m
    if input.format.named then
        local ok, result = pcall(input.format.named, css)
        if ok then
            return result
        end
    end

    -- rgb(250,20,0)
    m = RE_RGB:exec(css)
    if m ~= nil then
        local rgb = {}
        for i = 1, 3 do
            rgb[i] = tonumber(m[i + 1]) :: number
        end
        rgb[4] = 1 -- default alpha
        return rgb
    end

    -- rgba(250,20,0,0.4)
    m = RE_RGBA:exec(css)
    if m ~= nil then
        local rgb = {}
        for i = 1, 4 do
            rgb[i] = tonumber(m[i + 1]) :: number
        end
        return rgb
    end

    -- rgb(100%,0%,0%)
    m = RE_RGB_PCT:exec(css)
    if m ~= nil then
        local rgb = {}
        for i = 1, 3 do
            rgb[i] = round(tonumber(m[i + 1]) :: number * 2.55)
        end
        rgb[4] = 1 -- default alpha
        return rgb
    end

    -- rgba(100%,0%,0%,0.4)
    m = RE_RGBA_PCT:exec(css)
    if m ~= nil then
        local rgb = {}
        for i = 1, 4 do
            rgb[i] = round(tonumber(m[i + 1]) :: number * 2.55)
        end
        rgb[4] = tonumber(m[5]) :: number
        return rgb
    end

    -- hsl(0,100%,50%)
    m = RE_HSL:exec(css)
    if m ~= nil then
        -- deviation: manual unpack
        local hsl = {
            tonumber(m[2]) :: number,
            tonumber(m[3]) :: number * 0.01,
            tonumber(m[4]) :: number * 0.01,
        }
        local rgb = hsl2rgb(hsl)
        rgb[4] = 1
        return rgb
    end

    -- hsla(0,100%,50%,0.5)
    m = RE_HSLA:exec(css)
    if m ~= nil then
        -- deviation: manual unpack
        local hsl = {
            tonumber(m[2]) :: number,
            tonumber(m[3]) :: number * 0.01,
            tonumber(m[4]) :: number * 0.01,
        }
        local rgb = hsl2rgb(hsl)
        rgb[4] = tonumber(m[5]) :: number -- default alpha = 1
        return rgb
    end

    return nil
end

local function css2rgbTest(s: string): boolean
    return RE_RGB:test(s)
        or RE_RGBA:test(s)
        or RE_RGB_PCT:test(s)
        or RE_RGBA_PCT:test(s)
        or RE_HSL:test(s)
        or RE_HSLA:test(s)
end

return {
    css2rgb = css2rgb,
    test = css2rgbTest,
}
