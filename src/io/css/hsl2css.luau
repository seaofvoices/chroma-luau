-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/css/hsl2css.js
local Number = require('@pkg/@jsdotlua/number')

local utils = require('../../utils')

local unpack_ = utils.unpack
local last = utils.last

local function rnd(a: number): number
    return math.round(a * 100) / 100
end

--[[
 * supported arguments:
 * - hsl2css(h,s,l)
 * - hsl2css(h,s,l,a)
 * - hsl2css([h,s,l], mode)
 * - hsl2css([h,s,l,a], mode)
 * - hsl2css({h,s,l,a}, mode)
]]
local function hsl2css(...: any)
    local hsla = unpack_(table.pack(...), 'hsla')
    local mode_ = last(...)
    local mode = if mode_ == nil or mode_ == '' then 'lsa' else mode_

    -- deviation: avoid mutating `hsla` and create a new variable instead
    local hslaString = {
        -- deviation: manually check if number is NaN
        tostring(rnd(if Number.isNaN(hsla[1]) then 0 else hsla[1])),
        tostring(rnd(hsla[2] * 100)) .. '%',
        tostring(rnd(hsla[3] * 100)) .. '%',
    }
    if mode == 'hsla' or #hsla > 3 and hsla[4] < 1 then
        hslaString[4] = tostring(if #hsla > 3 then hsla[4] else 1)
        mode = 'hsla'
    end
    return `{mode}({table.concat(hslaString, ',')})`
end

return hsl2css
