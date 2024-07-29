-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/utils/unpack.js

local Collections = require('@pkg/@jsdotlua/collections')
local Array = Collections.Array

local function unpack(args: { [number]: any, n: number }, keyOrder_: string?): { number }
    local keyOrder: any = if keyOrder_ ~= nil then keyOrder_ else nil

    -- if called with more than 3 arguments, we return the arguments
    if args.n >= 3 then
        -- deviation: replace Array.slice with a simple clone
        return { table.unpack(args, 1, args.n) }
        -- local result = table.clone(args)
        -- result.n = nil :: any
        -- return result
    end

    -- with less than 3 args we check if first arg is object
    -- and use the keyOrder string to extract and sort properties
    -- deviation: check if the keys of the table are of string type
    if
        type(args[1]) == 'table'
        and type((next(args[1]))) == 'string'
        and (keyOrder ~= nil and keyOrder ~= '')
    then
        return Array.map(
            Array.filter(string.split(keyOrder, ''), function(k)
                return args[1][k] ~= nil
            end),
            function(k)
                return args[1][k]
            end
        )
    end

    -- otherwise we just return the first argument
    -- (which we suppose is an array of args)
    return args[1]
end

return unpack
