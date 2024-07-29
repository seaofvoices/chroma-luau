local Color = require('../../Color')
local chroma = require('../../chroma')
local input = require('../input')

type Color = Color.Color
type PrivateColor = Color.PrivateColor

input.format.roblox = function(color: Color3, opacity: number?)
    return { color.R * 255, color.G * 255, color.B * 255, if opacity then opacity else 1 }
end

function chroma.roblox(...: any): Color
    local args = table.pack(...)
    args[args.n + 1] = 'roblox'
    return Color.new(unpack(args, 1, args.n + 1))
end

function Color:roblox(): Color3
    local self: PrivateColor = self :: any
    local rgb = self._rgb
    return Color3.fromRGB(rgb[1], rgb[2], rgb[3])
end

table.insert(input.autodetect, {
    p = 56,
    test = function(...: any): string?
        local args = table.pack(...)
        if args.n == 1 and type(args[1]) == 'userdata' and typeof(args[1]) == 'Color3' then
            return 'roblox'
        end
        return nil
    end,
})

return nil
