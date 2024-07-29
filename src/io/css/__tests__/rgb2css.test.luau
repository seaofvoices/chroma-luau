-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/rgb2css.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local rgb2css = require('../rgb2css')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

local tests: { [string]: { rgb: { number }, css: string, mode: string? } } = {
    black = { rgb = { 0, 0, 0 }, css = 'rgb(0,0,0)' },
    red = { rgb = { 255, 0, 0 }, css = 'rgb(255,0,0)' },
    auto_rgba = { rgb = { 255, 0, 0, 0.25 }, css = 'rgba(255,0,0,0.25)' },
    force_rgba = { rgb = { 255, 0, 0 }, mode = 'rgba', css = 'rgba(255,0,0,1)' },
    hsl = { rgb = { 255, 0, 0 }, mode = 'hsl', css = 'hsl(0,100%,50%)' },
    auto_hsla = { rgb = { 255, 0, 0, 0.5 }, mode = 'hsl', css = 'hsla(0,100%,50%,0.5)' },
    force_hsla = { rgb = { 255, 255, 0, 0.75 }, mode = 'hsl', css = 'hsla(60,100%,50%,0.75)' },
}

describe('Testing rgb2css color conversions', function()
    for key, topic in tests do
        describe(key, function()
            test('array', function()
                expect(rgb2css(topic.rgb, topic.mode)).toEqual(topic.css)
            end)

            test('obj', function()
                local r = topic.rgb[1]
                local g = topic.rgb[2]
                local b = topic.rgb[3]
                local a = topic.rgb[4]

                expect(rgb2css({ r = r, g = g, b = b, a = a }, topic.mode)).toEqual(topic.css)
            end)

            test('args', function()
                if topic.mode ~= 'rgb' then
                    return
                end
                local r = topic.rgb[1]
                local g = topic.rgb[2]
                local b = topic.rgb[3]
                local a = topic.rgb[4]
                if a then
                    expect(rgb2css(r, g, b, a, topic.mode)).toEqual(topic.css)
                else
                    expect(rgb2css(r, g, b, topic.mode)).toEqual(topic.css)
                end
            end)
        end)
    end
end)
