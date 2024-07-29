-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/rgb2oklch.test.js
local Collections = require('@pkg/@jsdotlua/collections')
local Number = require('@pkg/@jsdotlua/number')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local mathRound = require('../../../utils/round.roblox.luau')
local rgb2oklch = require('../rgb2oklch')

local Array = Collections.Array
local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local tests: { [string]: { oklch: { number }, rgb: { number } } } = {
    black = { oklch = { 0.0, 0.0, Number.NaN }, rgb = { 0, 0, 0, 1 } },
    white = { oklch = { 1.0, 0.0, Number.NaN }, rgb = { 255, 255, 255, 1 } },
    gray = { oklch = { 0.6, 0.0, Number.NaN }, rgb = { 128, 128, 128, 1 } },
    red = { oklch = { 0.628, 0.258, 29.234 }, rgb = { 255, 0, 0, 1 } },
    yellow = { oklch = { 0.968, 0.211, 109.769 }, rgb = { 255, 255, 0, 1 } },
    green = { oklch = { 0.52, 0.177, 142.495 }, rgb = { 0, 128, 0, 1 } },
    cyan = { oklch = { 0.905, 0.155, 194.769 }, rgb = { 0, 255, 255, 1 } },
    blue = { oklch = { 0.452, 0.313, 264.052 }, rgb = { 0, 0, 255, 1 } },
    magenta = { oklch = { 0.702, 0.322, 328.363 }, rgb = { 255, 0, 255, 1 } },
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

local rnd = round(3)

describe('Test rgb2oklch color conversions', function()
    for key, topic in tests do
        describe(`rgb2oklch {key}`, function()
            test('array', function()
                expect(Array.map(rgb2oklch(topic.rgb), rnd)).toEqual(topic.oklch)
            end)

            test('obj', function()
                local r = topic.rgb[1]
                local g = topic.rgb[2]
                local b = topic.rgb[3]
                expect(Array.map(rgb2oklch({ r = r, g = g, b = b }), rnd)).toEqual(topic.oklch)
            end)

            test('args', function()
                expect(Array.map(rgb2oklch(unpack(topic.rgb)), rnd)).toEqual(topic.oklch)
            end)
        end)
    end
end)
