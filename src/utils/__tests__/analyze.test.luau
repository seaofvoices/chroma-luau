-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/analyze.test.js

local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local analyze = require('../analyze')
local analyze = analyze.analyze

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local describeEach = describe.each :: any

describe('Some tests for analyze()', function()
    local cases: { { string | { number | { [string]: number } } | { [string]: number } } } = {
        { 'analyze an array of numbers', { 1, 2, 2, 3, 4, 5 } },
        { 'analyze an object of numbers', { a = 1, b = 2, c = 2, d = 3, e = 4, f = 5 } },
        {
            'analyze an array of objects',
            {
                { k = 1 },
                { k = 2 },
                { k = 2 },
                { k = 3 },
                { k = 4 },
                { k = 5 },
            },
            'k',
        },
        {
            'analyze an object of objects',
            {
                a = { k = 1 },
                b = { k = 2 },
                c = { k = 2 },
                d = { k = 3 },
                e = { k = 4 },
                f = { k = 5 },
            },
            'k',
        },
    }
    describeEach(cases)('%s: %p', function(_message, data, mode)
        test('sum is 17', function()
            local result = analyze(data, mode)
            expect(result.sum).toEqual(17)
        end)
        test('count is 6', function()
            local result = analyze(data, mode)
            expect(result.count).toEqual(6)
        end)
        test('maximum is 5', function()
            local result = analyze(data, mode)
            expect(result.max).toEqual(5)
        end)
        test('minumum is 1', function()
            local result = analyze(data, mode)
            expect(result.min).toEqual(1)
        end)
        test('domain is [1,5]', function()
            local result = analyze(data, mode)
            expect(result.domain).toEqual({ 1, 5 })
        end)
    end)
end)
