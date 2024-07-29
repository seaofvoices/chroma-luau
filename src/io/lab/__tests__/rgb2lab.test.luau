-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/rgb2lab.test.js
local Collections = require('@pkg/@jsdotlua/collections')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local mathRound = require('../../../utils/round.roblox.luau')
local rgb2lab = require('../rgb2lab')

local Array = Collections.Array
local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local tests: { [string]: { lab: { number }, rgb: { number } } } = {
    black = { lab = { 0, 0, 0 }, rgb = { 0, 0, 0 } },
    white = { lab = { 100, 0, 0 }, rgb = { 255, 255, 255 } },
    gray = { lab = { 53.59, 0, 0 }, rgb = { 128, 128, 128 } },
    red = { lab = { 53.24, 80.09, 67.2 }, rgb = { 255, 0, 0 } },
    yellow = { lab = { 97.14, -21.55, 94.48 }, rgb = { 255, 255, 0 } },
    green = { lab = { 87.73, -86.18, 83.18 }, rgb = { 0, 255, 0 } },
    cyan = { lab = { 91.11, -48.09, -14.13 }, rgb = { 0, 255, 255 } },
    blue = { lab = { 32.3, 79.19, -107.86 }, rgb = { 0, 0, 255 } },
    magenta = { lab = { 60.32, 98.23, -60.82 }, rgb = { 255, 0, 255 } },
}

local function round(digits: number): (number) -> number
    local d = math.pow(10, digits)
    return function(v: number): number
        if v > -1e-3 and v < 1e-3 then
            v = 0
        end
        return mathRound(v * d) / d
    end
end

local rnd = round(2)

describe('Test rgb2lab color conversions', function()
    for key, topic in tests do
        describe(`rgb2lab {key}`, function()
            test('array', function()
                expect(Array.map(rgb2lab(topic.rgb), rnd)).toEqual(topic.lab)
            end)

            test('obj', function()
                local r = topic.rgb[1]
                local g = topic.rgb[2]
                local b = topic.rgb[3]
                expect(Array.map(rgb2lab({ r = r, g = g, b = b }), rnd)).toEqual(topic.lab)
            end)

            test('args', function()
                expect(Array.map(rgb2lab(unpack(topic.rgb)), rnd)).toEqual(topic.lab)
            end)
        end)
    end
end)
