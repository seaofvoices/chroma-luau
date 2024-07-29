-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/num/num2rgb.js

-- deviation: use the default type function
local type_ = type -- require('../../utils').type

local function num2rgb(num: any)
    if type_(num) == 'number' and num >= 0 and num <= 0xFFFFFF then
        local r = bit32.arshift(num, 16)
        local g = bit32.band(bit32.arshift(num, 8), 0xFF)

        local b = bit32.band(num, 0xFF)
        return { r, g, b, 1 }
    end

    error(`unknown num color: {num}'`)
end

return num2rgb
