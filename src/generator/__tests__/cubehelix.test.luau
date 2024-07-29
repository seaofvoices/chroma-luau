-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/cubehelix.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local cubehelix = require('../cubehelix')
require('../../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

describe('Testing cubehelix scales', function()
    describe('default helix', function()
        local t
        beforeEach(function()
            t = cubehelix()
        end)

        test('starts in black', function()
            expect(t(0):hex()).toEqual('#000000')
        end)

        test('at 0.25', function()
            expect(t(0.25):hex()).toEqual('#16534c')
        end)

        test('at 0.5', function()
            expect(t(0.5):hex()).toEqual('#a07949')
        end)

        test('at 0.75', function()
            expect(t(0.75):hex()).toEqual('#c7b3ed')
        end)

        test('ends in white', function()
            expect(t(1):hex()).toEqual('#ffffff')
        end)
    end)

    describe('red helix', function()
        local t
        beforeEach(function()
            t = cubehelix(0, 1, 1, 1)
        end)

        test('starts in black', function()
            expect(t(0):hex()).toEqual('#000000')
        end)

        test('at 0.25', function()
            expect(t(0.25):hex()).toEqual('#2e5117')
        end)

        test('at 0.5', function()
            expect(t(0.5):hex()).toEqual('#4c949f')
        end)

        test('at 0.75', function()
            expect(t(0.75):hex()).toEqual('#d1aee8')
        end)

        test('ends in white', function()
            expect(t(1):hex()).toEqual('#ffffff')
        end)
    end)

    describe('red helix - partial l range', function()
        local t
        beforeEach(function()
            t = cubehelix(0, 1, 1, 1, { 0.25, 0.75 })
        end)

        test('starts', function()
            expect(t(0):hex()).toEqual('#663028')
        end)

        test('at 0.25', function()
            expect(t(0.25):hex()).toEqual('#49752d')
        end)

        test('at 0.5', function()
            expect(t(0.5):hex()).toEqual('#4c949f')
        end)

        test('at 0.75', function()
            expect(t(0.75):hex()).toEqual('#b68ad2')
        end)

        test('ends', function()
            expect(t(1):hex()).toEqual('#e6b0a8')
        end)
    end)

    describe('red helix - gamma', function()
        local t
        beforeEach(function()
            t = cubehelix(0, 1, 1, 0.8, { 0, 1 })
        end)

        test('starts in black', function()
            expect(t(0):hex()).toEqual('#000000')
        end)

        test('at 0.25', function()
            expect(t(0.25):hex()).toEqual('#3f6824')
        end)

        test('at 0.5', function()
            expect(t(0.5):hex()).toEqual('#60a6b1')
        end)

        test('at 0.75', function()
            expect(t(0.75):hex()).toEqual('#dabcee')
        end)

        test('ends in white', function()
            expect(t(1):hex()).toEqual('#ffffff')
        end)
    end)

    describe('red helix - no saturation', function()
        local t
        beforeEach(function()
            t = cubehelix(0, 1, 0, 1, { 0, 1 })
        end)

        test('starts in black', function()
            expect(t(0):hex()).toEqual('#000000')
        end)

        test('at 0.25', function()
            expect(t(0.25):hex()).toEqual('#404040')
        end)

        test('at 0.5', function()
            expect(t(0.5):hex()).toEqual('#808080')
        end)

        test('at 0.75', function()
            expect(t(0.75):hex()).toEqual('#bfbfbf')
        end)

        test('ends in white', function()
            expect(t(1):hex()).toEqual('#ffffff')
        end)
    end)

    describe('red helix - saturation range', function()
        local t
        beforeEach(function()
            t = cubehelix(0, 1, { 1, 0 }, 1, { 0, 1 })
        end)

        test('starts in black', function()
            expect(t(0):hex()).toEqual('#000000')
        end)

        test('at 0.25', function()
            expect(t(0.25):hex()).toEqual('#324c21')
        end)

        test('at 0.5', function()
            expect(t(0.5):hex()).toEqual('#668a8f')
        end)

        test('at 0.75', function()
            expect(t(0.75):hex()).toEqual('#c4bbc9')
        end)

        test('ends in white', function()
            expect(t(1):hex()).toEqual('#ffffff')
        end)

        test('saturation decreases', function()
            expect(t(0.33):hsl()[2]).toBeGreaterThan(t(0.66):hsl()[2])
        end)
    end)

    describe('non-array lightness', function()
        local t
        beforeEach(function()
            t = cubehelix(300, -1.5, 1, 1, 0.5)
        end)

        test('start', function()
            expect(t(0):hex()).toEqual('#ae629f')
        end)

        test('at 0.5', function()
            expect(t(0.5):hex()).toEqual('#a07949')
        end)

        test('end', function()
            expect(t(1):hex()).toEqual('#519d60')
        end)
    end)
end)
