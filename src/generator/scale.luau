-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/generator/scale.js
local Collections = require('@pkg/@jsdotlua/collections')
local Number = require('@pkg/@jsdotlua/number')

local Array = Collections.Array
-- minimal multi-purpose interface

-- @requires utils color analyze
local ScaleTypes = require('../types/scale-types')
local chroma = require('../chroma')

type Color = chroma.Color
type AsColor = chroma.AsColor
export type Scale = ScaleTypes.Scale
type InterpolationMode = ScaleTypes.InterpolationMode

local pow = math.pow

local function isCallable(value: unknown): boolean
    local valueType = type(value)

    if valueType == 'table' then
        local metatable = getmetatable(value :: any)

        return metatable ~= nil and type(metatable.__call) == 'function'
    end
    return valueType == 'function'
end

-- deviation: pre-declare variables
local __range__

local function scale(colors: string | { AsColor }?): Scale
    -- constructor
    local _mode: InterpolationMode = 'rgb'
    local _nacol = chroma('#ccc')
    local _spread = 0
    -- const _fixed = false;
    local _domain = { 0, 1 }
    local _pos = {}
    local _padding = { 0, 0 }
    local _classes: { number } = false :: any
    local _colors: { Color } = {}
    local _out: false | string = false
    local _min = 0
    local _max = 1
    local _correctLightness = false
    local _colorCache = {}
    local _useCache = true
    local _gamma = 1

    -- deviation: pre-declare variables
    local resetCache

    -- private methods

    local function setColors(colors: string | { AsColor }?): { Color }
        colors = if colors == nil or colors == '' then { '#fff', '#000' } else colors
        -- deviation: brewer always exist
        if
            colors ~= nil
            and type(colors) == 'string'
            and colors ~= ''
            and chroma.brewer[string.lower(colors)] ~= nil
        then
            colors = chroma.brewer[string.lower(colors)]
        end

        -- deviation: use default type function
        if type(colors) == 'table' then
            -- handle single color
            if #colors == 1 then
                colors = { colors[1], colors[1] } :: any
            end
            -- make a copy of the colors
            -- deviation: replace Array.slice with simple table clone
            colors = table.clone(colors)

            for c = 1, #colors do
                colors[c] = chroma(colors[c])
            end

            -- auto-fill color position
            _pos = {}
            -- deviation: adjust for 1-indexed arrays
            for c = 0, #colors - 1 do
                table.insert(_pos, c / (#colors - 1))
            end
        end
        resetCache()
        _colors = colors :: any
        return _colors
    end

    local function getClass(value): number
        if _classes then
            local n = #_classes - 1
            local i = 0
            -- deviation: adjust for 1-indexed arrays
            while i < n and value >= _classes[i + 1] do
                i += 1
            end
            return i - 1
        end
        return 0
    end

    local function tMapLightness(t: number): number
        return t
    end

    local function tMapDomain(t: number): number
        return t
    end

    -- const classifyValue = function(value) {
    --     let val = value;
    --     if (_classes.length > 2) {
    --         const n = _classes.length-1;
    --         const i = getClass(value);
    --         const minc = _classes[0] + ((_classes[1]-_classes[0]) * (0 + (_spread * 0.5)));  // center of 1st class
    --         const maxc = _classes[n-1] + ((_classes[n]-_classes[n-1]) * (1 - (_spread * 0.5)));  // center of last class
    --         val = _min + ((((_classes[i] + ((_classes[i+1] - _classes[i]) * 0.5)) - minc) / (maxc-minc)) * (_max - _min));
    --     }
    --     return val;
    -- };

    local function getColor(val: number?, bypassMap: boolean?): Color
        local col, t
        if bypassMap == nil then
            bypassMap = false
        end
        if Number.isNaN(val) or val == nil then
            return _nacol
        end
        -- deviation: re-declare val for type narrowing
        local val = val :: number
        if not bypassMap then
            if _classes and #_classes > 2 then
                -- find the class
                local c = getClass(val)
                t = c / (#_classes - 2)
            elseif _max ~= _min then
                -- just interpolate between min/max
                t = (val - _min) / (_max - _min)
            else
                t = 1
            end
        else
            t = val
        end

        -- domain map
        t = tMapDomain(t)

        if not bypassMap then
            t = tMapLightness(t) -- lightness correction
        end

        if _gamma ~= 1 then
            t = pow(t, _gamma)
        end

        t = _padding[1] + t * (1 - _padding[1] - _padding[2])

        t = math.min(1, math.max(0, t))

        local k = math.floor(t * 10000)

        if _useCache and _colorCache[k + 1] then
            col = _colorCache[k + 1]
        else
            -- deviation: use default type function and flip if branches to avoid
            -- callable table to enter the now second branch
            if isCallable(_colors) then
                col = (_colors :: any)(t)
            elseif type(_colors) == 'table' then
                --for i in [0.._pos.length-1]
                for i, p in _pos do
                    if t <= p then
                        col = _colors[i]
                        break
                    end
                    -- deviation: adjust for 1-indexed arrays
                    if t >= p and i == #_pos then
                        col = _colors[i]
                        break
                    end
                    if t > p and t < _pos[i + 1] then
                        t = (t - p) / (_pos[i + 1] - p)
                        col = chroma.interpolate(_colors[i], _colors[i + 1], t, _mode)
                        break
                    end
                end
            end
            if _useCache then
                _colorCache[k + 1] = col
            end
        end
        return col
    end

    function resetCache()
        _colorCache = {}
    end

    setColors(colors)

    -- public interface

    -- deviation: use callable table
    local function callF(_self, v: number?): Color | { number } | string | number
        local c = chroma(getColor(v))
        if _out and _out ~= '' and c[_out] then
            return c[_out](c)
        else
            return c
        end
    end
    local f = setmetatable({}, { __call = callF })

    function f.classes(classes: number | { number }): { number } | Scale
        if classes ~= nil then
            -- deviation: use default type function
            if type(classes) == 'table' then
                _classes = classes
                _domain = {
                    classes[1],
                    classes[#classes - 1],
                }
            else
                local d = chroma.analyze(_domain)
                if classes == 0 then
                    _classes = { d.min, d.max }
                else
                    _classes = chroma.limits(d, 'e', classes)
                end
            end
            return f :: Scale
        end
        return _classes
    end

    function f.domain(domain: { number }?): { number } | Scale
        if domain == nil then
            return _domain
        end
        local domain = domain :: { number }

        _min = domain[1]
        local domainLength = #domain
        _max = domain[domainLength]
        _pos = {}
        local k = #_colors
        if domainLength == k and _min ~= _max then
            -- update positions
            -- deviation: domain is already an array
            for _, d in domain do
                table.insert(_pos, (d - _min) / (_max - _min))
            end
        else
            for c = 0, k - 1 do
                table.insert(_pos, c / (k - 1))
            end

            if domainLength > 2 then
                -- set domain map
                local tOut = Array.map(domain, function(_d: number, i: number)
                    return (i - 1) / (domainLength - 1)
                end)
                local tBreaks = Array.map(domain, function(d: number)
                    return (d - _min) / (_max - _min)
                end)
                if
                    not Array.every(tBreaks, function(val, i)
                        return tOut[i] == val
                    end)
                then
                    tMapDomain = function(t: number): number
                        if t <= 0 or t >= 1 then
                            return t
                        end
                        local i = 1
                        while t >= tBreaks[i + 1] do
                            i += 1
                        end
                        local f = (t - tBreaks[i]) / (tBreaks[i + 1] - tBreaks[i])
                        local out = tOut[i] + f * (tOut[i + 1] - tOut[i])
                        return out
                    end
                end
            end
        end
        _domain = { _min, _max }
        return f :: Scale
    end

    function f.mode(_m: InterpolationMode?): InterpolationMode | Scale
        if _m == nil then
            return _mode
        end
        _mode = _m :: InterpolationMode
        resetCache()
        return f :: Scale
    end

    -- deviation: remove unused parameter `_pos`
    function f.range(colors): Scale
        setColors(colors)
        return f :: Scale
    end

    function f.out(_o): Scale
        _out = _o
        return f :: Scale
    end

    function f.spread(val: number?): number | Scale
        if val == nil then
            return _spread
        end
        _spread = val :: number
        return f :: Scale
    end

    function f.correctLightness(v: boolean?): Scale
        if v == nil then
            v = true
        end
        _correctLightness = v :: boolean
        resetCache()
        if _correctLightness then
            tMapLightness = function(t: number): number
                local L0 = getColor(0, true):lab()[1]
                local L1 = getColor(1, true):lab()[1]
                local pol = L0 > L1
                local L_actual = getColor(t, true):lab()[1]
                local L_ideal = L0 + (L1 - L0) * t
                local L_diff = L_actual - L_ideal
                local t0 = 0
                local t1 = 1
                local max_iter = 20

                -- deviation: avoid immediately fired function execution caused by `max_iter--`
                while math.abs(L_diff) > 1e-2 and max_iter > 0 do
                    max_iter -= 1

                    -- deviation: avoid immediately fired function execution caused by `max_iter--`
                    if pol then
                        L_diff *= -1
                    end
                    if L_diff < 0 then
                        t0 = t
                        t += (t1 - t) * 0.5
                    else
                        t1 = t
                        t += (t0 - t) * 0.5
                    end
                    L_actual = getColor(t, true):lab()[1]
                    L_diff = L_actual - L_ideal
                end
                return t
            end
        else
            tMapLightness = function(t: number): number
                return t
            end
        end
        return f :: Scale
    end

    function f.padding(p: number | { number }): { number } | Scale
        if p ~= nil then
            -- deviation: use default type function
            if type(p) == 'number' then
                p = { p, p }
            end
            _padding = p :: { number }
            return f :: Scale
        else
            return _padding
        end
    end

    function f.colors(...)
        local numColors: number, out: string? = ...
        -- If no arguments are given, return the original colors that were provided
        local argumentsLength = select('#', ...)
        if argumentsLength < 2 then
            out = 'hex'
        end

        local result = {}

        if argumentsLength == 0 then
            -- deviation: replace Array.slice with simple table clone
            result = table.clone(_colors)
        elseif numColors == 1 then
            result = { f(0.5) }
        elseif numColors > 1 then
            local dm = _domain[1]
            local dd = _domain[2] - dm
            local numColors = numColors :: number
            result = Array.map(__range__(0, numColors, false), function(i: number)
                return f(dm + (i / (numColors - 1) * dd))
            end)
        else
            -- returns all colors based on the defined classes
            colors = {}
            local samples = {}
            if _classes and #_classes > 2 then
                local end_ = #_classes
                local asc = 1 <= end_
                for i = 2, end_, if asc then 1 else -1 do
                    table.insert(samples, (_classes[i - 1] + _classes[i]) * 0.5)
                end
            else
                samples = _domain
            end
            result = Array.map(samples, function(v)
                return f(v)
            end)
        end
        if out and (chroma :: any)[out] then
            result = Array.map(result, function(c)
                return c[out](c)
            end)
        end
        return result
    end

    function f.cache(c: boolean?): boolean | Scale
        if c ~= nil then
            _useCache = c
            return f :: Scale
        else
            return _useCache
        end
    end

    function f.gamma(g: number?): number | Scale
        if g ~= nil then
            _gamma = g
            return f :: Scale
        else
            return _gamma
        end
    end

    function f.nodata(d: AsColor?): Color | Scale
        if d ~= nil then
            _nacol = chroma(d)
            return f :: Scale
        else
            return _nacol
        end
    end

    return f :: Scale
end

function __range__(left: number, right: number, inclusive: boolean): { number }
    local range = {}
    local ascending = left < right
    local end_ = if not inclusive then right else (if ascending then right + 1 else right - 1)

    local step = if ascending then 1 else -1
    for i = left, end_ - step, step do
        table.insert(range, i)
    end
    return range
end

return scale
