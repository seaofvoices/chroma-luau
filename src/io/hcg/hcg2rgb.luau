-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hcg/hcg2rgb.js
local unpack_ = require('../../utils').unpack
local floor = math.floor

--[[
 * this is basically just HSV with some minor tweaks
 *
 * hue.. [0..360]
 * chroma .. [0..1]
 * grayness .. [0..1]
]]
local function hcg2rgb(...: any): { number }
    local args = unpack_(table.pack(...), 'hcg')
    local h, c, _g = table.unpack(args, 1, 3)
    local r, g, b
    _g = _g * 255
    local _c = c * 255
    if c == 0 then
        b = _g
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
        local p = _g * (1 - c)
        local q = p + _c * (1 - f)
        local t = p + _c * f
        local v = p + _c
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

    return { r, g, b, if #args > 3 then args[4] else 1 }
end

return hcg2rgb
