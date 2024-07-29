-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/utils/distance.js
local Color = require('../Color')

-- simple Euclidean distance
local function distance(a: any, b: any, mode: string?): number
    local mode = if mode ~= nil then mode else 'lab'
    -- Delta E (CIE 1976)
    -- see http://www.brucelindbloom.com/index.html?Equations.html
    local a = Color.new(a)
    local b = Color.new(b)
    local l1 = a:get(mode) :: { number }
    local l2 = b:get(mode) :: { number }
    local sum_sq = 0
    for i in l1 do
        local d = (l1[i] or 0) - (l2[i] or 0)
        sum_sq += d * d
    end
    return math.sqrt(sum_sq)
end

return distance
