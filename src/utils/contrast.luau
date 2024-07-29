-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/utils/constrast.js
local Color = require('../Color')
require('../ops/luminance')

local function contrast(a: any, b: any): number
    -- WCAG contrast ratio
    -- see http://www.w3.org/TR/2008/REC-WCAG20-20081211/#contrast-ratiodef
    local a = Color.new(a)
    local b = Color.new(b)
    local l1 = a:luminance()
    local l2 = b:luminance()
    return if l1 > l2 then (l1 + 0.05) / (l2 + 0.05) else (l2 + 0.05) / (l1 + 0.05)
end

return contrast
