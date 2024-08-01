-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/Color.js
local ColorTypes = require('./types/color-types')
local utils = require('./utils')

local last = utils.last
local clip_rgb = utils.clip_rgb

local _input = require('./io/input')

export type Color = ColorTypes.Color
export type AsColor = ColorTypes.AsColor
export type ColorSpace = ColorTypes.ColorSpace
export type PrivateColor = ColorTypes.PrivateColor

type ColorStatic = {
    new: (...any) -> Color,
}
local Color = {} :: Color & ColorStatic
local ColorMetatable = {
    __index = Color,
    __tostring = function(self): string
        return self:toString()
    end,
}

function Color.new(...: any): Color
    local self = setmetatable({}, ColorMetatable)
    local args = table.pack(...)
    local me = self

    -- deviation: check is args[1] is a Color object using its metatable
    if type(args[1]) == 'table' and getmetatable(args[1]) == ColorMetatable then
        -- the argument is already a Color instance
        return args[1]
    end

    -- last argument could be the mode
    local mode = last(...)
    local autodetect = false

    if mode == nil or mode == '' then
        autodetect = true
        if not _input.sorted then
            -- deviation: replace Array.sort with simple table.sort
            table.sort(_input.autodetect, function(a, b)
                return a.p > b.p
            end)
            _input.sorted = true
        end

        -- auto-detect format
        for _, chk in _input.autodetect do
            mode = chk.test(...)
            if mode ~= nil and mode ~= '' then
                break
            end
        end
    end

    if mode ~= nil and _input.format[mode] then
        local rgb = if autodetect
            then _input.format[mode](...)
            else _input.format[mode](unpack(args, 1, args.n - 1))

        me._rgb = clip_rgb(rgb)
    else
        local entries = {}
        for i = 1, args.n do
            entries[i] = tostring(args[i])
        end
        local repr = '{ ' .. table.concat(entries, ', ') .. ' }'

        error(`unknown format: {repr}`)
    end

    -- add alpha channel
    if #me._rgb == 3 then
        table.insert(me._rgb, 1)
    end

    return (self :: any) :: Color
end

function Color:toString(): string
    -- deviation: the hex function is always defined
    return self:hex()

    -- if type(self.hex) == 'function' then
    --     return self:hex()
    -- end
    -- return `[{table.concat(self._rgb, ',')}]`
end

return Color
