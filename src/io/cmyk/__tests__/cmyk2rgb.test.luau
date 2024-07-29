-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/cmyk2rgb.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local cmyk2rgb = require('../cmyk2rgb')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

describe('Testing CMYK color conversions', function()
    describe('parse simple CMYK colors', function()
        local t = {
            { 0, 0, 0, 1 },
            { 0, 0, 0, 0 },
            { 0, 1, 1, 0 },
            { 1, 0, 1, 0 },
            { 1, 1, 0, 0 },
            { 0, 0, 1, 0 },
            { 1, 0, 0, 0 },
            { 0, 1, 0, 0 },
        }

        test('black', function()
            expect(cmyk2rgb(t[1])).toEqual({ 0, 0, 0, 1 })
        end)
        test('white', function()
            expect(cmyk2rgb(t[2])).toEqual({ 255, 255, 255, 1 })
        end)
        test('red', function()
            expect(cmyk2rgb(t[3])).toEqual({ 255, 0, 0, 1 })
        end)
        test('green', function()
            expect(cmyk2rgb(t[4])).toEqual({ 0, 255, 0, 1 })
        end)
        test('blue', function()
            expect(cmyk2rgb(t[5])).toEqual({ 0, 0, 255, 1 })
        end)
        test('yellow', function()
            expect(cmyk2rgb(t[6])).toEqual({ 255, 255, 0, 1 })
        end)
        test('cyan', function()
            expect(cmyk2rgb(t[7])).toEqual({ 0, 255, 255, 1 })
        end)
        test('magenta', function()
            expect(cmyk2rgb(t[8])).toEqual({ 255, 0, 255, 1 })
        end)
    end)

    describe('test unpacked arguments', function()
        local t = {
            { 0, 0, 0, 1 },
            { 0, 0, 0, 0 },
            { 0, 1, 1, 0 },
            { 1, 0, 1, 0 },
            { 1, 1, 0, 0 },
            { 0, 0, 1, 0 },
            { 1, 0, 0, 0 },
            { 0, 1, 0, 0 },
        }

        test('black', function()
            expect(cmyk2rgb(unpack(t[1]))).toEqual({ 0, 0, 0, 1 })
        end)
        test('white', function()
            expect(cmyk2rgb(unpack(t[2]))).toEqual({ 255, 255, 255, 1 })
        end)
        test('red', function()
            expect(cmyk2rgb(unpack(t[3]))).toEqual({ 255, 0, 0, 1 })
        end)
        test('green', function()
            expect(cmyk2rgb(unpack(t[4]))).toEqual({ 0, 255, 0, 1 })
        end)
        test('blue', function()
            expect(cmyk2rgb(unpack(t[5]))).toEqual({ 0, 0, 255, 1 })
        end)
        test('yellow', function()
            expect(cmyk2rgb(unpack(t[6]))).toEqual({ 255, 255, 0, 1 })
        end)
        test('cyan', function()
            expect(cmyk2rgb(unpack(t[7]))).toEqual({ 0, 255, 255, 1 })
        end)
        test('magenta', function()
            expect(cmyk2rgb(unpack(t[8]))).toEqual({ 255, 0, 255, 1 })
        end)
    end)
end)
