-- deviation: a utility to round numbers without introducing -0 floats

local function round(value: number): number
    local rounded = math.round(value)

    return if rounded == 0 then 0 else rounded
end

return round
