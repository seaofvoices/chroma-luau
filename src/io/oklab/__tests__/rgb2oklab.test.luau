-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/rgb2oklab.test.js
local Collections = require('@pkg/@jsdotlua/collections')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local mathRound = require('../../../utils/round.roblox.luau')
local rgb2oklab = require('../rgb2oklab')

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

local rnd = round(3)

describe('Testing OKLab color conversions', function()
    local cases: { { string | number | { number } } } = {
        { 'black', { 0.0, 0.0, 0.0 }, { 0, 0, 0, 1 } },
        { 'white', { 1.0, 0.0, 0.0 }, { 255, 255, 255, 1 } },
        { 'gray', { 0.6, 0.0, 0.0 }, { 128, 128, 128, 1 } },
        { 'red', { 0.628, 0.225, 0.126 }, { 255, 0, 0, 1 } },
        { 'yellow', { 0.968, -0.071, 0.199 }, { 255, 255, 0, 1 } },
        { 'green', { 0.52, -0.14, 0.108 }, { 0, 128, 0, 1 } },
        { 'cyan', { 0.905, -0.149, -0.039 }, { 0, 255, 255, 1 } },
        { 'blue', { 0.452, -0.032, -0.312 }, { 0, 0, 255, 1 } },
        { 'magenta', { 0.702, 0.275, -0.169 }, { 255, 0, 255, 1 } },
    }

    describeEach(cases)('rgb2oklab: parse simple OKLab colors %s', function(_color, output, input)
        test('lab_arr', function()
            expect(Array.map(rgb2oklab(input), rnd)).toEqual(output)
        end)

        test('lab_args', function()
            expect(Array.map(rgb2oklab(unpack(input)), rnd)).toEqual(output)
        end)

        test('lab_obj', function()
            local r = input[1]
            local g = input[2]
            local b = input[3]
            expect(Array.map(rgb2oklab({ r = r, g = g, b = b }), rnd)).toEqual(output)
        end)
    end)
end)
