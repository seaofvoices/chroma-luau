-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/contrast.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

require('../../io/named')
local contrast = require('../contrast')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

describe('Testing contrast ratio', function()
    describe('maximum contrast', function()
        test('is 21:1', function()
            expect(contrast('black', 'white')).toEqual(21)
        end)
    end)

    describe('minimum contrast', function()
        test('is 1:1', function()
            expect(contrast('white', 'white')).toEqual(1)
        end)
    end)

    describe('contrast between white and red', function()
        test('is 4:1', function()
            expect(math.round(contrast('red', 'white'))).toEqual(4)
        end)
    end)
end)
