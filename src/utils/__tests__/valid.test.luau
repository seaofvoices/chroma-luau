-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/valid.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

describe('Some tests for chroma.valid', function()
    describe('valid color', function()
        test('is true', function()
            expect(chroma.valid('red')).toBe(true)
        end)
    end)

    describe('invalid color', function()
        test('is false', function()
            expect(chroma.valid('bread')).toBe(false)
        end)
    end)
end)
