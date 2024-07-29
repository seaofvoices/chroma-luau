-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/utils/valid.js
local Color = require('../Color')

local function valid(...: any): boolean
    -- deviation: simplify with pcall
    local success = pcall(Color.new, ...)
    return success
end

return valid
