-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/lch2lab.test.js

local Collections = require('@pkg/@jsdotlua/collections')
local Number = require('@pkg/@jsdotlua/number')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local lch2lab = require('../lch2lab')
local mathRound = require('../../../utils/round.roblox.luau')

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

describe('Testing lch2lab color conversions', function()
    local cases: { { string | { number } } } = {
        { 'black', { 0, 0, 0 }, { 0, 0, Number.NaN } },
        { 'white', { 100, 0, 0 }, { 100, 0, Number.NaN } },
        { 'gray', { 53.59, 0, 0 }, { 53.59, 0, Number.NaN } },
        { 'red', { 53.24, 80.09, 67.2 }, { 53.24, 104.55, 40 } },
        { 'yellow', { 97.14, -21.55, 94.48 }, { 97.14, 96.91, 102.85 } },
        { 'green', { 87.73, -86.17, 83.18 }, { 87.73, 119.77, 136.01 } },
        { 'cyan', { 91.11, -48.09, -14.13 }, { 91.11, 50.12, 196.37 } },
        { 'blue', { 32.3, 79.2, -107.86 }, { 32.3, 133.81, 306.29 } },
        { 'magenta', { 60.32, 98.23, -60.81 }, { 60.32, 115.53, 328.24 } },
    }
    describeEach(cases)('lch2lab - %s', function(_color, lab, lch)
        test('array', function()
            expect(Array.map(lch2lab(lch), rnd)).toEqual(lab)
        end)

        test('args', function()
            expect(Array.map(lch2lab(unpack(lch)), rnd)).toEqual(lab)
        end)

        test('obj', function()
            local l = lch[1]
            local c = lch[2]
            local h = lch[3]
            expect(Array.map(lch2lab({ l = l, c = c, h = h }), rnd)).toEqual(lab)
        end)
    end)
end)
