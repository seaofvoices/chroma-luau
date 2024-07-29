-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/blend.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

describe('Testing blend modes', function()
    describe('multiply 1', function()
        local topic
        beforeEach(function()
            topic = chroma.blend('red', '#5a9f37', 'multiply')
        end)

        test('is #5a0000', function()
            expect(topic:hex()).toEqual('#5a0000')
        end)
    end)

    describe('multiply 2', function()
        local topic
        beforeEach(function()
            topic = chroma.blend('#33b16f', '#857590', 'multiply')
        end)

        test('is #1a513e', function()
            expect(topic:hex()).toEqual('#1b513f')
        end)
    end)

    describe('screen', function()
        local topic
        beforeEach(function()
            topic = chroma.blend('#b83d31', '#0da671', 'screen')
        end)

        test('is #bbbb8c', function()
            expect(topic:hex()).toEqual('#bcbb8c')
        end)
    end)

    describe('overlay', function()
        local topic
        beforeEach(function()
            topic = chroma.blend('#b83d31', '#0da671', 'overlay')
        end)

        test('is #784f2b', function()
            expect(topic:hex()).toEqual('#784f2b')
        end)
    end)
end)
