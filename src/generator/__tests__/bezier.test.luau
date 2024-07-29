-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/bezier.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

describe('Testing bezier interpolation', function()
    describe('simple two color linear interpolation', function()
        local topic
        beforeEach(function()
            topic = { f = chroma.bezier({ 'white', 'black' }) }
        end)

        test('starts from white', function()
            expect(topic.f(0):hex()).toEqual('#ffffff')
        end)

        test('ends in black', function()
            expect(topic.f(1):hex()).toEqual('#000000')
        end)

        test('center is grey', function()
            expect(topic.f(0.5):hex()).toEqual('#777777')
        end)
    end)

    describe('three color quadratic bezier interpolation', function()
        local topic
        beforeEach(function()
            topic = { f = chroma.bezier({ 'white', 'red', 'black' }) }
        end)

        test('starts from white', function()
            expect(topic.f(0):hex()).toEqual('#ffffff')
        end)

        test('ends in black', function()
            expect(topic.f(1):hex()).toEqual('#000000')
        end)

        test('center is a greyish red', function()
            expect(topic.f(0.5):hex()).toEqual('#c45c44')
        end)
    end)

    describe('four color cubic bezier interpolation', function()
        local topic
        beforeEach(function()
            topic = { f = chroma.bezier({ 'white', 'yellow', 'red', 'black' }) }
        end)

        test('starts from white', function()
            expect(topic.f(0):hex()).toEqual('#ffffff')
        end)

        test('ends in black', function()
            expect(topic.f(1):hex()).toEqual('#000000')
        end)

        test('1st quarter', function()
            expect(topic.f(0.25):hex()).toEqual('#ffe085')
        end)

        test('center', function()
            expect(topic.f(0.5):hex()).toEqual('#e69735')
        end)

        test('3rd quarter', function()
            expect(topic.f(0.75):hex()).toEqual('#914213')
        end)
    end)

    describe('five color diverging quadratic bezier interpolation', function()
        local topic
        beforeEach(function()
            topic = {
                f = chroma.bezier({ 'darkred', 'orange', 'snow', 'lightgreen', 'royalblue' }),
            }
        end)

        test('starts from darkred', function()
            expect(topic.f(0):hex()).toEqual('#8b0000')
        end)

        test('ends in royalblue', function()
            expect(topic.f(1):hex()).toEqual('#4169e1')
        end)

        test('center is snow', function()
            expect(topic.f(0.5):hex()).toEqual('#dfcb98')
        end)

        test('1st quarter', function()
            expect(topic.f(0.25):hex()).toEqual('#dd8d49')
        end)

        test('3rd quarter', function()
            expect(topic.f(0.75):hex()).toEqual('#a7c1bd')
        end)
    end)

    describe('using bezier in a chroma.scale', function()
        local topic
        beforeEach(function()
            topic = {
                f = chroma
                    .scale(chroma.bezier({ 'darkred', 'orange', 'snow', 'lightgreen', 'royalblue' }))
                    -- deviation: remove unused parameter
                    .domain({ 0, 1 })
                    .out('hex'),
            }
        end)

        test('starts from darkred', function()
            expect(topic.f(0)).toEqual('#8b0000')
        end)

        test('ends in royalblue', function()
            expect(topic.f(1)).toEqual('#4169e1')
        end)

        test('center is snow', function()
            expect(topic.f(0.5)).toEqual('#dfcb98')
        end)

        test('1st quarter', function()
            expect(topic.f(0.25)).toEqual('#dd8d49')
        end)

        test('3rd quarter', function()
            expect(topic.f(0.75)).toEqual('#a7c1bd')
        end)
    end)
end)
