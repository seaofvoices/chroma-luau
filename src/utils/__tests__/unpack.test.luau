-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/hsv2rgb.test.js

local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local unpack_ = require('../unpack')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

describe('Testing unpack', function()
    describe('parse simple CMYK colors', function()
        test('args', function()
            local args = table.pack(1, 2, 3, 4)
            expect(unpack_(args)).toEqual({ 1, 2, 3, 4 })
        end)

        test('array', function()
            local args = table.pack({ 1, 2, 3, 4 })
            expect(unpack_(args)).toEqual({ 1, 2, 3, 4 })
        end)

        test('object', function()
            local args = table.pack({ c = 1, m = 2, y = 3, k = 4 })
            expect(unpack_(args, 'cmyk')).toEqual({ 1, 2, 3, 4 })
        end)
    end)
end)
