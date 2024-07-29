-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/rgb2hsi.test.js

local Collections = require('@pkg/@jsdotlua/collections')
local Number = require('@pkg/@jsdotlua/number')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local mathRound = require('../../../utils/round.roblox.luau')
local rgb2hsi = require('../rgb2hsi')

local Array = Collections.Array
local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local describeEach = describe.each :: any

describe('Test rgb2hsi color conversions', function()
    local cases: { { string | { number } } } = {
        { 'black2', { Number.NaN, 0, 0 }, { 0, 0, 0, 1 } },
        { 'white', { Number.NaN, 0, 1 }, { 255, 255, 255, 1 } },
        { 'gray', { Number.NaN, 0, 0.5 }, { 127.5, 127.5, 127.5, 1 } },
        { 'red', { 0, 1, 1 / 3 }, { 255, 0, 0, 1 } },
        { 'yellow', { 60, 1, 2 / 3 }, { 255, 255, 0, 1 } },
        { 'green', { 120, 1, 1 / 3 }, { 0, 255, 0, 1 } },
        { 'cyan', { 180, 1, 2 / 3 }, { 0, 255, 255, 1 } },
        { 'blue', { 240, 1, 1 / 3 }, { 0, 0, 255, 1 } },
        { 'magenta', { 300, 1, 2 / 3 }, { 255, 0, 255, 1 } },
    }
    describeEach(cases)('rgb2hsi %s', function(_color, hsi, rgb)
        test('array', function()
            expect(Array.map(rgb2hsi(rgb), mathRound)).toEqual(Array.map(hsi, mathRound))
        end)

        test('obj', function()
            local r = rgb[1]
            local g = rgb[2]
            local b = rgb[3]
            expect(Array.map(rgb2hsi({ r = r, g = g, b = b }), mathRound)).toEqual(
                Array.map(hsi, mathRound)
            )
        end)

        test('args', function()
            expect(Array.map(rgb2hsi(unpack(rgb)), mathRound)).toEqual(Array.map(hsi, mathRound))
        end)
    end)
end)
