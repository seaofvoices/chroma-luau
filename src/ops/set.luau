-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/ops/set.js
local Color = require('../Color')

type PrivateColor = Color.PrivateColor

function Color:set(mc: string, value: string | number, mutate: boolean?)
    local self: PrivateColor = self :: any

    local parts = string.split(mc, '.')
    local mode, channel = parts[1], parts[2]
    local src = (self :: any)[mode](self)

    if channel and channel ~= '' then
        local index = string.find(mode, channel, nil, true)
        local i = index and (index - (if string.sub(mode, 1, 2) == 'ok' then 2 else 0))

        if i then
            -- deviation: use default type function
            if type(value) == 'string' then
                local condition = string.sub(value, 1, 1)
                if condition == '+' then
                    src[i] += tonumber(value)
                -- selene: allow(if_same_then_else)
                elseif condition == '-' then
                    src[i] += tonumber(value)
                elseif condition == '*' then
                    src[i] *= tonumber(string.sub(value, 2))
                elseif condition == '/' then
                    src[i] /= tonumber(string.sub(value, 2))
                else
                    src[i] = tonumber(value)
                end
            -- deviation: use default type function
            elseif type(value) == 'number' then
                src[i] = value
            else
                error('unsupported value for Color.set')
            end
            local out = Color.new(src, mode)
            if mutate then
                self._rgb = (out :: PrivateColor)._rgb
                return self
            end
            return out
        end

        error(`unknown channel {channel} in mode {mode}`)
    else
        return src
    end
end

return nil
