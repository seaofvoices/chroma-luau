-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/luminance.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../../init')
local mathRound = require('../../utils/round.roblox.luau')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

local function rnd(f: number, d: number): number
    d = math.pow(10, d)
    return mathRound(f * d) / d
end

describe('Testing relative luminance', function()
    describe('black', function()
        local topic
        beforeEach(function()
            topic = chroma('black')
        end)

        test('lum = 0', function()
            expect(topic:luminance()).toEqual(0)
        end)
    end)

    describe('white', function()
        local topic
        beforeEach(function()
            topic = chroma('white')
        end)

        test('lum = 1', function()
            expect(topic:luminance()).toEqual(1)
        end)
    end)

    describe('red', function()
        local topic
        beforeEach(function()
            topic = chroma('red')
        end)

        test('lum = 0.21', function()
            expect(topic:luminance()).toEqual(0.2126)
        end)
    end)

    describe('yellow brighter than blue', function()
        local topic
        beforeEach(function()
            topic = { chroma('yellow'):luminance(), chroma('blue'):luminance() }
        end)

        test('yellow > blue', function()
            expect(topic[1]).toBeGreaterThan(topic[2])
        end)
    end)

    describe('green darker than red', function()
        local topic
        beforeEach(function()
            topic = { chroma('green'):luminance(), chroma('red'):luminance() }
        end)

        test('green < red', function()
            expect(topic[1]).toBeLessThan(topic[2])
        end)
    end)

    -- setting luminance
    describe('set red luminance to 0.4', function()
        local topic
        beforeEach(function()
            topic = chroma('red'):luminance(0.4)
        end)

        test('lum = 0.4', function()
            expect(rnd(topic:luminance(), 3)).toEqual(0.4)
        end)
    end)

    -- setting luminance
    describe('set red luminance to 0', function()
        local topic
        beforeEach(function()
            topic = chroma('red'):luminance(0)
        end)

        test('lum = 0', function()
            expect(rnd(topic:luminance(), 2)).toEqual(0)
        end)

        test('hex = #000', function()
            expect(topic:hex()).toEqual('#000000')
        end)
    end)

    -- setting luminance
    describe('set black luminance to 0.5', function()
        local topic
        beforeEach(function()
            topic = chroma('black'):luminance(0.5)
        end)

        test('lum = 0.5', function()
            expect(rnd(topic:luminance(), 2)).toEqual(0.5)
        end)

        test('hex', function()
            expect('#bcbcbc').toEqual(topic:hex())
        end)
    end)

    -- setting luminance
    describe('set black luminance to 0.5 (lab)', function()
        local topic
        beforeEach(function()
            topic = chroma('black'):luminance(0.5, 'lab')
        end)

        test('lum = 0.5', function()
            expect(rnd(topic:luminance(), 2)).toEqual(0.5)
        end)

        test('hex', function()
            expect('#bcbcbc').toEqual(topic:hex())
        end)
    end)

    describe('setting luminance returns new color', function()
        local topic
        beforeEach(function()
            topic = chroma('red')
        end)

        test('red luminance is 0.21', function()
            expect(rnd(topic:luminance(), 2)).toEqual(0.21)
        end)

        test('set luminance to 0.4', function()
            expect(topic:luminance(0.4):hex()).toEqual('#ff8686')
        end)

        test('old luminance is still 0.21', function()
            expect(rnd(topic:luminance(), 2)).toEqual(0.21)
        end)

        test('old color is still red', function()
            expect(topic:hex()).toEqual('#ff0000')
        end)
    end)
end)
