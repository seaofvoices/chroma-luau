-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/scale.lcorrection.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../init')
local mathRound = require('../utils/round.roblox.luau')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

describe('Testing lightess correction', function()
    describe('simple two color linear interpolation', function()
        local topic
        beforeEach(function()
            topic = { f = chroma.scale({ 'white', 'black' }).mode('lab') }
        end)

        test('center L is 50', function()
            expect(mathRound(topic.f(0.5):lab()[1])).toEqual(50)
        end)
    end)

    describe('hot - w/o correction', function()
        local topic
        beforeEach(function()
            topic = { f = chroma.scale({ 'white', 'yellow', 'red', 'black' }).mode('lab') }
        end)

        test('center L is 74', function()
            expect(mathRound(topic.f(0.5):lab()[1])).toEqual(74)
        end)
    end)

    describe('hot - with correction', function()
        local topic
        beforeEach(function()
            topic = {
                f = chroma
                    .scale({ 'white', 'yellow', 'red', 'black' })
                    .mode('lab')
                    .correctLightness(true),
            }
        end)

        test('center L is 50', function()
            expect(mathRound(topic.f(0.5):lab()[1])).toEqual(50)
        end)
    end)

    describe('hot - w/o correction - domained [0,100]', function()
        local topic
        beforeEach(function()
            topic = {
                f = chroma
                    .scale({ 'white', 'yellow', 'red', 'black' })
                    .domain({ 0, 100 })
                    .mode('lab'),
            }
        end)

        test('center L is 74', function()
            expect(mathRound(topic.f(50):lab()[1])).toEqual(74)
        end)
    end)

    describe('hot - with correction - domained [0,100]', function()
        local topic
        beforeEach(function()
            topic = {
                f = chroma
                    .scale({ 'white', 'yellow', 'red', 'black' })
                    .domain({ 0, 100 })
                    .mode('lab')
                    .correctLightness(true),
            }
        end)

        test('center L is 50', function()
            expect(mathRound(topic.f(50):lab()[1])).toEqual(50)
        end)
    end)

    describe('hot - w/o correction - domained [0,20,40,60,80,100]', function()
        local topic
        beforeEach(function()
            topic = {
                f = chroma
                    .scale({ 'white', 'yellow', 'red', 'black' })
                    .domain({ 0, 20, 40, 60, 80, 100 })
                    .mode('lab'),
            }
        end)

        test('center L is 74', function()
            expect(mathRound(topic.f(50):lab()[1])).toEqual(74)
        end)
    end)

    describe('hot - with correction - domained [0,20,40,60,80,100]', function()
        local topic
        beforeEach(function()
            topic = {
                f = chroma
                    .scale({ 'white', 'yellow', 'red', 'black' })
                    .domain({ 0, 20, 40, 60, 80, 100 })
                    .mode('lab')
                    .correctLightness(true),
            }
        end)

        test('center L is 50', function()
            expect(mathRound(topic.f(50):lab()[1])).toEqual(50)
        end)
    end)
end)
