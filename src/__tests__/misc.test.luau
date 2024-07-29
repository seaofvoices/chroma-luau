-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/misc.test.js
local Collections = require('@pkg/@jsdotlua/collections')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../init')
local mathRound = require('../utils/round.roblox.luau')

local Array = Collections.Array
local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

local function round(digits: number): (number) -> number
    local d = math.pow(10, digits)
    return function(v: number): number
        return mathRound(v * d) / d
    end
end

describe('Some tests for chroma.color()', function()
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

    describe('toString', function()
        local topic

        beforeEach(function()
            topic = chroma('greenyellow')
        end)

        test('explicit', function()
            expect(tostring(topic)).toEqual('#adff2f')
        end)

        -- deviation: add another test case for calling the toString method directly
        test('explicit2', function()
            expect(topic:toString()).toEqual('#adff2f')
        end)

        -- deviation: in Luau this will cause an error 'attempt to concatenate string with table'
        -- test('implicit', function()
        --     expect('' .. topic :: any).toEqual('#adff2f')
        -- end)
    end)

    describe('constructing numeric color', function()
        local topic

        beforeEach(function()
            topic = chroma.num(0xadff2f)
        end)

        test('color is red', function()
            expect(topic:name()).toEqual('greenyellow')
        end)

        test('alpha is 100%', function()
            expect(topic:alpha()).toEqual(1)
        end)
    end)

    describe('normalize hue', function()
        local topic

        beforeEach(function()
            topic = chroma.rgb(0, 255, 255):lch()
        end)

        test('hue > 0', function()
            expect(topic[3] >= 0)
        end)

        test('hue < 360', function()
            expect(topic[3] <= 360)
        end)
    end)

    describe('lab conversion red', function()
        local topic

        beforeEach(function()
            topic = Array.map(chroma('red'):lab(), round(3))
        end)

        test('is right', function()
            expect(topic).toEqual({ 53.241, 80.092, 67.203 })
        end)
    end)

    describe('lab conversion blue', function()
        local topic

        beforeEach(function()
            topic = Array.map(chroma('blue'):lab(), round(3))
        end)

        test('is right', function()
            expect(topic).toEqual({ 32.297, 79.188, -107.86 })
        end)
    end)

    describe('lab conversion green', function()
        local topic

        beforeEach(function()
            topic = Array.map(chroma('green'):lab(), round(3))
        end)

        test('is right', function()
            expect(topic).toEqual({ 46.227, -51.698, 49.897 })
        end)
    end)

    describe('lab conversion yellow', function()
        local topic

        beforeEach(function()
            topic = Array.map(chroma('yellow'):lab(), round(3))
        end)

        test('is right', function()
            expect(topic).toEqual({ 97.139, -21.554, 94.478 })
        end)
    end)

    describe('lab conversion magenta', function()
        local topic

        beforeEach(function()
            topic = Array.map(chroma('magenta'):lab(), round(3))
        end)

        test('is right', function()
            expect(topic).toEqual({ 60.324, 98.234, -60.825 })
        end)
    end)

    describe('hueless css hsl colors', function()
        local topic

        beforeEach(function()
            topic = { chroma('black'), chroma('gray'), chroma('white') }
        end)

        test('black', function()
            expect(topic[1]:css('hsl')).toEqual('hsl(0,0%,0%)')
        end)

        test('gray', function()
            expect(topic[2]:css('hsl')).toEqual('hsl(0,0%,50.2%)')
        end)

        test('white', function()
            expect(topic[3]:css('hsl')).toEqual('hsl(0,0%,100%)')
        end)
    end)

    describe('hcl.h is NaN for hue-less colors', function()
        local topic

        beforeEach(function()
            topic = { chroma('black'), chroma('gray'), chroma('white') }
        end)

        test('black', function()
            expect(topic[1]:hcl()[1]).toBeNaN()
        end)

        test('gray', function()
            expect(topic[2]:hcl()[1]).toBeNaN()
        end)

        test('white', function()
            expect(topic[3]:hcl()[1]).toBeNaN()
        end)
    end)

    describe('lab-rgb precision', function()
        local topic

        beforeEach(function()
            topic = { 74, 24, 78 }
        end)

        test('to_rgb_to_lab', function()
            expect(Array.map(chroma.rgb(chroma.lab(topic):rgb(false)):lab(), round(3))).toEqual(
                topic
            )
        end)
    end)

    describe('cmyk-rgb precision', function()
        local topic

        beforeEach(function()
            topic = { 0, 1, 1, 0.02 }
        end)

        test('to_rgb_to_cmyk', function()
            expect(Array.map(chroma.rgb(chroma.cmyk(topic):rgb(false)):cmyk(), round(3))).toEqual(
                topic
            )
        end)
    end)

    describe('auto-detect rgba in hex output', function()
        local topic

        beforeEach(function()
            topic = { 'rgba(255,0,0,1)', 'rgba(255,0,0,0.5)' }
        end)

        test('rgb if alpha == 1', function()
            expect(chroma(topic[1]):hex()).toEqual('#ff0000')
        end)
        test('rgba if alpha != 1', function()
            expect(chroma(topic[2]):hex()).toEqual('#ff000080')
        end)
    end)
end)
