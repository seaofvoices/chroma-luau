-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/manipulate.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

describe('Some tests for chroma.color()', function()
    describe('modify colors', function()
        local topic

        beforeEach(function()
            topic = chroma('#ff0000')
        end)

        test('darken', function()
            expect(topic:darken():hex()).toEqual('#c20000')
        end)

        test('darker', function()
            expect(topic:darker():hex()).toEqual('#c20000')
        end)

        test('darken more', function()
            expect(topic:darker(2):hex()).toEqual('#890000')
        end)

        test('darken too much', function()
            expect(topic:darker(10):hex()).toEqual('#000000')
        end)

        test('brighten', function()
            expect(topic:brighten():hex()).toEqual('#ff5a36')
        end)

        test('brighten too much', function()
            expect(topic:brighten(10):hex()).toEqual('#ffffff')
        end)

        test('brighter', function()
            expect(topic:brighter():hex()).toEqual('#ff5a36')
        end)

        test('saturate', function()
            expect(topic:saturate():hex()).toEqual('#ff0000')
        end)

        test('desaturate', function()
            expect(topic:desaturate():hex()).toEqual('#ee3a20')
        end)

        test('desaturate more', function()
            expect(topic:desaturate(2):hex()).toEqual('#db5136')
        end)

        test('desaturate too much', function()
            expect(topic:desaturate(400):hex()).toEqual('#7f7f7f')
        end)
    end)

    describe('premultiply', function()
        local topic

        beforeEach(function()
            topic = chroma('rgba(32, 48, 96, 0.5)')
        end)

        test('premultiply rgba', function()
            expect(topic:premultiply():rgba()).toEqual({ 16, 24, 48, 0.5 })
        end)

        test('premultiply hex', function()
            expect(topic:premultiply():hex()).toEqual('#10183080')
        end)

        test('premultiply hex rgb', function()
            expect(topic:premultiply():hex('rgb')).toEqual('#101830')
        end)

        test('premultiply num', function()
            expect(topic:premultiply():num()).toEqual(0x101830)
        end)
    end)
end)
