-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/rgb2hsv.test.js

local Number = require('@pkg/@jsdotlua/number')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local rgb2hsv = require('../rgb2hsv')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local describeEach = describe.each :: any

describe('Test rgb2hsv color conversions', function()
    local cases: { { string | { number } } } = {
        { 'black', { Number.NaN, 0, 0 }, { 0, 0, 0, 1 } },
        { 'white', { Number.NaN, 0, 1 }, { 255, 255, 255, 1 } },
        { 'gray', { Number.NaN, 0, 0.5 }, { 127.5, 127.5, 127.5, 1 } },
        { 'red', { 0, 1, 1 }, { 255, 0, 0, 1 } },
        { 'yellow', { 60, 1, 1 }, { 255, 255, 0, 1 } },
        { 'green', { 120, 1, 1 }, { 0, 255, 0, 1 } },
        { 'cyan', { 180, 1, 1 }, { 0, 255, 255, 1 } },
        { 'blue', { 240, 1, 1 }, { 0, 0, 255, 1 } },
        { 'magenta', { 300, 1, 1 }, { 255, 0, 255, 1 } },
    }
    describeEach(cases)('rgb2hsv %s', function(_color: string, hsv: { number }, rgb: { number })
        test('array', function()
            expect(rgb2hsv(rgb)).toEqual(hsv)
        end)

        test('hsv_obj', function()
            local r = rgb[1]
            local g = rgb[2]
            local b = rgb[3]
            expect(rgb2hsv({ r = r, g = g, b = b })).toEqual(hsv)
        end)

        test('args', function()
            expect(rgb2hsv(unpack(rgb))).toEqual(hsv)
        end)
    end)
end)
