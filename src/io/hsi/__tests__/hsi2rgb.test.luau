-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/hsi2rgb.test.js

local Collections = require('@pkg/@jsdotlua/collections')
local Number = require('@pkg/@jsdotlua/number')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local hsi2rgb = require('../hsi2rgb')
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

describe('Testing CMYK color conversions', function()
    local cases: { { string | { number } } } = {
        { 'black', { 0, 0, 0 }, { 0, 0, 0, 1 } },
        { 'black2', { Number.NaN, 0, 0 }, { 0, 0, 0, 1 } },
        { 'white', { 0, 0, 1 }, { 255, 255, 255, 1 } },
        { 'gray', { 0, 0, 0.5 }, { 127.5, 127.5, 127.5, 1 } },
        { 'red', { 0, 1, 1 / 3 }, { 255, 0, 0, 1 } },
        { 'yellow', { 60, 1, 2 / 3 }, { 255, 255, 0, 1 } },
        { 'green', { 120, 1, 1 / 3 }, { 0, 255, 0, 1 } },
        { 'cyan', { 180, 1, 2 / 3 }, { 0, 255, 255, 1 } },
        { 'blue', { 240, 1, 1 / 3 }, { 0, 0, 255, 1 } },
        { 'magenta', { 300, 1, 2 / 3 }, { 255, 0, 255, 1 } },
        { 'red_again', { 360, 1, 1 / 3 }, { 255, 0, 0, 1 } },
    }
    describeEach(cases)(
        'parse simple HSI colors %s',
        function(_color: string, input: { number }, output: { number })
            test('hsi_arr', function()
                expect(Array.map(hsi2rgb(input), round(4))).toEqual(output)
            end)

            test('hsi_args', function()
                expect(Array.map(hsi2rgb(unpack(input)), round(4))).toEqual(output)
            end)

            test('hsi_obj', function()
                local h = input[1]
                local s = input[2]
                local i = input[3]
                expect(Array.map(hsi2rgb({ h = h, s = s, i = i }), round(4))).toEqual(output)
            end)
        end
    )
end)
