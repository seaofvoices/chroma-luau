-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/generator/bezier.js
--
-- interpolates between a set of colors uzing a bezier spline
--
local Collections = require('@pkg/@jsdotlua/collections')
local Array = Collections.Array

-- @requires utils lab
local Color = require('../Color')
require('../io/lab')
local scale = require('./scale')

type Scale = scale.Scale
type Color = Color.Color
type AsColor = Color.AsColor

-- nth row of the pascal triangle
local function binom_row(n: number): { number }
    local row = { 1, 1 }

    for _ = 1, n - 1 do
        local newrow = { 1 }

        for j = 1, #row do
            -- deviation: adjust for 1-indexed arrays
            newrow[j + 1] = (row[j + 1] or 0) + row[j]
        end

        row = newrow
    end

    return row
end

local function bezier(colors: { AsColor }): (t: number) -> Color
    local I, lab0, lab1, lab2
    -- deviation: re-declare colors to avoid type errors
    local colors = Array.map(colors, function(c)
        return Color.new(c)
    end)

    local colorsLength = #colors
    if colorsLength == 2 then
        -- linear interpolation
        local labColors = Array.map(colors, function(c)
            return c:lab()
        end)
        lab0, lab1 = labColors[1], labColors[2]
        function I(t: number): Color
            local lab = Array.map({ 1, 2, 3 }, function(i)
                return lab0[i] + t * (lab1[i] - lab0[i])
            end)
            return Color.new(lab, 'lab')
        end
    elseif colorsLength == 3 then
        -- quadratic bezier interpolation
        local labColors = Array.map(colors, function(c)
            return c:lab()
        end)
        lab0, lab1, lab2 = labColors[1], labColors[2], labColors[3]
        function I(t: number): Color
            local lab = Array.map({ 1, 2, 3 }, function(i)
                return (1 - t) * (1 - t) * lab0[i] + 2 * (1 - t) * t * lab1[i] + t * t * lab2[i]
            end)
            return Color.new(lab, 'lab')
        end
    elseif colorsLength == 4 then
        -- cubic bezier interpolation
        local labColors = Array.map(colors, function(c)
            return c:lab()
        end)
        local lab3 = labColors[4]
        lab0, lab1, lab2 = labColors[1], labColors[2], labColors[3]
        function I(t: number): Color
            local lab = Array.map({ 1, 2, 3 }, function(i)
                return (1 - t) * (1 - t) * (1 - t) * lab0[i]
                    + 3 * (1 - t) * (1 - t) * t * lab1[i]
                    + 3 * (1 - t) * t * t * lab2[i]
                    + t * t * t * lab3[i]
            end)
            return Color.new(lab, 'lab')
        end
    elseif colorsLength >= 5 then
        -- general case (degree n bezier)
        local labs, row, n
        labs = Array.map(colors, function(c)
            return c:lab()
        end)
        n = colorsLength - 1
        row = binom_row(n)
        function I(t: number): Color
            local u = 1 - t
            local lab = Array.map({ 1, 2, 3 }, function(i)
                return Array.reduce(labs, function(sum: number, el: { number }, j: number)
                    return sum + row[j] * u ^ (n - (j - 1)) * t ^ (j - 1) * el[i]
                end, 0)
            end)
            return Color.new(lab, 'lab')
        end
    else
        error('No point in running bezier with only one color.')
    end
    return I
end

return function(colors: { AsColor }): ((number) -> Color) & { scale: Scale }
    local f = bezier(colors)
    -- deviation: create callable table
    local wrapped = setmetatable({}, {
        __call = function(_self, t: number): Color
            return f(t)
        end,
    })
    wrapped.scale = function()
        return scale(wrapped :: any)
    end

    return wrapped :: any
end
