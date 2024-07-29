-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/css/rgb2css.js
local hsl2css = require('./hsl2css')
local mathRound = require('../../utils/round.roblox.luau')
local rgb2hsl = require('../hsl/rgb2hsl')
local utils = require('../../utils')

local unpack_ = utils.unpack
local last = utils.last
local round = mathRound

--[[
 * supported arguments:
 * - rgb2css(r,g,b)
 * - rgb2css(r,g,b,a)
 * - rgb2css([r,g,b], mode)
 * - rgb2css([r,g,b,a], mode)
 * - rgb2css({r,g,b,a}, mode)
]]
local function rgb2css(...: any)
    local rgba = unpack_(table.pack(...), 'rgba')
    local mode_ = last(...)
    local mode = if mode_ == nil or mode_ == '' then 'rgb' else mode_
    if string.sub(mode, 1, 3) == 'hsl' then
        return hsl2css(rgb2hsl(rgba), mode)
    end

    -- deviation: avoid mutating `hsla` and create a new variable instead
    local rgbaString = {
        tostring(round(rgba[1])),
        tostring(round(rgba[2])),
        tostring(round(rgba[3])),
    }

    if mode == 'rgba' or #rgba > 3 and rgba[4] < 1 then
        rgbaString[4] = tostring(if #rgba > 3 then rgba[4] else 1)
        mode = 'rgba'
    end

    return `{mode}({table.concat(rgbaString, ',')})`
end

return rgb2css
