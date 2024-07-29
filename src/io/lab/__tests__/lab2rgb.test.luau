-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/lab2rgb.test.js
local Collections = require('@pkg/@jsdotlua/collections')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local lab2rgb = require('../lab2rgb')
local limit = require('../../../utils/limit')
local mathRound = require('../../../utils/round.roblox.luau')

local Array = Collections.Array
local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local function round(v: number): number
    return limit(mathRound(v), 0, 255)
end

describe('Testing CMYK color conversions', function()
    local topic: { [string]: { input: { number }, out: { number } } } = {
        black = { input = { 0, 0, 0 }, out = { 0, 0, 0, 1 } },
        white = { input = { 100, 0, 0 }, out = { 255, 255, 255, 1 } },
        gray = { input = { 53.59, 0, 0 }, out = { 128, 128, 128, 1 } },
        red = { input = { 53.24, 80.09, 67.2 }, out = { 255, 0, 0, 1 } },
        yellow = { input = { 97.14, -21.55, 94.48 }, out = { 255, 255, 0, 1 } },
        green = { input = { 87.73, -86.18, 83.18 }, out = { 0, 255, 0, 1 } },
        cyan = { input = { 91.11, -48.09, -14.13 }, out = { 0, 255, 255, 1 } },
        blue = { input = { 32.3, 79.19, -107.86 }, out = { 0, 0, 255, 1 } },
        magenta = { input = { 60.32, 98.23, -60.82 }, out = { 255, 0, 255, 1 } },
    }

    for color, t in topic do
        local input = t.input
        local out = t.out

        describe(`parse simple HSI colors - {color}`, function()
            test('lab_arr', function()
                expect(Array.map(lab2rgb(input), round)).toEqual(out)
            end)

            test('lab_args', function()
                expect(Array.map(lab2rgb(unpack(input)), round)).toEqual(out)
            end)

            test('lab_obj', function()
                local l = input[1]
                local a = input[2]
                local b = input[3]
                expect(Array.map(lab2rgb({ l = l, a = a, b = b }), round)).toEqual(out)
            end)
        end)
    end
end)
