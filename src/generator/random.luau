-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/generator/random.js
local Color = require('../Color')
local digits = string.split('0123456789abcdef', '')

type Color = Color.Color

local function random(): Color
    -- deviation: simplify for Luau
    local chars = table.create(6, '')
    for i = 1, 6 do
        chars[i] = digits[math.random(1, 16)]
    end
    return Color.new(`#{table.concat(chars, '')}`, 'hex')
end

return random
