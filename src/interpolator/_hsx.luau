-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/interpolator/_hsx.js
local Collections = require('@pkg/@jsdotlua/collections')
local Number = require('@pkg/@jsdotlua/number')

local Array = Collections.Array
local Color = require('../Color')

type Color = Color.Color

local function _hsx(col1: Color, col2: Color, f: number, m: string)
    local xyz0, xyz1
    if m == 'hsl' then
        xyz0 = col1:hsl()
        xyz1 = col2:hsl()
    elseif m == 'hsv' then
        xyz0 = col1:hsv()
        xyz1 = col2:hsv()
    elseif m == 'hcg' then
        xyz0 = col1:hcg()
        xyz1 = col2:hcg()
    elseif m == 'hsi' then
        xyz0 = col1:hsi()
        xyz1 = col2:hsi()
    elseif m == 'lch' or m == 'hcl' then
        m = 'hcl'
        xyz0 = col1:hcl()
        xyz1 = col2:hcl()
    elseif m == 'oklch' then
        xyz0 = Array.reverse(col1:oklch())
        xyz1 = Array.reverse(col2:oklch())
    end
    local hue0, hue1, sat0, sat1, lbv0, lbv1
    if string.sub(m, 1, 1) == 'h' or m == 'oklch' then
        hue0, sat0, lbv0 = table.unpack(xyz0, 1, 3)
        hue1, sat1, lbv1 = table.unpack(xyz1, 1, 3)
    end
    local sat, hue, lbv, dh
    if not Number.isNaN(hue0) and not Number.isNaN(hue1) then
        -- both colors have hue
        if hue1 > hue0 and hue1 - hue0 > 180 then
            dh = hue1 - (hue0 + 360)
        elseif hue1 < hue0 and hue0 - hue1 > 180 then
            dh = hue1 + 360 - hue0
        else
            dh = hue1 - hue0
        end
        hue = hue0 + f * dh
    elseif not Number.isNaN(hue0) then
        hue = hue0
        if (lbv1 == 1 or lbv1 == 0) and m ~= 'hsv' then
            sat = sat0
        end
    elseif not Number.isNaN(hue1) then
        hue = hue1
        if (lbv0 == 1 or lbv0 == 0) and m ~= 'hsv' then
            sat = sat1
        end
    else
        hue = Number.NaN
    end

    if sat == nil then
        sat = sat0 + f * (sat1 - sat0)
    end

    lbv = lbv0 + f * (lbv1 - lbv0)

    return if m == 'oklch' then Color.new({ lbv, sat, hue }, m) else Color.new({ hue, sat, lbv }, m)
end

return _hsx
