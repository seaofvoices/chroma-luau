-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/utils/analyze.js

local Math_LOG10E = 0.4342944819032518

local Collections = require('@pkg/@jsdotlua/collections')
local Number = require('@pkg/@jsdotlua/number')

local Object = Collections.Object

local NUMBER_MAX_VALUE =
    179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368

local log, pow, floor, abs = math.log, math.pow, math.floor, math.abs

-- deviation: pre-declare variables
local limits

export type AnalyzeResult = {
    min: number,
    max: number,
    sum: number,
    count: number,
    values: { number },
    domain: { number },
    limits: (string?, num: number?) -> { number },
}

local function analyze(data: { number? }, key: string?): AnalyzeResult
    local r = {
        min = NUMBER_MAX_VALUE,
        max = NUMBER_MAX_VALUE * -1,
        sum = 0,
        values = {},
        count = 0,
    }

    -- deviation: check if object using the type of the first key
    if type((next(data))) == 'string' then
        data = Object.values(data) :: any
    end

    for _, val in data do
        -- deviation: check if object using the type of the first key
        if key ~= nil and key ~= '' and type(val) == 'table' and type((next(val))) == 'string' then
            val = (val :: any)[key]
        end

        if val ~= nil and not Number.isNaN(val) then
            table.insert(r.values, val)
            r.sum += val
            if val < r.min then
                r.min = val
            end
            if val > r.max then
                r.max = val
            end
            r.count += 1
        end
    end

    r.domain = { r.min, r.max }

    r.limits = function(mode, num)
        return limits(r, mode, num)
    end

    return r
end

function limits(data: { number? } | AnalyzeResult, mode_: string?, num_: number?): { number }
    local mode: string = if mode_ ~= nil then mode_ else 'equal'
    local num: number = if num_ ~= nil then num_ else 7

    -- deviation: replace object check with property check
    local data: AnalyzeResult = if (data :: any).count == nil then analyze(data) else data :: any

    local min, max = data.min, data.max
    -- deviation: replace with simple table.sort
    table.sort(data.values)
    local values = data.values

    if num == 1 then
        return { min, max }
    end

    local limits = {}

    local modeChar = string.sub(mode, 1, 1)

    if modeChar == 'c' then
        -- continuous
        table.insert(limits, min)
        table.insert(limits, max)
    end

    if modeChar == 'e' then -- equal interval
        table.insert(limits, min)
        do
            local i = 1
            while i < num do
                table.insert(limits, min + i / num * (max - min))
                i += 1
            end
        end
        table.insert(limits, max)
    elseif modeChar == 'l' then -- log scale
        if min <= 0 then
            error('Logarithmic scales are only possible for values > 0')
        end
        local min_log = Math_LOG10E * log(min)
        local max_log = Math_LOG10E * log(max)
        table.insert(limits, min)
        do
            local i = 1
            while i < num do
                table.insert(limits, pow(10, min_log + i / num * (max_log - min_log)))
                i += 1
            end
        end
        table.insert(limits, max)
    elseif modeChar == 'q' then -- quantile scale
        table.insert(limits, min)

        for i = 1, num - 1 do
            local p = (#values - 1) * i / num
            local pb = floor(p)
            if pb == p then
                -- deviation: add 1 for 1-indexed array
                table.insert(limits, values[pb + 1])
            else -- p > pb
                local pr = p - pb
                -- deviation: add 1 for 1-indexed array
                table.insert(limits, values[pb + 1] * (1 - pr) + values[pb + 1 + 1] * pr)
            end
        end
        table.insert(limits, max)
    elseif modeChar == 'k' then -- k-means clustering
        --[[
		implementation based on
		http://code.google.com/p/figue/source/browse/trunk/figue.js#336
		simplified for 1-d input values
    	]]
        local cluster
        local n = #values
        local assignments = table.create(n)
        local clusterSizes = table.create(num)
        local repeat_ = true
        local nb_iters = 0
        local centroids = nil

        -- get seed values
        centroids = {}
        table.insert(centroids, min)
        for i = 1, num - 1 do
            table.insert(centroids, min + i / num * (max - min))
        end
        table.insert(centroids, max)

        while repeat_ do
            -- assignment step
            for j = 1, num do
                clusterSizes[j] = 0
            end

            for i = 1, n do
                local value = values[i]
                local mindist = NUMBER_MAX_VALUE
                local best
                for j = 1, num do
                    local dist = abs(centroids[j] - value)
                    if dist < mindist then
                        mindist = dist
                        best = j
                    end
                    clusterSizes[best] += 1
                    assignments[i] = best
                end
            end

            -- update centroids step
            local newCentroids = table.create(num)

            -- deviation: no need to initialize to null
            -- for j=1, num do
            -- 	newCentroids[j] = nil
            -- end

            for i = 1, n do
                cluster = assignments[i]
                if newCentroids[cluster] == nil then
                    newCentroids[cluster] = values[i]
                else
                    newCentroids[cluster] += values[i]
                end
            end

            for j = 1, num do
                newCentroids[j] *= 1 / clusterSizes[j]
            end

            -- check convergence
            repeat_ = false
            for j = 1, num do
                if newCentroids[j] ~= centroids[j] then
                    repeat_ = true
                    break
                end
            end

            centroids = newCentroids
            nb_iters += 1

            if nb_iters > 200 then
                repeat_ = false
            end
        end

        -- finished k-means clustering
        -- the next part is borrowed from gabrielflor.it
        local kClusters = {}
        for j = 1, num do
            kClusters[j] = {}
        end

        for i = 1, n do
            cluster = assignments[i]
            table.insert(kClusters[cluster], values[i])
        end

        local tmpKMeansBreaks = {}
        for j = 1, num do
            table.insert(tmpKMeansBreaks, kClusters[j][1])
            table.insert(tmpKMeansBreaks, kClusters[j][#kClusters[j]])
        end

        -- deviation: use simple table.sort
        table.sort(tmpKMeansBreaks)
        table.insert(limits, tmpKMeansBreaks[1])

        for i = 1, #tmpKMeansBreaks, 2 do
            local v = tmpKMeansBreaks[i]
            -- deviation: use table.find instead of Array.indexOf
            if not Number.isNaN(v) and table.find(limits, v) == nil then
                table.insert(limits, v)
            end
        end
    end

    return limits
end

return {
    analyze = analyze,
    limits = limits,
}
