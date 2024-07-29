-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/temperature2rgb.test.js

local Collections = require('@pkg/@jsdotlua/collections')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local temperature2rgb = require('../temperature2rgb')

local Array = Collections.Array
local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local describeEach = describe.each :: any

describe('Testing Kelvin color conversions', function()
    local cases: { { string | number | { number } } } = {
        { '1k', 1000, { 255, 58, 0, 1 } },
        { '4k', 4000, { 255, 208, 164, 1 } },
        { '5k', 5000, { 255, 228, 205, 1 } },
        { '7k', 7000, { 245, 243, 255, 1 } },
        { '10k', 10000, { 204, 220, 255, 1 } },
        { '20k', 20000, { 168, 197, 255, 1 } },
        { '30k', 30000, { 159, 190, 255, 1 } },
    }

    describeEach(cases)('parse simple kelvin colors %s', function(_temperature, input, output)
        test('hsv_arr', function()
            expect(Array.map(temperature2rgb(input), math.round)).toEqual(output)
        end)
    end)
end)
