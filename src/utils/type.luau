-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/utils/type.js

-- ported from jQuery's $.type
local classToType = {}
-- for _, name in
--     {
--         'Boolean',
--         'Number',
--         'String',
--         'Function',
--         'Array',
--         'Date',
--         'RegExp',
--         'Undefined',
--         'Null',
--     }
-- do
-- classToType[tostring(('[object %s]'):format(tostring(name)))] = name:toLowerCase()
-- end

local function typeFn(obj: unknown)
    return classToType[tostring(obj)] or 'object'
end

return typeFn
