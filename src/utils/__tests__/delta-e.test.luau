-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/delta-e.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local deltaE = require('../delta-e')
require('../../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

-- due to floating-point arithmetic on different devices, differences in decimals may be found.
-- Running http://www.brucelindbloom.com/index.html?ColorDifferenceCalc.html JS code locally
-- on the same device as the delta-e code in this library will provide the exact same results.
local tests: { [string]: { input: { number }, out: number } } = {
    nodifference = { input = { 0x000000, 0x000000 }, out = 0 },
    maxdifference = { input = { 0xFFFFFF, 0x000000 }, out = 100 },
    redgreen = { input = { 0xff0000, 0x00ff00 }, out = 86.6082374535373 },
    greenred = { input = { 0x00ff00, 0xff0000 }, out = 86.6082374535373 },
    beef = { input = { 0x00beef, 0xbeef00 }, out = 56.75641476716213 },
    similar = { input = { 0xededee, 0xedeeed }, out = 1.3211081906645834 },
    similarish = { input = { 0xececee, 0xeceeec }, out = 2.601879624602976 },
    lesssimilar = { input = { 0xe9e9ee, 0xe9eee9 }, out = 6.220878841368716 },
    lesssimilarish = { input = { 0xe4e4ee, 0xe4eee4 }, out = 11.598175546813964 },
    notverysimilar = { input = { 0xe0e0ee, 0xe0eee0 }, out = 15.391371803506503 },
}

describe('Testing delta-e color delta (dE00)', function()
    for key, topic in tests do
        describe(`delta-e {key}`, function()
            test('num', function()
                -- checks if result is within 1% of "out" value.
                -- This is done because results may be slightly
                -- off depending on device setup due to floating
                -- point arithmetic. If "out" is 0, and result was 0,
                -- avoid divide by zero and set to true.
                local result = deltaE(topic.input[1], topic.input[2])
                local percent = math.abs(result - topic.out) / topic.out

                if percent >= 0.01 then
                    expect(topic.out).toEqual(0)
                    expect(result).toEqual(0)
                end
            end)
        end)
    end
end)
