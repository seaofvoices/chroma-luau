-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/ops/luminance.js
local Color = require('../Color')
local InterpolationMode = require('../types/interpolation-mode')

local pow = math.pow
local EPS = 1e-7
local MAX_ITER = 20

type Color = Color.Color
type PrivateColor = Color.PrivateColor
type InterpolationMode = InterpolationMode.InterpolationMode

-- deviation: pre-declare variables
local rgb2luminance

-- deviation: add interpolation mode parameter
function Color:luminance(lum: number?, mode: InterpolationMode?): any
    local self: PrivateColor = self :: any

    -- deviation: use default type function
    if lum ~= nil and type(lum) == 'number' then
        if lum == 0 then
            -- return pure black
            return Color.new({ 0, 0, 0, self._rgb[4] }, 'rgb')
        end
        if lum == 1 then
            -- return pure white
            return Color.new({ 255, 255, 255, self._rgb[4] }, 'rgb')
        end

        -- compute new color using...
        local cur_lum = self:luminance()
        -- deviation: set default mode
        local mode: InterpolationMode = mode or 'rgb'
        local max_iter = MAX_ITER

        local function test(low: Color, high: Color): Color
            local mid = low:interpolate(high, 0.5, mode)
            local lm = mid:luminance()
            max_iter -= 1

            if math.abs(lum - lm) < EPS or max_iter < 0 then
                -- close enough
                return mid
            end

            return if lm > lum then test(low, mid) else test(mid, high)
        end

        local rgb = (if cur_lum > lum
            then test(Color.new({ 0, 0, 0 }), self)
            else test(self, Color.new({ 255, 255, 255 }))):rgb()

        return Color.new({ rgb[1], rgb[2], rgb[2], self._rgb[4] })
    end

    return rgb2luminance(self._rgb[1], self._rgb[2], self._rgb[3])
end

-- deviation: pre-declare variables
local luminance_x

function rgb2luminance(r: number, g: number, b: number): number
    -- relative luminance
    -- see http://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef
    r = luminance_x(r)
    g = luminance_x(g)
    b = luminance_x(b)
    return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

function luminance_x(x: number): number
    x /= 255
    return if x <= 0.03928 then x / 12.92 else pow((x + 0.055) / 1.055, 2.4)
end

return nil
