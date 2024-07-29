-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/rgb2cmyk.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local rgb2cmyk = require('../rgb2cmyk')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

describe('Testing CMYK color conversions', function()
    describe('parse simple CMYK colors', function()
        local topic: { [string]: { cmyk: { number }, rgb: { number } } } = {
            black = { cmyk = { 0, 0, 0, 1 }, rgb = { 0, 0, 0, 1 } },
            white = { cmyk = { 0, 0, 0, 0 }, rgb = { 255, 255, 255, 1 } },
            red = { cmyk = { 0, 1, 1, 0 }, rgb = { 255, 0, 0, 1 } },
            green = { cmyk = { 1, 0, 1, 0 }, rgb = { 0, 255, 0, 1 } },
            blue = { cmyk = { 1, 1, 0, 0 }, rgb = { 0, 0, 255, 1 } },
            yellow = { cmyk = { 0, 0, 1, 0 }, rgb = { 255, 255, 0, 1 } },
            cyan = { cmyk = { 1, 0, 0, 0 }, rgb = { 0, 255, 255, 1 } },
            magenta = { cmyk = { 0, 1, 0, 0 }, rgb = { 255, 0, 255, 1 } },
        }

        for colorName, case in topic do
            test(`rgb2cmyk - {colorName}`, function()
                expect(rgb2cmyk(case.rgb)).toEqual(case.cmyk)
            end)
        end
    end)
end)
