-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/color.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

describe('Some tests for chroma.color()', function()
    describe('named colors', function()
        local topic
        beforeEach(function()
            topic = chroma('red')
        end)

        test('hex', function()
            expect(topic:hex()).toEqual('#ff0000')
        end)

        test('rgb', function()
            expect(topic:rgb()).toEqual({ 255, 0, 0 })
        end)
    end)

    describe('hex colors', function()
        local topic
        beforeEach(function()
            topic = chroma('#f00')
        end)

        test('name', function()
            expect(topic:name()).toEqual('red')
        end)

        test('hex', function()
            expect(topic:hex()).toEqual('#ff0000')
        end)

        test('hex rgba', function()
            expect(topic:hex('rgba')).toEqual('#ff0000ff')
        end)

        test('hex argb', function()
            expect(topic:hex('argb')).toEqual('#ffff0000')
        end)

        test('rgb', function()
            expect(topic:rgb()).toEqual({ 255, 0, 0 })
        end)
    end)

    describe('hex color, no #', function()
        local topic
        beforeEach(function()
            topic = chroma('F00')
        end)

        test('name', function()
            expect(topic:name()).toEqual('red')
        end)

        test('hex', function()
            expect(topic:hex()).toEqual('#ff0000')
        end)

        test('rgb', function()
            expect(topic:rgb()).toEqual({ 255, 0, 0 })
        end)
    end)

    describe('css color rgb', function()
        local topic
        beforeEach(function()
            topic = chroma('rgb(255,0,0)')
        end)

        test('hex', function()
            expect(topic:hex()).toEqual('#ff0000')
        end)
    end)

    describe('rgba css color', function()
        local topic
        beforeEach(function()
            topic = chroma('rgba(128,0,128,0.5)')
        end)

        test('hex', function()
            expect(topic:hex()).toEqual('#80008080')
        end)

        test('hex rgb', function()
            expect(topic:hex('rgb')).toEqual('#800080')
        end)

        test('alpha', function()
            expect(topic:alpha()).toEqual(0.5)
        end)

        test('css', function()
            expect(topic:css()).toEqual('rgba(128,0,128,0.5)')
        end)
    end)

    describe('hsla css color', function()
        local topic
        beforeEach(function()
            topic = chroma('hsla(240,100%,50%,0.5)')
        end)

        test('hex', function()
            expect(topic:hex()).toEqual('#0000ff80')
        end)

        test('hex rgb', function()
            expect(topic:hex('rgb')).toEqual('#0000ff')
        end)

        test('alpha', function()
            expect(topic:alpha()).toEqual(0.5)
        end)

        test('css', function()
            expect(topic:css()).toEqual('rgba(0,0,255,0.5)')
        end)
    end)

    describe('hsla color', function()
        local topic
        beforeEach(function()
            topic = chroma('lightsalmon')
        end)

        test('css (default)', function()
            expect(topic:css()).toEqual('rgb(255,160,122)')
        end)

        test('css (rgb)', function()
            expect(topic:css('rgb')).toEqual('rgb(255,160,122)')
        end)

        test('css (hsl)', function()
            expect(chroma(topic:css('hsl')):name()).toEqual('lightsalmon')
        end)

        test('css (rgb-css)', function()
            expect(chroma(topic:css('rgb')):name()).toEqual('lightsalmon')
        end)
    end)

    describe('rgb color', function()
        local topic
        beforeEach(function()
            topic = chroma(255, 0, 0)
        end)

        test('hex', function()
            expect(topic:hex()).toEqual('#ff0000')
        end)
    end)

    describe('hsv black', function()
        local topic
        beforeEach(function()
            topic = chroma('black'):hsv()
        end)

        test('hue is NaN', function()
            expect(topic[1]).toBeNaN()
        end)

        test('but hue is defined', function()
            expect(topic[1]).toBeDefined()
        end)
    end)

    describe('hsv black', function()
        local topic
        beforeEach(function()
            topic = chroma('black'):hsv()
        end)

        test('hue is NaN', function()
            expect(topic[1]).toBeNaN()
        end)

        test('but hue is defined', function()
            expect(topic[1]).toBeDefined()
        end)
    end)

    describe('hsl black', function()
        local topic
        beforeEach(function()
            topic = chroma('black'):hsl()
        end)

        test('hue is NaN', function()
            expect(topic[1]).toBeNaN()
        end)

        test('but hue is defined', function()
            expect(topic[1]).toBeDefined()
        end)

        test('sat is 0', function()
            expect(topic[2]).toEqual(0)
        end)

        test('lightness is 0', function()
            expect(topic[3]).toEqual(0)
        end)
    end)

    describe('constructing with array, but no mode', function()
        local topic
        beforeEach(function()
            topic = chroma({ 255, 0, 0 })
        end)

        test('falls back to rgb', function()
            expect(topic:hex()).toEqual(chroma({ 255, 0, 0 }, 'rgb'):hex())
        end)
    end)

    describe('num color', function()
        local topic
        beforeEach(function()
            topic = {
                chroma(0xff0000),
                chroma(0x000000),
                chroma(0xffffff),
                chroma(0x31ff98),
                chroma('red'),
            }
        end)

        test('hex', function()
            expect(topic[1]:hex()).toEqual('#ff0000')
        end)

        test('num', function()
            expect(topic[1]:num()).toEqual(0xff0000)
        end)

        test('hex-black', function()
            expect(topic[2]:hex()).toEqual('#000000')
        end)

        test('num-black', function()
            expect(topic[2]:num()).toEqual(0x000000)
        end)

        test('hex-white', function()
            expect(topic[3]:hex()).toEqual('#ffffff')
        end)

        test('num-white', function()
            expect(topic[3]:num()).toEqual(0xffffff)
        end)

        test('hex-rand', function()
            expect(topic[4]:hex()).toEqual('#31ff98')
        end)

        test('num-rand', function()
            expect(topic[4]:num()).toEqual(0x31ff98)
        end)

        test('rum-red', function()
            expect(topic[5]:num()).toEqual(0xff0000)
        end)
    end)
end)
