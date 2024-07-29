-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hsl/hsl2rgb.js
local unpack_ = require('../../utils').unpack
local round = math.round

local function hsl2rgb(...: any)
    local args = unpack_(table.pack(...), 'hsl')
    local h, s, l = table.unpack(args, 1, 3)
    local r, g, b
    if s == 0 then
        b = l * 255
        g = b
        r = g
    else
        local t3 = { 0, 0, 0 }
        local c = { 0, 0, 0 }
        local t2 = if l < 0.5 then l * (1 + s) else l + s - l * s
        local t1 = 2 * l - t2
        local h_ = h / 360
        t3[1] = h_ + 1 / 3
        t3[2] = h_
        t3[3] = h_ - 1 / 3

        for i = 1, 3 do
            if t3[i] < 0 then
                t3[i] += 1
            end
            if t3[i] > 1 then
                t3[i] -= 1
            end
            if 6 * t3[i] < 1 then
                c[i] = t1 + (t2 - t1) * 6 * t3[i]
            elseif 2 * t3[i] < 1 then
                c[i] = t2
            elseif 3 * t3[i] < 2 then
                c[i] = t1 + (t2 - t1) * (2 / 3 - t3[i]) * 6
            else
                c[i] = t1
            end
        end
        r, g, b = round(c[1] * 255), round(c[2] * 255), round(c[3] * 255)
    end
    if #args > 3 then
        -- keep alpha channel
        return { r, g, b, args[4] }
    end
    return { r, g, b, 1 }
end

return hsl2rgb
