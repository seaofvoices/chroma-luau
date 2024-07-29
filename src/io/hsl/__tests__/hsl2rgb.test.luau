-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/hsl2rgb.test.js

local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local hsl2rgb = require('../hsl2rgb')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local describeEach = describe.each :: any

describe('Testing CMYK color conversions', function()
    local cases: { { string | { number } } } = {
        { 'black', { 0, 0, 0 }, { 0, 0, 0, 1 } },
        { 'white', { 0, 0, 1 }, { 255, 255, 255, 1 } },
        { 'gray', { 0, 0, 0.5 }, { 127.5, 127.5, 127.5, 1 } },
        { 'red', { 0, 1, 0.5 }, { 255, 0, 0, 1 } },
        { 'yellow', { 60, 1, 0.5 }, { 255, 255, 0, 1 } },
        { 'green', { 120, 1, 0.5 }, { 0, 255, 0, 1 } },
        { 'cyan', { 180, 1, 0.5 }, { 0, 255, 255, 1 } },
        { 'blue', { 240, 1, 0.5 }, { 0, 0, 255, 1 } },
        { 'magenta', { 300, 1, 0.5 }, { 255, 0, 255, 1 } },
        { 'red_again', { 360, 1, 0.5 }, { 255, 0, 0, 1 } },
    }
    describeEach(cases)(
        'parse simple HSL colors %s',
        function(_color: string, input: { number }, output: { number })
            test('hsv_arr', function()
                expect(hsl2rgb(input)).toEqual(output)
            end)

            test('hsv_args', function()
                expect(hsl2rgb(unpack(input))).toEqual(output)
            end)

            test('hsv_obj', function()
                local h = input[1]
                local s = input[2]
                local l = input[3]
                expect(hsl2rgb({ h = h, s = s, l = l })).toEqual(output)
            end)
        end
    )
end)
