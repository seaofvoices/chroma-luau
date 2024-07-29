-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/lch2rgb.test.js

local Collections = require('@pkg/@jsdotlua/collections')
local Number = require('@pkg/@jsdotlua/number')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local lch2rgb = require('../lch2rgb')
local limit = require('../../../utils/limit')
local mathRound = require('../../../utils/round.roblox.luau')

local Array = Collections.Array
local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local describeEach = describe.each :: any

local function round(v: number): number
    return limit(mathRound(v), 0, 255)
end

describe('Testing LCH conversions', function()
    local cases: { { string | number | { number } } } = {
        { 'black', { 0, 0, Number.NaN }, { 0, 0, 0, 1 } },
        { 'white', { 100, 0, Number.NaN }, { 255, 255, 255, 1 } },
        { 'gray', { 53.59, 0, Number.NaN }, { 128, 128, 128, 1 } },
        { 'red', { 53.24, 104.55, 40 }, { 255, 0, 0, 1 } },
        { 'yellow', { 97.14, 96.91, 102.85 }, { 255, 255, 0, 1 } },
        { 'green', { 87.73, 119.78, 136.02 }, { 0, 255, 0, 1 } },
        { 'cyan', { 91.11, 50.12, 196.38 }, { 0, 255, 255, 1 } },
        { 'blue', { 32.3, 133.81, 306.28 }, { 0, 0, 255, 1 } },
        { 'magenta', { 60.32, 115.54, 328.23 }, { 255, 0, 255, 1 } },
    }
    describeEach(cases)('parse simple LCH colors %s', function(_color, input, output)
        test('lch_arr', function()
            expect(Array.map(lch2rgb(input), round)).toEqual(output)
        end)

        test('lch_args', function()
            expect(Array.map(lch2rgb(input), round)).toEqual(output)
        end)

        test('lch_obj', function()
            local l = input[1]
            local c = input[2]
            local h = input[3]
            expect(Array.map(lch2rgb({ l = l, c = c, h = h }), round)).toEqual(output)
        end)
    end)
end)
