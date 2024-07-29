-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/css2rgb.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local css2rgb = require('../css2rgb').css2rgb

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

describe('Testing CSS2RGB color conversions', function()
    describe('parse CSS colors', function()
        local NULL = {}
        local topic: { [string]: { number } } = {
            ['rgb(0,0,0)'] = { 0, 0, 0, 1 },
            ['rgb(100%,100%,100%)'] = { 255, 255, 255, 1 },
            ['foobarrgb(100%,100%,100%)'] = NULL,
            ['rgba(255,0,0,0.5)'] = { 255, 0, 0, 0.5 },
            ['RGBA(255, 0, 0  , 0.5)'] = { 255, 0, 0, 0.5 },
            ['RGBA (255, 0, 0  , 0.5)'] = NULL,
            ['rgba(0%,100%,0%,.5)'] = { 0, 255, 0, 0.5 },
            [' hsl(240,100%,50%) '] = { 0, 0, 255, 1 },
            ['hsl(60,100%,50%)'] = { 255, 255, 0, 1 },
            ['hsla(180,100%,50%,1)'] = { 0, 255, 255, 1 },
            ['hsla(300,100%,50%,.25)'] = { 255, 0, 255, 0.25 },
            blanchedalmond = { 255, 235, 205, 1 },
            blue = { 0, 0, 255, 1 },
            BlueViolet = { 138, 43, 226, 1 },
            BROWN = { 165, 42, 42, 1 },
            unknownColor = NULL,
        }

        for name, expectedValue in topic do
            test(`parse - {name}`, function()
                expect(css2rgb(name)).toEqual(if expectedValue == NULL then nil else expectedValue)
            end)
        end
    end)
end)
