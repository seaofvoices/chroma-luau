-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/hex/hex2rgb.js
local Regexp = require('@pkg/luau-regexp')

local RE_HEX = Regexp('^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')
local RE_HEXA = Regexp('^#?([A-Fa-f0-9]{8}|[A-Fa-f0-9]{4})$')

local function hex2rgb(hex: string): { number }
    local hexLength = #hex
    if RE_HEX:test(hex) then
        -- remove optional leading #
        if hexLength == 4 or hexLength == 7 then
            hex = string.sub(hex, 2)
            hexLength = #hex
        end
        -- expand short-notation to full six-digit
        if hexLength == 3 then
            local hexChars = string.split(hex, '')
            hex = hexChars[1]
                .. hexChars[1]
                .. hexChars[2]
                .. hexChars[2]
                .. hexChars[3]
                .. hexChars[3]
        end
        local u = tonumber(hex, 16) :: number
        local r = bit32.arshift(u, 16)
        local g = bit32.band(bit32.arshift(u, 8), 0xFF)
        local b = bit32.band(u, 0xFF)
        return { r, g, b, 1 }
    end

    -- match rgba hex format, eg #FF000077
    if RE_HEXA:test(hex) then
        if hexLength == 5 or hexLength == 9 then
            -- remove optional leading #
            hex = string.sub(hex, 2)
            hexLength = #hex
        end
        -- expand short-notation to full eight-digit
        if hexLength == 4 then
            local hexChars = string.split(hex, '')
            hex = hexChars[1]
                .. hexChars[1]
                .. hexChars[2]
                .. hexChars[2]
                .. hexChars[3]
                .. hexChars[3]
                .. hexChars[4]
                .. hexChars[4]
        end
        local u = tonumber(hex, 16) :: number
        local r = bit32.band(bit32.arshift(u, 24), 0xFF)
        local g = bit32.band(bit32.arshift(u, 16), 0xFF)
        local b = bit32.band(bit32.arshift(u, 8), 0xFF)
        local a = math.round(bit32.band(u, 0xFF) / 0xFF * 100) / 100
        return { r, g, b, a }
    end

    -- we used to check for css colors here
    -- if _input.css? and rgb = _input.css hex
    --     return rgb

    error(`unknown hex color: {hex}` .. debug.traceback(''))
end

return hex2rgb
