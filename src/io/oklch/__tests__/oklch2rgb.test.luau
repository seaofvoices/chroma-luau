-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/oklch2rgb.test.js
local Collections = require('@pkg/@jsdotlua/collections')
local Number = require('@pkg/@jsdotlua/number')
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local limit = require('../../../utils/limit')
local mathRound = require('../../../utils/round.roblox.luau')
local oklch2rgb = require('../oklch2rgb')

local Array = Collections.Array
local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local function round(v: number): number
    return limit(mathRound(v), 0, 255)
end

describe('Testing LCH conversions', function()
    local topic: { [string]: { input: { number }, out: { number } } } = {
        black = { input = { 0.0, 0.0, Number.NaN }, out = { 0, 0, 0, 1 } },
        white = { input = { 1.0, 0.0, Number.NaN }, out = { 255, 255, 255, 1 } },
        gray = { input = { 0.59987, 0.0, Number.NaN }, out = { 128, 128, 128, 1 } },
        red = { input = { 0.62796, 0.25768, 29.233885192342633 }, out = { 255, 0, 0, 1 } },
        yellow = {
            input = { 0.96798, 0.21101, 109.76923207652125 },
            out = { 255, 255, 0, 1 },
        },
        green = {
            input = { 0.51975, 0.17686, 142.49533888780996 },
            out = { 0, 128, 0, 1 },
        },
        cyan = {
            input = { 0.9054, 0.15455, 194.76894793196382 },
            out = { 0, 255, 255, 1 },
        },
        blue = { input = { 0.45201, 0.31321, 264.052020638055 }, out = { 0, 0, 255, 1 } },
        magenta = {
            input = { 0.70167, 0.32249, 328.36341792345144 },
            out = { 255, 0, 255, 1 },
        },
    }

    for color, case in topic do
        describe(`oklch to rgb - {color}`, function()
            test('lch_arr', function()
                expect(Array.map(oklch2rgb(case.input), round)).toEqual(case.out)
            end)

            test('lch_args', function()
                expect(Array.map(oklch2rgb(unpack(case.input)), round)).toEqual(case.out)
            end)

            test('lch_obj', function()
                local l = case.input[1]
                local c = case.input[2]
                local h = case.input[3]
                expect(Array.map(oklch2rgb({ l = l, c = c, h = h }), round)).toEqual(case.out)
            end)
        end)
    end
end)
