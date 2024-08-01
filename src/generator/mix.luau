-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/generator/mix.js
local Color = require('../Color')
local InterpolationMode = require('../types/interpolation-mode')
local interpolator = require('../interpolator')

type Color = Color.Color
type AsColor = Color.AsColor
type InterpolationMode = InterpolationMode.InterpolationMode

local function mix(col1: AsColor, col2: AsColor, f: number?, mode: InterpolationMode?): Color
    local f = if f ~= nil then f else 0.5
    local mode = if mode == nil or (mode :: string) == '' then 'lrgb' else mode

    -- deviation: do not fallback since we are sure that lrgb is supported
    -- if not interpolator[mode] then
    --     -- fall back to the first supported mode
    --     mode = Object.keys(interpolator)[1]
    -- end

    if not interpolator[mode] then
        error(`interpolation mode {mode} is not defined`)
    end

    -- deviation: easier to simply pass through the constructor instead
    -- of checking if it is a Color object
    local col1 = Color.new(col1)
    local col2 = Color.new(col2)

    local col1Alpha = col1:alpha()
    return interpolator[mode](col1, col2, f):alpha(col1Alpha + f * (col2:alpha() - col1Alpha))
end

return mix
