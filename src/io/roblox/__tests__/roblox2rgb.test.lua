local jestGlobals = require('@pkg/@jsdotlua/jest-globals')

local chroma = require('../../..')

local expect = jestGlobals.expect
local test = jestGlobals.test
local describe = jestGlobals.describe

if _G.LUA_ENV ~= 'roblox' then
    return
end

test('build a color from a Roblox Color3', function()
    expect(chroma(Color3.fromRGB(25, 50, 100)):rgb()).toEqual({ 25, 50, 100 })
end)

test('build a color with opacity from a Roblox Color3', function()
    expect(chroma.roblox(Color3.fromRGB(25, 200, 75), 0.5):rgba()).toEqual({ 25, 200, 75, 0.5 })
end)

describe('convert w3cx11 colors to Roblox', function()
    for name, hexCode in chroma.colors :: { [string]: string } do
        test(`convert '{name}' to Roblox Color3`, function()
            local color = chroma.hex(hexCode)
            expect(color:roblox()).toEqual(Color3.fromHex(hexCode))
        end)
    end
end)
