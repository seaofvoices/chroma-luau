-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/limits.test.js

local Number = require('@pkg/@jsdotlua/number')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local analyze = require('../analyze')
local limits = analyze.limits

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

describe('Some tests for chroma.limits()', function()
    test('simple continuous domain', function()
        local result = limits({ 1, 2, 3, 4, 5 }, 'continuous')
        expect(result).toEqual({ 1, 5 })
    end)

    test('continuous domain, negative values', function()
        local result = limits({ 1, -2, -3, 4, 5 }, 'continuous')
        expect(result).toEqual({ -3, 5 })
    end)

    test('continuous domain, null values', function()
        local result = limits({ 1 :: number?, nil, nil, 4, 5 }, 'continuous')
        expect(result).toEqual({ 1, 5 })
    end)

    test('equidistant domain', function()
        local result = limits({ 0, 10 }, 'equidistant', 5)
        expect(result).toEqual({ 0, 2, 4, 6, 8, 10 })
    end)

    test('equidistant domain, NaN values', function()
        local result =
            limits({ 0 :: number?, 9, 3, 6, 3, 5, nil, Number.NaN, 10 }, 'equidistant', 5)
        expect(result).toEqual({ 0, 2, 4, 6, 8, 10 })
    end)

    test('logarithmic domain', function()
        local result = limits({ 1, 10000 }, 'log', 4)
        expect(result).toEqual({ 1, 10, 100, 1000, 10000 })
    end)

    test('logarithmic domain - non-positive values', function()
        expect(function()
            limits({ -1, 10000 }, 'log', 4)
        end).toThrow('Logarithmic scales are only possible for values > 0')
    end)

    test('quantiles domain', function()
        local result = limits({ 1, 2, 3, 4, 5, 10, 20, 100 }, 'quantiles', 2)
        expect(result).toEqual({ 1, 4.5, 100 })
    end)

    test('quantiles not enough values', function()
        local result = limits({ 0, 1 }, 'quantiles', 5)
        expect(result).toEqual({ 0, 0.2, 0.4, 0.6, 0.8, 1 })
    end)
end)
