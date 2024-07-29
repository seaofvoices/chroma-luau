-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/mix.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

describe('Some tests for chroma.color()', function()
    describe('hsv interpolation white <-> red', function()
        local topic
        beforeEach(function()
            topic = chroma('white'):interpolate('red', 0.5, 'hsv')
        end)

        test('works', function()
            expect(topic:hex()).toEqual('#ff8080')
        end)
    end)

    describe('use mix as alias', function()
        local topic
        beforeEach(function()
            topic = chroma('white'):mix('red', 0.5, 'hsv')
        end)

        test('works', function()
            expect(topic:hex()).toEqual('#ff8080')
        end)
    end)

    describe('alternative mix syntax', function()
        local topic
        beforeEach(function()
            topic = chroma.mix('red', 'blue', 0.25, 'rgb')
        end)

        test('works', function()
            expect(topic:hex()).toEqual('#bf0040')
        end)
    end)

    describe('hsl interpolation white <-> red', function()
        local topic
        beforeEach(function()
            topic = chroma('white'):interpolate('red', 0.5, 'hsl')
        end)

        test('works', function()
            expect(topic:hex()).toEqual('#ff8080')
        end)
    end)

    describe('rgb interpolation white <-> red', function()
        local topic
        beforeEach(function()
            topic = chroma('white'):interpolate('red', 0.5, 'rgb')
        end)

        test('works', function()
            expect(topic:hex()).toEqual('#ff8080')
        end)
    end)

    describe('hsv interpolation red <-> white', function()
        local topic
        beforeEach(function()
            topic = chroma('red'):interpolate('white', 0.5, 'hsv')
        end)

        test('works', function()
            expect(topic:hex()).toEqual('#ff8080')
        end)
    end)

    describe('hsl interpolation red <-> white', function()
        local topic
        beforeEach(function()
            topic = chroma('red'):interpolate('white', 0.5, 'hsl')
        end)

        test('works', function()
            expect(topic:hex()).toEqual('#ff8080')
        end)
    end)

    describe('rgb interpolation red <-> white', function()
        local topic
        beforeEach(function()
            topic = chroma('red'):interpolate('white', 0.5, 'rgb')
        end)

        test('works', function()
            expect(topic:hex()).toEqual('#ff8080')
        end)
    end)

    describe('interpolation short function', function()
        local function topic(t)
            return chroma.interpolate('#ff0000', '#ffffff', t, 'hsv'):hex()
        end

        test('starts at red', function()
            expect(topic(0)).toEqual('#ff0000')
        end)

        test('goes over light red', function()
            expect(topic(0.5)).toEqual('#ff8080')
        end)

        test('ends at white', function()
            expect(topic(1)).toEqual('#ffffff')
        end)
    end)

    describe('num interpolation white <-> red', function()
        local topic
        beforeEach(function()
            topic = chroma(0xffffff):interpolate(0xff0000, 0.5, 'num')
        end)

        test('works', function()
            expect(topic:hex()).toEqual('#ff7fff')
        end)
    end)

    describe('num interpolation red <-> white', function()
        local topic
        beforeEach(function()
            topic = chroma(0xff0000):interpolate(0xffffff, 0.5, 'num')
        end)

        test('works', function()
            expect(topic:hex()).toEqual('#ff7fff')
        end)
    end)

    describe('interpolation short function with num provided', function()
        local function topic(t)
            return chroma.interpolate(0xff0000, 0xffffff, t, 'num'):hex()
        end

        test('starts at red', function()
            expect(topic(0)).toEqual('#ff0000')
        end)

        test('goes over light red', function()
            expect(topic(0.5)).toEqual('#ff7fff')
        end)

        test('ends at white', function()
            expect(topic(1)).toEqual('#ffffff')
        end)
    end)

    describe('interpolate in num', function()
        local topic
        beforeEach(function()
            topic = chroma.interpolate(chroma.num(0xffffe0), chroma.num(0x102180), 0.5, 'num')
        end)

        test('hex', function()
            expect(topic:hex()).toEqual('#8810b0')
        end)

        test('num', function()
            expect(topic:num()).toEqual(8917168)
        end)
    end)

    describe('interpolate in hsv', function()
        local topic
        beforeEach(function()
            topic = chroma.interpolate('white', 'black', 0.5, 'hsv')
        end)

        test('hex', function()
            expect(topic:hex()).toEqual('#808080')
        end)
    end)

    describe('interpolate in hsl', function()
        local topic
        beforeEach(function()
            topic = chroma.interpolate('lightyellow', 'navy', 0.5, 'hsl')
        end)

        test('hex', function()
            expect(topic:hex()).toEqual('#31ff98')
        end)
    end)

    describe('interpolate in lrgb', function()
        local topic
        beforeEach(function()
            topic = chroma.interpolate('red', 'blue', 0.5, 'lrgb')
        end)

        test('hex', function()
            expect(topic:hex()).toEqual('#b400b4')
        end)
    end)
end)
