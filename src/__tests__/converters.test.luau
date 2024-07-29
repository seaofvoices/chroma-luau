-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/converters.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

describe('Testing color conversions', function()
    for k in chroma.colors :: { [string]: string } do
        describe(k, function()
            local t

            beforeEach(function()
                t = chroma.colors[k]
            end)

            test('to hsl and back', function()
                expect(chroma.hsl(chroma(t):hsl()):hex()).toEqual(t)
            end)

            test('to cmyk and back', function()
                expect(chroma.cmyk(chroma(t):cmyk()):hex()).toEqual(t)
            end)

            test('to css and back', function()
                expect(chroma.css(chroma(t):css()):hex()).toEqual(t)
            end)

            test('to hsi and back', function()
                expect(chroma.hsi(chroma(t):hsi()):hex()).toEqual(t)
            end)

            test('to hsv and back', function()
                expect(chroma.hsv(chroma(t):hsv()):hex()).toEqual(t)
            end)

            test('to lab and back', function()
                expect(chroma.lab(chroma(t):lab()):hex()).toEqual(t)
            end)

            test('to oklab and back', function()
                expect(chroma.oklab(chroma(t):oklab()):hex()).toEqual(t)
            end)

            test('to lch and back', function()
                expect(chroma.lch(chroma(t):lch()):hex()).toEqual(t)
            end)

            test('to oklch and back', function()
                expect(chroma.oklch(chroma(t):oklch()):hex()).toEqual(t)
            end)

            test('to num and back', function()
                expect(chroma.num(chroma(t):num()):hex()).toEqual(t)
            end)
        end)
    end
end)
