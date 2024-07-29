-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/temp/temperature2rgb.js
--[[
 * Based on implementation by Neil Bartlett
 * https://github.com/neilbartlett/color-temperature
]]

local log = math.log

local function temperature2rgb(kelvin: number): { number }
    local temp = kelvin / 100
    local r, g, b
    if temp < 66 then
        r = 255
        g = if temp < 6
            then 0
            else -155.25485562709179 - 0.44596950469579133 * (function()
                g = temp - 2
                return g
            end)() + 104.49216199393888 * log(g)
        b = if temp < 20
            then 0
            else -254.76935184120902 + 0.8274096064007395 * (function()
                b = temp - 10
                return b
            end)() + 115.67994401066147 * log(b)
    else
        r = 351.97690566805693
            + 0.114206453784165 * (function()
                r = temp - 55
                return r
            end)()
            - 40.25366309332127 * log(r)
        g = 325.4494125711974
            + 0.07943456536662342 * (function()
                g = temp - 50
                return g
            end)()
            - 28.0852963507957 * log(g)
        b = 255
    end
    return { r, g, b, 1 }
end

return temperature2rgb
