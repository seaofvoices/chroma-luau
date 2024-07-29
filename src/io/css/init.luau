-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/css/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local css2rgb = require('./css2rgb')
local input = require('../input')
local rgb2css = require('./rgb2css')

type Color = Color.Color
type PrivateColor = Color.PrivateColor

function Color:css(mode: string?): string
    local self: PrivateColor = self :: any
    return rgb2css(self._rgb, mode)
end

function chroma.css(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'css'
    return Color.new(unpack(args, 1, args.n + 1))
end

input.format.css = css2rgb.css2rgb

table.insert(input.autodetect, {
    p = 59,
    test = function(h, ...: any): string?
        -- deviation: use default type function
        if select('#', ...) == 0 and type(h) == 'string' and css2rgb.test(h) then
            return 'css'
        end
        return nil
    end,
})

return nil
