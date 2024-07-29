-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/rgb/index.js
local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')
local utils = require('../../utils')

type PrivateColor = Color.PrivateColor
type Color = Color.Color

local unpack_ = utils.unpack
local round = math.round

function Color:rgb(rnd_: boolean?)
    local self: PrivateColor = self :: any

    local rnd: boolean = if rnd_ ~= nil then rnd_ else true

    local rgb = self._rgb
    if rnd == false then
        -- deviation: replace Array.slice with manual unpack
        return { rgb[1], rgb[2], rgb[3] }
    end
    -- deviation: replace Array.slice with manual unpack
    return { round(rgb[1]), round(rgb[2]), round(rgb[3]) }
end

function Color:rgba(rnd_: boolean?)
    local self: PrivateColor = self :: any

    local rnd: boolean = if rnd_ ~= nil then rnd_ else true
    -- deviation: replace Array.slice with manual unpack
    local rgb = self._rgb
    if rnd == false then
        return { rgb[1], rgb[2], rgb[3], rgb[4] }
    end
    return { round(rgb[1]), round(rgb[2]), round(rgb[3]), rgb[4] }
end

function chroma.rgb(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'rgb'
    return Color.new(unpack(args, 1, args.n + 1))
end

function input.format.rgb(...: any)
    local rgba = unpack_(table.pack(...), 'rgba')
    if rgba[4] == nil then
        rgba[4] = 1
    end
    return rgba
end

table.insert(input.autodetect, {
    p = 39,
    test = function(...: any): string?
        local args = unpack_(table.pack(...), 'rgba')

        -- deviation: use default type function
        if
            type(args) == 'table'
            and (
                #args == 3
                or (#args == 4 and type(args[4]) == 'number' and args[4] >= 0 and args[4] <= 1)
            )
        then
            return 'rgb'
        end
        return nil
    end,
})

return nil
