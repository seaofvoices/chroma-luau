-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/hsv2rgb.test.js

local Number = require('@pkg/@jsdotlua/number')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local hsv2rgb = require('../hsv2rgb')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local describeEach = describe.each :: any

describe('Testing hsv color conversions', function()
    local cases: { { string | { number } } } = {
        { 'black', { Number.NaN, 0, 0 }, { 0, 0, 0, 1 } },
        { 'white', { Number.NaN, 0, 1 }, { 255, 255, 255, 1 } },
        { 'gray', { 0, 0, 0.5 }, { 127.5, 127.5, 127.5, 1 } },
        { 'red', { 0, 1, 1 }, { 255, 0, 0, 1 } },
        { 'yellow', { 60, 1, 1 }, { 255, 255, 0, 1 } },
        { 'green', { 120, 1, 1 }, { 0, 255, 0, 1 } },
        { 'cyan', { 180, 1, 1 }, { 0, 255, 255, 1 } },
        { 'blue', { 240, 1, 1 }, { 0, 0, 255, 1 } },
        { 'magenta', { 300, 1, 1 }, { 255, 0, 255, 1 } },
        { 'red_again', { 360, 1, 1 }, { 255, 0, 0, 1 } },
    }
    describeEach(cases)(
        'parse simple hsv colors %s',
        function(_color: string, input: { number }, output: { number })
            test('hsv_arr', function()
                expect(hsv2rgb(input)).toEqual(output)
            end)

            test('hsv_args', function()
                expect(hsv2rgb(unpack(input))).toEqual(output)
            end)

            test('hsv_obj', function()
                local h = input[1]
                local s = input[2]
                local v = input[3]
                expect(hsv2rgb({ h = h, s = s, v = v })).toEqual(output)
            end)
        end
    )
end)
