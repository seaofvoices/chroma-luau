-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/alpha.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

describe('Tests for the alpha channel', function()
    describe('setting & getting alpha channel', function()
        local topic

        beforeEach(function()
            topic = chroma('red')
        end)

        test('no arguments gets alpha', function()
            expect(topic:alpha()).toEqual(1)
        end)

        test('setting alpha to 0.5', function()
            expect(topic:alpha(0.5):alpha()).toEqual(0.5)
        end)

        test('alpha is unchanged', function()
            expect(topic:alpha()).toEqual(1)
        end)
    end)

    describe('interpolating alpha channel', function()
        local topic

        beforeEach(function()
            topic = chroma.mix(chroma('white'):alpha(0), chroma('black'):alpha(1), 0.3, 'rgb')
        end)

        test('hex is #b3b3b3', function()
            expect(topic:hex('rgb')).toEqual('#b3b3b3')
        end)

        test('hex with alpha', function()
            expect(topic:hex()).toEqual('#b3b3b34d')
        end)

        test('alpha is 30%', function()
            expect(topic:alpha()).toEqual(0.3)
        end)
    end)

    describe('constructing rgba color', function()
        local topic

        beforeEach(function()
            topic = chroma.Color.new(255, 0, 0, 0.5, 'rgb')
        end)

        test('alpha is 50%', function()
            expect(topic:alpha()).toEqual(0.5)
        end)
    end)

    describe('constructing rgba color, rgb shorthand', function()
        local topic

        beforeEach(function()
            topic = chroma.rgb(255, 0, 0, 0.5)
        end)

        test('alpha is 50%', function()
            expect(topic:alpha()).toEqual(0.5)
        end)
    end)

    describe('constructing rgba color, hsl shorthand', function()
        local topic

        beforeEach(function()
            topic = chroma.hsl(0, 1, 0.5):alpha(0.5)
        end)

        test('color is red', function()
            expect(topic:name()).toEqual('red')
        end)

        test('alpha is 50%', function()
            expect(topic:alpha()).toEqual(0.5)
        end)
    end)

    describe('parsing hex rgba colors', function()
        local topic

        beforeEach(function()
            topic = chroma('#ff00004d')
        end)

        test('color is red', function()
            expect(topic:name()).toEqual('red')
        end)

        test('alpha is 30%', function()
            expect(topic:alpha()).toEqual(0.3)
        end)

        test('rgba output', function()
            expect(topic:rgba()).toEqual({ 255, 0, 0, 0.3 })
        end)
    end)

    describe('parsing rgba colors', function()
        local topic

        beforeEach(function()
            topic = chroma.css('rgba(255,0,0,.3)')
        end)

        test('color is red', function()
            expect(topic:name()).toEqual('red')
        end)

        test('alpha is 30%', function()
            expect(topic:alpha()).toEqual(0.3)
        end)

        test('rgba output', function()
            expect(topic:rgba()).toEqual({ 255, 0, 0, 0.3 })
        end)
    end)

    describe('parsing rgba colors (percentage)', function()
        local topic

        beforeEach(function()
            topic = chroma.css('rgba(100%,0%,0%,0.2)')
        end)

        test('color is red', function()
            expect(topic:name()).toEqual('red')
        end)

        test('alpha is 20%', function()
            expect(topic:alpha()).toEqual(0.2)
        end)

        test('rgb output', function()
            expect(topic:rgb()).toEqual({ 255, 0, 0 })
        end)

        test('rgba output', function()
            expect(topic:rgba()).toEqual({ 255, 0, 0, 0.2 })
        end)
    end)

    describe('parsing hsla colors', function()
        local topic

        beforeEach(function()
            topic = chroma.css('hsla(0,100%,50%,0.25)')
        end)

        test('color is red', function()
            expect(topic:name()).toEqual('red')
        end)

        test('alpha is 25%', function()
            expect(topic:alpha()).toEqual(0.25)
        end)

        test('rgb output', function()
            expect(topic:rgb()).toEqual({ 255, 0, 0 })
        end)

        test('rgba output', function()
            expect(topic:rgba()).toEqual({ 255, 0, 0, 0.25 })
        end)
    end)

    describe('constructing hsla color', function()
        local topic

        beforeEach(function()
            topic = chroma(0, 1, 0.5, 0.25, 'hsl')
        end)

        test('color is red', function()
            expect(topic:name()).toEqual('red')
        end)

        test('alpha is 25%', function()
            expect(topic:alpha()).toEqual(0.25)
        end)
    end)

    describe('constructing hsva color', function()
        local topic

        beforeEach(function()
            topic = chroma(0, 1, 1, 0.25, 'hsv')
        end)

        test('color is red', function()
            expect(topic:name()).toEqual('red')
        end)

        test('alpha is 25%', function()
            expect(topic:alpha()).toEqual(0.25)
        end)
    end)

    describe('constructing hsia color', function()
        local topic

        beforeEach(function()
            topic = chroma(0, 1, 0.3333334, 0.25, 'hsi')
        end)

        test('color is red', function()
            expect(topic:name()).toEqual('red')
        end)

        test('alpha is 25%', function()
            expect(topic:alpha()).toEqual(0.25)
        end)
    end)

    describe('constructing laba color', function()
        local topic

        beforeEach(function()
            topic = chroma(53.24079414130722, 80.09245959641109, 67.20319651585301, 0.25, 'lab')
        end)

        test('color is red', function()
            expect(topic:name()).toEqual('red')
        end)

        test('alpha is 25%', function()
            expect(topic:alpha()).toEqual(0.25)
        end)
    end)

    describe('constructing lcha color', function()
        local topic

        beforeEach(function()
            topic = chroma(53.24079414130722, 104.55176567686985, 39.99901061253297, 0.25, 'lch')
        end)

        test('color is red', function()
            expect(topic:name()).toEqual('red')
        end)

        test('alpha is 25%', function()
            expect(topic:alpha()).toEqual(0.25)
        end)
    end)

    describe('constructing cmyka color', function()
        local topic

        beforeEach(function()
            topic = chroma(0, 1, 1, 0, 0.25, 'cmyk')
        end)

        test('color is red', function()
            expect(topic:name()).toEqual('red')
        end)

        test('alpha is 25%', function()
            expect(topic:alpha()).toEqual(0.25)
        end)
    end)

    describe('gl output', function()
        local topic

        beforeEach(function()
            topic = chroma.gl(1, 0, 0, 0.25)
        end)

        test('color is red', function()
            expect(topic:name()).toEqual('red')
        end)

        test('alpha is 25%', function()
            expect(topic:alpha()).toEqual(0.25)
        end)

        test('gloutput', function()
            expect(topic:gl()).toEqual({ 1, 0, 0, 0.25 })
        end)
    end)

    describe('rgba css output', function()
        local topic

        beforeEach(function()
            topic = chroma.css('hsla(0,100%,50%,0.25)')
        end)

        test('cssoutput', function()
            expect(topic:css()).toEqual('rgba(255,0,0,0.25)')
        end)
    end)

    describe('hex output', function()
        local topic

        beforeEach(function()
            topic = chroma.gl(1, 0, 0, 0.25)
        end)

        test('hex', function()
            expect(topic:hex()).toEqual('#ff000040')
        end)

        test('rgb', function()
            expect(topic:hex('rgb')).toEqual('#ff0000')
        end)

        test('rgba', function()
            expect(topic:hex('rgba')).toEqual('#ff000040')
        end)

        test('argb', function()
            expect(topic:hex('argb')).toEqual('#40ff0000')
        end)
    end)

    describe('num output', function()
        local topic

        beforeEach(function()
            topic = chroma.gl(1, 0, 0, 0.25)
        end)

        test('num ignores alpha', function()
            expect(topic:num()).toEqual(0xff0000)
        end)
    end)

    describe('setting alpha returns new instance', function()
        local topic

        beforeEach(function()
            topic = chroma('red')
        end)

        test('set alpha to 0.5', function()
            topic:alpha(0.5)
            expect(topic:alpha()).toEqual(1)
        end)
    end)
end)
