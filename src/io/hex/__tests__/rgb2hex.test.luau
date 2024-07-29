-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/rgb2hex.test.js

local Collections = require('@pkg/@jsdotlua/collections')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local rgb2hex = require('../rgb2hex')

local Array = Collections.Array
local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local describeEach = describe.each :: any

describe('Test rgb2hex color conversions', function()
    local cases: { { string | { number } } } = {
        { 'black', { 0, 0, 0, 1 }, 'auto', '#000000' },
        { 'white', { 255, 255, 255, 1 }, 'auto', '#ffffff' },
        { 'gray', { 128, 128, 128, 1 }, 'auto', '#808080' },
        { 'red', { 255, 0, 0, 1 }, 'auto', '#ff0000' },
        { 'yellow', { 0, 255, 0, 1 }, 'auto', '#00ff00' },
        { 'green', { 0, 0, 255, 1 }, 'auto', '#0000ff' },
        { 'cyan', { 255, 255, 0, 1 }, 'auto', '#ffff00' },
        { 'blue', { 0, 255, 255, 1 }, 'auto', '#00ffff' },
        { 'magenta', { 255, 0, 255 }, 'rgb', '#ff00ff' },
        { 'auto_rgba', { 255, 0, 255, 0.5 }, 'auto', '#ff00ff80' },
        { 'force_rgba', { 255, 0, 255 }, 'rgba', '#ff00ffff' },
        { 'force_rgb', { 255, 0, 255, 0.5 }, 'rgb', '#ff00ff' },
    }
    describeEach(cases)('rgb2hex %s', function(_color, rgb, mode, hex)
        test('array', function()
            expect(rgb2hex(rgb, mode)).toEqual(hex)
        end)

        test('obj', function()
            local r = rgb[1]
            local g = rgb[2]
            local b = rgb[3]
            local a = rgb[4]
            expect(rgb2hex({ r = r, g = g, b = b, a = a }, mode)).toEqual(hex)
        end)

        test('args', function()
            if mode ~= 'auto' then
                return
            end
            local args = Array.concat(rgb, { mode })
            expect(rgb2hex(unpack(args))).toEqual(hex)
        end)
    end)
end)
