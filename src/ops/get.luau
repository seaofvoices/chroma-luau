-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/ops/get.js
local Color = require('../Color')

function Color:get(mc: string)
    local parts = string.split(mc, '.')
    local mode, channel = parts[1], parts[2]
    local src = (self :: any)[mode](self)
    if channel and channel ~= '' then
        local index = string.find(mode, channel, nil, true)
        local i = index and (index - (if string.sub(mode, 1, 2) == 'ok' then 2 else 0))

        if i then
            return src[i]
        end

        error(`unknown channel {channel} in mode {mode}`)
    else
        return src
    end
end

return nil
