-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hsv/hsv2rgb.js

local unpack_ = require('../../utils').unpack
local floor = math.floor

local function hsv2rgb(...: any)
    local args = unpack_(table.pack(...), 'hsv')
    local h, s, v = table.unpack(args, 1, 3)
    local r, g, b
    v *= 255

    if s == 0 then
        b = v
        g = b
        r = g
    else
        if h == 360 then
            h = 0
        end
        if h > 360 then
            h -= 360
        end
        if h < 0 then
            h += 360
        end

        h /= 60

        local i = floor(h)
        local f = h - i
        local p = v * (1 - s)
        local q = v * (1 - s * f)
        local t = v * (1 - s * (1 - f))

        local condition_ = i
        if condition_ == 0 then
            r, g, b = v, t, p
        elseif condition_ == 1 then
            r, g, b = q, v, p
        elseif condition_ == 2 then
            r, g, b = p, v, t
        elseif condition_ == 3 then
            r, g, b = p, q, v
        elseif condition_ == 4 then
            r, g, b = t, p, v
        elseif condition_ == 5 then
            r, g, b = v, p, q
        end
    end

    return {
        r,
        g,
        b,
        if #args > 3 then args[4] else 1,
    }
end

return hsv2rgb
