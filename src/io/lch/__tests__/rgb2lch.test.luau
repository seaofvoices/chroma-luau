-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/rgb2lch.test.js

local Collections = require('@pkg/@jsdotlua/collections')
local Number = require('@pkg/@jsdotlua/number')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local mathRound = require('../../../utils/round.roblox.luau')
local rgb2lch = require('../rgb2lch')

local Array = Collections.Array
local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local describeEach = describe.each :: any

local function round(digits: number): (number) -> number
    local d = math.pow(10, digits)
    return function(v: number): number
        return mathRound(v * d) / d
    end
end

local rnd = round(2)

describe('Test rgb2lch color conversions', function()
    local cases: { { string | number | { number } } } = {
        { 'black', { 0, 0, Number.NaN }, { 0, 0, 0 } },
        { 'white', { 100, 0, Number.NaN }, { 255, 255, 255 } },
        { 'gray', { 53.59, 0, Number.NaN }, { 128, 128, 128 } },
        { 'red', { 53.24, 104.55, 40 }, { 255, 0, 0 } },
        { 'yellow', { 97.14, 96.91, 102.85 }, { 255, 255, 0 } },
        { 'green', { 87.73, 119.78, 136.02 }, { 0, 255, 0 } },
        { 'cyan', { 91.11, 50.12, 196.38 }, { 0, 255, 255 } },
        { 'blue', { 32.3, 133.81, 306.28 }, { 0, 0, 255 } },
        { 'magenta', { 60.32, 115.54, 328.23 }, { 255, 0, 255 } },
    }
    describeEach(cases)('rgb2lch %s', function(_color, lch, rgb)
        test('array', function()
            expect(Array.map(rgb2lch(rgb), rnd)).toEqual(lch)
        end)

        test('obj', function()
            local r = rgb[1]
            local g = rgb[2]
            local b = rgb[3]
            expect(Array.map(rgb2lch({ r = r, g = g, b = b }), rnd)).toEqual(lch)
        end)

        test('args', function()
            expect(Array.map(rgb2lch(unpack(rgb)), rnd)).toEqual(lch)
        end)
    end)
end)
