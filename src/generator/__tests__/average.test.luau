-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/average.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

local colors = {
    { 125, 133, 127 },
    { 131, 127, 134 },
    { 138, 121, 141 },
    { 144, 114, 147 },
    { 149, 107, 153 },
    { 165, 83, 170 },
    { 160, 92, 164 },
    { 170, 73, 175 },
    { 175, 62, 180 },
    { 155, 100, 159 },
}

describe('Testing color averaging modes', function()
    describe('avg some colors', function()
        local topic
        beforeEach(function()
            topic = { 'red', 'blue' }
        end)

        test('is #5a0000', function()
            expect(chroma.average(topic):hex()).toEqual(chroma.mix(topic[1], topic[2]):hex())
        end)
    end)

    describe('three colors', function()
        local topic
        beforeEach(function()
            topic = chroma.average({ 'blue', 'red', 'white' }, 'rgb')
        end)

        test('is #5a0000', function()
            expect(topic:hex()).toEqual('#aa55aa')
        end)
    end)

    describe('alpha avg', function()
        local topic
        beforeEach(function()
            topic = chroma.average({ 'rgba(0,0,0,0)', 'red' }, 'rgb')
        end)

        test('is #5a0000', function()
            expect(topic:rgba()).toEqual({ 128, 0, 0, 0.5 })
        end)

        test('is #5a0000-2', function()
            expect(topic:rgba(false)).toEqual({ 127.5, 0, 0, 0.5 })
        end)
    end)

    describe('average in lab', function()
        local topic
        beforeEach(function()
            topic = chroma.average({ 'blue', 'red', 'white' }, 'lab')
        end)

        test('is #5a0000', function()
            expect(topic:hex()).toEqual('#e26daf')
        end)
    end)

    describe('average h in lch', function()
        local topic
        beforeEach(function()
            topic = chroma
                .average({ chroma.lch(50, 50, 0), chroma.lch(50, 50, 90) }, 'lch')
                :get('lch.h') :: number
        end)

        test('is approximately 45', function()
            expect(math.round(topic)).toEqual(45)
        end)
    end)

    describe('average in hsl of same colors', function()
        local topic
        beforeEach(function()
            topic = chroma.average({ '#02c03a', '#02c03a' }, 'hsl')
        end)

        test('is same', function()
            expect(topic:hex()).toEqual('#02c03a')
        end)
    end)

    describe('average same color', function()
        local topic
        beforeEach(function()
            topic = chroma.average({ '#02c03a', '#02c03a' }, 'hsl')
        end)

        test('is #02c03a', function()
            expect(topic:hex()).toEqual('#02c03a')
        end)
    end)

    describe('lrgb avergage', function()
        local topic
        beforeEach(function()
            topic = chroma.average(colors, 'lrgb')
        end)

        test('is ???', function()
            expect(topic:hex()).toEqual('#98689c')
        end)
    end)

    describe('three colors, weighted rgb average', function()
        local topic
        beforeEach(function()
            topic = chroma.average({ 'blue', 'red', 'white' }, 'rgb', { 1, 1, 2 })
        end)

        test('is #bf80bf', function()
            expect(topic:hex()).toEqual('#bf80bf')
        end)
    end)

    describe('three colors, weighted lrgb average', function()
        local topic
        beforeEach(function()
            topic = chroma.average({ 'blue', 'red', 'white' }, 'lrgb', { 1, 3, 2 })
        end)

        test('is #e993b4', function()
            expect(topic:hex()).toEqual('#e993b4')
        end)
    end)

    describe('three colors, weighted hsl average', function()
        local topic
        beforeEach(function()
            topic = chroma.average({ 'blue', 'red', 'white' }, 'hsl', { 0.25, 1, 0.5 })
        end)

        test('is #e58263', function()
            expect(topic:hex()).toEqual('#e58263')
        end)
    end)
end)
