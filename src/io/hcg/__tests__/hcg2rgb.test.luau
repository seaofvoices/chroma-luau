-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/hcg2rgb.test.js

local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local hcg2rgb = require('../hcg2rgb')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local describeEach = describe.each :: any

describe('Testing HCG color conversions', function()
    local cases: { { string | { number } } } = {
        { 'black', { 0, 0, 0 }, { 0, 0, 0, 1 } },
        { 'white', { 0, 0, 1 }, { 255, 255, 255, 1 } },
        { 'gray', { 0, 0, 0.5 }, { 127.5, 127.5, 127.5, 1 } },
        { 'red', { 0, 1, 0 }, { 255, 0, 0, 1 } },
        { 'yellow', { 60, 1, 0 }, { 255, 255, 0, 1 } },
        { 'green', { 120, 1, 0 }, { 0, 255, 0, 1 } },
        { 'cyan', { 180, 1, 0 }, { 0, 255, 255, 1 } },
        { 'blue', { 240, 1, 0 }, { 0, 0, 255, 1 } },
        { 'magenta', { 300, 1, 0 }, { 255, 0, 255, 1 } },
        { 'red_again', { 360, 1, 0 }, { 255, 0, 0, 1 } },
    }
    describeEach(cases)('parse simple HCG colors %s', function(_color, input, output)
        test('hcg_arr', function()
            expect(hcg2rgb(input)).toEqual(output)
        end)

        test('hcg_args', function()
            expect(hcg2rgb(unpack(input))).toEqual(output)
        end)

        test('hcg_obj', function()
            local h = input[1]
            local c = input[2]
            local g = input[3]
            expect(hcg2rgb({ h = h, c = c, g = g })).toEqual(output)
        end)
    end)
end)
