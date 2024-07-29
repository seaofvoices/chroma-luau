-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hex/rgb2hex.js
local utils = require('../../utils')
local unpack_ = utils.unpack
local last = utils.last

local round = math.round

local function rgb2hex(...: any): string
    local args = unpack_(table.pack(...), 'rgba')
    local r, g, b, a = table.unpack(args, 1, 4)
    local lastArg = last(...)
    local mode = if lastArg == nil or lastArg == '' then 'auto' else lastArg
    if a == nil then
        a = 1
    end
    if mode == 'auto' then
        mode = if a < 1 then 'rgba' else 'rgb'
    end
    r = round(r)
    g = round(g)
    b = round(b)
    local u = bit32.bor(bit32.bor(bit32.lshift(r, 16), bit32.lshift(g, 8)), b)
    local str = '000000' .. string.format('%x', u) --#.toUpperCase();
    str = string.sub(str, 1 + #str - 6)
    local hxa = '0' .. string.format('%x', round(a * 255))
    hxa = string.sub(hxa, 1 + #hxa - 2)

    local mode_ = string.lower(mode)
    if mode_ == 'rgba' then
        return `#{str}{hxa}`
    elseif mode_ == 'argb' then
        return `#{hxa}{str}`
    else
        return `#{str}`
    end
end

return rgb2hex
