-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/lch.test.js
local Collections = require('@pkg/@jsdotlua/collections')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../../init')

local Array = Collections.Array
local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

describe('Some tests for chroma.lch()', function()
    describe('lch grayscale', function()
        local t

        beforeEach(function()
            t = Array.map({ 0, 100, 25, 50, 75 }, function(l)
                return { l, 0, 0 }
            end)
        end)

        test('black', function()
            expect(chroma.lch(t[1]):hex()).toEqual('#000000')
        end)

        test('white', function()
            expect(chroma.lch(t[2]):hex()).toEqual('#ffffff')
        end)

        test('gray 1', function()
            expect(chroma.lch(t[3]):hex()).toEqual('#3b3b3b')
        end)

        test('gray 2', function()
            expect(chroma.lch(t[4]):hex()).toEqual('#777777')
        end)

        test('gray 3', function()
            expect(chroma.lch(t[5]):hex()).toEqual('#b9b9b9')
        end)
    end)

    describe('lch hues', function()
        local t

        beforeEach(function()
            t = Array.map({ 0, 60, 120, 180, 240, 300 }, function(h)
                return { 50, 70, h }
            end)
        end)

        test('red-ish', function()
            expect(chroma.lch(t[1]):hex()).toEqual('#dc2c7a')
        end)

        test('yellow-ish', function()
            expect(chroma.lch(t[2]):hex()).toEqual('#bd5c00')
        end)

        test('green-ish', function()
            expect(chroma.lch(t[3]):hex()).toEqual('#548400')
        end)

        test('teal-ish', function()
            expect(chroma.lch(t[4]):hex()).toEqual('#009175')
        end)

        test('blue-ish', function()
            expect(chroma.lch(t[5]):hex()).toEqual('#008cde')
        end)

        test('purple-ish', function()
            expect(chroma.lch(t[6]):hex()).toEqual('#6f67df')
        end)
    end)

    describe('clipping', function()
        local t

        beforeEach(function()
            t = Array.map({ 20, 40, 60, 80, 100 }, function(l)
                return chroma.hcl(50, 40, l)
            end)
        end)

        test('20-clipped', function()
            expect(t[1]:clipped()).toEqual(true)
        end)

        test('40-not clipped', function()
            expect(t[2]:clipped()).toEqual(false)
        end)

        test('60-not clipped', function()
            expect(t[3]:clipped()).toEqual(false)
        end)

        test('80-clipped', function()
            expect(t[4]:clipped()).toEqual(true)
        end)

        test('100-clipped', function()
            expect(t[5]:clipped()).toEqual(true)
        end)
    end)
end)
