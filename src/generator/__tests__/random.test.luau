-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/random.test.js
local RegExp = require('@pkg/luau-regexp')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

describe('Some tests for random colors', function()
    describe('random colors', function()
        local topic

        beforeEach(function()
            topic = chroma.random()
        end)

        test('valid hex code', function()
            expect(RegExp('^#[0-9a-f]{6}$', 'i'):test(topic:hex())).toBe(true)
        end)
    end)
end)
