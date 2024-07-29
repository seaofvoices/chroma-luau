-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/temp/rgb2temperature.js
--[[
 * Based on implementation by Neil Bartlett
 * https://github.com/neilbartlett/color-temperature
 *]]
local temperature2rgb = require('./temperature2rgb')
local unpack_ = require('../../utils').unpack

local round = math.round

local function rgb2temperature(...: any): number
    local rgb = unpack_(table.pack(...), 'rgb')
    local r, b = rgb[1], rgb[3]
    local minTemp = 1000
    local maxTemp = 40000
    local eps = 0.4
    local temp
    while maxTemp - minTemp > eps do
        temp = (maxTemp + minTemp) * 0.5
        local rgb = temperature2rgb(temp)
        if rgb[3] / rgb[1] >= b / r then
            maxTemp = temp
        else
            minTemp = temp
        end
    end
    return round(temp)
end

return rgb2temperature
