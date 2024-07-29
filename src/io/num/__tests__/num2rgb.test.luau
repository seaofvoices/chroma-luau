-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/num2rgb.test.js

local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local num2rgb = require('../num2rgb')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local describeEach = describe.each :: any

describe('TestTesting num2rgb color conversions', function()
    local cases: { { string | number | { number } } } = {
        { 'black', 0x000000, { 0, 0, 0, 1 } },
        { 'white', 0xFFFFFF, { 255, 255, 255, 1 } },
        { 'red', 0xff0000, { 255, 0, 0, 1 } },
        { 'green', 0x00ff00, { 0, 255, 0, 1 } },
        { 'blue', 0x0000ff, { 0, 0, 255, 1 } },
        { 'yellow', 0xffff00, { 255, 255, 0, 1 } },
        { 'cyan', 0x00ffff, { 0, 255, 255, 1 } },
        { 'magenta', 0xff00ff, { 255, 0, 255, 1 } },
    }

    describeEach(cases)('parse simple numeric HEX colors - %s', function(_color, input, output)
        test('num', function()
            expect(num2rgb(input)).toEqual(output)
        end)
    end)
end)
