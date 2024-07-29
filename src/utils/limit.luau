-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/utils/limit.js

local function limit(x: number, min_: number?, max_: number?): number
    local min: number = if min_ ~= nil then min_ else 0
    local max: number = if max_ ~= nil then max_ else 1
    return if x < min then min else if x > max then max else x
end

return limit
