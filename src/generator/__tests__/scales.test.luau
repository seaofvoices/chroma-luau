-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/test/scales.test.js
local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../../init')
local scale = require('../scale')

type Color = chroma.Color

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe
local beforeEach = jestGlobals.beforeEach

describe('Some tests for scale()', function()
    describe('simple rgb scale (white-->black)', function()
        local topic
        beforeEach(function()
            topic = { f = scale({ 'white', 'black' }) }
        end)

        test('starts white', function()
            expect(topic.f(0):hex()).toEqual('#ffffff')
        end)

        test('mid gray', function()
            expect(topic.f(0.5):hex()).toEqual('#808080')
        end)

        test('ends black', function()
            expect(topic.f(1):hex()).toEqual('#000000')
        end)
    end)

    describe('simple hsv scale (white-->black)', function()
        local topic
        beforeEach(function()
            topic = { f = scale({ 'white', 'black' }).mode('hsv') }
        end)

        test('starts white', function()
            expect(topic.f(0):hex()).toEqual('#ffffff')
        end)

        test('mid gray', function()
            expect(topic.f(0.5):hex()).toEqual('#808080')
        end)

        test('ends black', function()
            expect(topic.f(1):hex()).toEqual('#000000')
        end)

        test('colors', function()
            expect(topic.f.colors()).toEqual({ '#ffffff', '#000000' })
        end)

        test('colors start and end', function()
            expect(topic.f.colors(2)).toEqual({ '#ffffff', '#000000' })
        end)

        test('color mode', function()
            expect(topic.f.colors(2, 'rgb')[2]).toEqual({ 0, 0, 0 })
        end)

        test('color mode null len', function()
            expect(#topic.f.colors(2, nil)).toEqual(2)
        end)

        test('color mode null', function()
            expect((topic.f.colors(2, nil)[1] :: any)._rgb).toBeDefined()
        end)
    end)

    describe('simple hsv scale (white-->black), classified', function()
        local topic
        beforeEach(function()
            topic = { f = scale({ 'white', 'black' }).classes(7).mode('hsv') }
        end)

        test('starts white', function()
            expect(topic.f(0):hex()).toEqual('#ffffff')
        end)

        test('mid gray', function()
            expect(topic.f(0.5):hex()).toEqual('#808080')
        end)

        test('ends black', function()
            expect(topic.f(1):hex()).toEqual('#000000')
        end)

        test('colors', function()
            expect(topic.f.colors(7)).toEqual({
                '#ffffff',
                '#d5d5d5',
                '#aaaaaa',
                '#808080',
                '#555555',
                '#2a2a2a',
                '#000000',
            })
        end)
    end)

    describe('simple lab scale (white-->black)', function()
        local topic
        beforeEach(function()
            topic = { f = scale({ 'white', 'black' }).mode('lab') }
        end)

        test('starts white', function()
            expect(topic.f(0):hex()).toEqual('#ffffff')
        end)

        test('mid gray', function()
            expect(topic.f(0.5):hex()).toEqual('#777777')
        end)

        test('ends black', function()
            expect(topic.f(1):hex()).toEqual('#000000')
        end)
    end)

    describe('colorbrewer scale', function()
        local topic
        beforeEach(function()
            topic = { f = scale('RdYlGn') }
        end)

        test('starts white', function()
            expect(topic.f(0):hex()).toEqual('#a50026')
        end)

        test('mid gray', function()
            expect(topic.f(0.5):hex()).toEqual('#ffffbf')
        end)

        test('ends black', function()
            expect(topic.f(1):hex()).toEqual('#006837')
        end)
    end)

    describe('colorbrewer scale - domained', function()
        local topic
        beforeEach(function()
            topic = { f = scale('RdYlGn').domain({ 0, 100 }) }
        end)

        test('starts white', function()
            expect(topic.f(0):hex()).toEqual('#a50026')
        end)

        test('foo', function()
            expect(topic.f(10):hex()).never.toEqual('#ffffbf')
        end)

        test('mid gray', function()
            expect(topic.f(50):hex()).toEqual('#ffffbf')
        end)

        test('ends black', function()
            expect(topic.f(100):hex()).toEqual('#006837')
        end)
    end)
end)

describe('colorbrewer scale - lowercase', function()
    local topic
    beforeEach(function()
        topic = { f = scale(('rdylgn' :: any) :: 'RdYlGn') }
    end)

    test('starts white', function()
        expect(topic.f(0):hex()).toEqual('#a50026')
    end)

    test('mid gray', function()
        expect(topic.f(0.5):hex()).toEqual('#ffffbf')
    end)

    test('ends black', function()
        expect(topic.f(1):hex()).toEqual('#006837')
    end)
end)

describe('colorbrewer scale - domained - classified', function()
    local topic
    beforeEach(function()
        topic = { f = scale('RdYlGn').domain({ 0, 100 }).classes(5) }
    end)

    test('starts white', function()
        expect(topic.f(0):hex()).toEqual('#a50026')
    end)

    test('10', function()
        expect(topic.f(10):hex()).toEqual('#a50026')
    end)

    test('mid gray', function()
        expect(topic.f(50):hex()).toEqual('#ffffbf')
    end)

    test('ends black', function()
        expect(topic.f(100):hex()).toEqual('#006837')
    end)

    test('get colors', function()
        expect(topic.f.colors(5)).toEqual({
            '#a50026',
            '#f98e52',
            '#ffffbf',
            '#86cb67',
            '#006837',
        })
    end)
end)

describe('calling domain with no arguments', function()
    local topic
    beforeEach(function()
        topic = { f = scale('RdYlGn').domain({ 0, 100 }).classes(5) }
    end)

    test('returns domain', function()
        expect(topic.f.domain()).toEqual({ 0, 100 })
    end)

    test('returns classes', function()
        expect(topic.f.classes()).toEqual({ 0, 20, 40, 60, 80, 100 })
    end)
end)

describe('source array keeps untouched', function()
    local colors
    beforeEach(function()
        colors = table.clone(chroma.brewer.Blues)
    end)

    test('colors are an array', function()
        expect(#colors).toEqual(9)
    end)

    test('colors are strings', function()
        expect(type(colors[1])).toEqual('string')
    end)

    test('creating a color scale', function()
        scale(colors)
        -- assert_(true)
    end)

    test('colors are still strings', function()
        expect(type(colors[1])).toEqual('string')
    end)
end)

describe('domain with same min and max', function()
    local topic
    beforeEach(function()
        topic = { f = scale({ 'white', 'black' }).domain({ 1, 1 }) }
    end)

    test('returns color', function()
        expect(topic.f(1):hex()).toEqual('#000000')
    end)
end)

describe('simple num scale (white-->black)', function()
    local topic
    beforeEach(function()
        topic = { f = scale({ 'white', 'black' }).mode('num') }
    end)

    test('starts white', function()
        expect(topic.f(0):hex()).toEqual('#ffffff')
    end)

    test('25%', function()
        expect(topic.f(0.25):hex()).toEqual('#bfffff')
    end)

    test('50%', function()
        expect(topic.f(0.5):hex()).toEqual('#7fffff')
    end)

    test('75%', function()
        expect(topic.f(0.75):hex()).toEqual('#3fffff')
    end)

    test('95%', function()
        expect(topic.f(0.95):hex()).toEqual('#0ccccc')
    end)

    test('ends black', function()
        expect(topic.f(1):hex()).toEqual('#000000')
    end)
end)

describe('css rgb colors', function()
    local topic
    beforeEach(function()
        topic = scale('YlGnBu')(0.3):css()
    end)

    test('have rounded rgb() values', function()
        expect(topic).toEqual('rgb(170,222,183)')
    end)
end)

describe('css rgba colors', function()
    local topic
    beforeEach(function()
        topic = scale('YlGnBu')(0.3):alpha(0.675):css()
    end)

    test('dont round alpha value', function()
        expect(topic).toEqual('rgba(170,222,183,0.675)')
    end)
end)

describe('get colors from a scale', function()
    local topic
    beforeEach(function()
        topic = { f = scale({ 'yellow', 'darkgreen' }) }
    end)

    test('just colors', function()
        expect(topic.f.colors()).toEqual({ '#ffff00', '#006400' })
    end)

    test('five hex colors', function()
        expect(topic.f.colors(5)).toEqual({
            '#ffff00',
            '#bfd800',
            '#80b200',
            '#408b00',
            '#006400',
        })
    end)

    test('three css colors', function()
        expect(topic.f.colors(3, 'css')).toEqual({
            'rgb(255,255,0)',
            'rgb(128,178,0)',
            'rgb(0,100,0)',
        })
    end)
end)

describe('get colors from a scale with more than two colors', function()
    local topic
    beforeEach(function()
        topic = { f = scale({ 'yellow', 'orange', 'darkgreen' }) }
    end)

    test('just origianl colors', function()
        expect(topic.f.colors()).toEqual({ '#ffff00', '#ffa500', '#006400' })
    end)
end)

describe('test example in readme', function()
    local topic
    beforeEach(function()
        topic = { f = scale('RdYlGn') }
    end)

    test('five hex colors (new)', function()
        expect(topic.f.colors(5)).toEqual({
            '#a50026',
            '#f98e52',
            '#ffffbf',
            '#86cb67',
            '#006837',
        })
    end)
end)

describe('weird result', function()
    local topic
    beforeEach(function()
        topic = {
            f = scale({ { 0, 0, 0, 1 }, { 255, 255, 255, 1 } }).domain({ 0, 10 }).mode('rgb'),
        }
    end)

    test('has hex function at 0.5', function()
        expect(type(topic.f(0.5).hex)).toEqual('function')
    end)

    test('has hex function at 0', function()
        expect(type(topic.f(0).hex)).toEqual('function')
    end)
end)

describe('scale padding, simple', function()
    local topic
    beforeEach(function()
        topic = { f = scale('RdYlBu').padding(0.15) }
    end)

    test('0', function()
        expect(topic.f(0):hex()).toEqual('#e64f35')
    end)

    test('0.5', function()
        expect(topic.f(0.5):hex()).toEqual('#ffffbf')
    end)

    test('1', function()
        expect(topic.f(1):hex()).toEqual('#5d91c3')
    end)
end)

describe('scale padding, one-sided', function()
    local topic
    beforeEach(function()
        topic = { f = scale('OrRd').padding({ 0.2, 0 }) }
    end)

    test('0', function()
        expect(topic.f(0):hex()).toEqual('#fddcaf')
    end)

    test('0.5', function()
        expect(topic.f(0.5):hex()).toEqual('#f26d4b')
    end)

    test('1', function()
        expect(topic.f(1):hex()).toEqual('#7f0000')
    end)
end)

describe('colors return original colors', function()
    local topic
    beforeEach(function()
        topic = { f = scale({ 'red', 'white', 'blue' }) }
    end)

    test('same colors', function()
        expect(topic.f.colors()).toEqual({ '#ff0000', '#ffffff', '#0000ff' })
    end)
end)

describe('scale with one color', function()
    local topic
    beforeEach(function()
        topic = { f = scale({ 'red' }) }
    end)

    test('should return that color', function()
        expect(topic.f(0.3):hex()).toEqual('#ff0000')
    end)
end)

describe('scale() no data color', function()
    local topic
    beforeEach(function()
        topic = { f = scale('OrRd') }
    end)

    test('null --> nodata', function()
        expect(topic.f(nil):hex()).toEqual('#cccccc')
    end)

    test('undefined --> nodata', function()
        expect(topic.f(nil):hex()).toEqual('#cccccc')
    end)

    test('custom nodata color', function()
        expect(topic.f.nodata('#eee')(nil):hex()).toEqual('#eeeeee')
    end)
end)

describe('scale wrapped in a scale', function()
    local topic
    beforeEach(function()
        topic = {
            f1 = scale('OrRd'),
            f = scale('OrRd').domain({ 0, 0.25, 1 }),
        }
    end)

    test('start', function()
        expect(topic.f(0):hex()).toEqual(topic.f1(0):hex())
    end)

    test('end', function()
        expect(topic.f(1):hex()).toEqual(topic.f1(1):hex())
    end)

    test('center', function()
        expect(topic.f(0.125):hex()).toEqual(topic.f1(0.25):hex())
    end)

    test('center2', function()
        expect(topic.f(0.25):hex()).toEqual(topic.f1(0.5):hex())
    end)

    test('center3', function()
        expect(topic.f(0.625):hex()).toEqual(topic.f1(0.75):hex())
    end)
end)
