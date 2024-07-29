-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/num.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

describe('Some tests for chroma.num()', function()
    describe('number output', function()
        local topic
        beforeEach(function()
            topic = chroma.hsl(0, 1, 0.5, 0.5)
        end)

        test('numoutput', function()
            expect(topic:num()).toEqual(0xff0000)
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
