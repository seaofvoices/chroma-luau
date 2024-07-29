-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/color.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local Color = require('../Color')
require('../init')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

describe('Testing Color', function()
    describe('re-use existing color instance', function()
        test('same', function()
            local c0 = Color.new('red')
            expect(c0).toBe(Color.new(c0))
        end)
    end)

    describe('autodetect named colors', function()
        local function topic()
            return Color.new('mediumslateblue')
        end

        test('noErrThrown', function()
            expect(topic).never.toThrow()
        end)

        test('hexCode', function()
            expect(topic():hex()).toEqual('#7b68ee')
        end)
    end)

    describe('throw err on wrong color name', function()
        local function topic()
            return Color.new('fakecolor')
        end

        test('errThrown', function()
            expect(topic).toThrow()
        end)
    end)

    describe('autodetect correct hex colors', function()
        for _, hex in { '#ff9900', '#FF9900', '#F90', 'f90', 'FF9900', 'FF9900F0', 'F90F', '#F90F' } do
            describe(`detect hex {hex}`, function()
                local function topic()
                    return Color.new(hex)
                end

                test('noErrThrown', function()
                    expect(topic).never.toThrow()
                end)

                test('hexCode', function()
                    expect(topic():hex('rgb')).toEqual('#ff9900')
                end)
            end)
        end
    end)
end)
