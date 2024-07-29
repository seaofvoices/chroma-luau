-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/oklab2rgb.test.js
local Collections = require('@pkg/@jsdotlua/collections')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local limit = require('../../../utils/limit')
local mathRound = require('../../../utils/round.roblox.luau')
local oklab2rgb = require('../oklab2rgb')

local Array = Collections.Array
local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local describeEach = describe.each :: any

local function round(v: number): number
    return limit(mathRound(v), 0, 255)
end

describe('Testing CMYK color conversions', function()
    local cases: { { string | number | { number } } } = {
        { 'black', { 0.0, 0.0, 0.0 }, { 0, 0, 0, 1 } },
        { 'white', { 1.0, 0.0, 0.0 }, { 255, 255, 255, 1 } },
        { 'gray', { 0.59987, 0.0, 0.0 }, { 128, 128, 128, 1 } },
        { 'red', { 0.62796, 0.22486, 0.12585 }, { 255, 0, 0, 1 } },
        { 'yellow', { 0.96798, -0.07137, 0.19857 }, { 255, 255, 0, 1 } },
        { 'green', { 0.51975, -0.1403, 0.10768 }, { 0, 128, 0, 1 } },
        { 'cyan', { 0.9054, -0.14944, -0.0394 }, { 0, 255, 255, 1 } },
        { 'blue', { 0.45201, -0.03246, -0.31153 }, { 0, 0, 255, 1 } },
        { 'magenta', { 0.70167, 0.27457, -0.16916 }, { 255, 0, 255, 1 } },
    }

    describeEach(cases)('oklab2rgb %s', function(_color, input, output)
        test('lab_arr', function()
            expect(Array.map(oklab2rgb(input), round)).toEqual(output)
        end)

        test('lab_args', function()
            expect(Array.map(oklab2rgb(unpack(input)), round)).toEqual(output)
        end)

        test('lab_obj', function()
            local l = input[1]
            local a = input[2]
            local b = input[3]
            expect(Array.map(oklab2rgb({ l = l, a = a, b = b }), round)).toEqual(output)
        end)
    end)
end)
