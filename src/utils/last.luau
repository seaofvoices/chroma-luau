-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/utils/last.js

-- deviation: use the default type function
local type_ = type -- require_('./type')

local function last(...: any): string?
    local length = select('#', ...)
    if length < 2 then
        return nil
    end
    local lastArgument = select(length, ...)
    if type_(lastArgument) == 'string' then
        return string.lower(lastArgument)
    end
    return nil
end

return last
