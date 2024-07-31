local chroma = require('./chroma')

export type Color = chroma.Color
export type AsColor = chroma.AsColor
export type ColorBrewerName = chroma.ColorBrewerName
export type ColorSpace = chroma.ColorSpace
export type InterpolationMode = chroma.InterpolationMode
export type Cubehelix = chroma.Cubehelix
export type Scale = chroma.Scale

-- feel free to comment out anything to rollup
-- a smaller chroma.js built

-- io --> convert colors
require('./io/cmyk')
require('./io/css')
require('./io/gl')
require('./io/hcg')
require('./io/hex')
require('./io/hsi')
require('./io/hsl')
require('./io/hsv')
require('./io/lab')
require('./io/lch')
require('./io/named')
require('./io/num')
require('./io/rgb')
require('./io/temp')
require('./io/oklab')
require('./io/oklch')
-- deviation: add roblox Color3 support
if _G.LUA_ENV == 'roblox' then
    require('./io/roblox')
end

-- operators --> modify existing Colors
require('./ops/alpha')
require('./ops/clipped')
require('./ops/darken')
require('./ops/get')
require('./ops/luminance')
require('./ops/mix')
require('./ops/premultiply')
require('./ops/saturate')
require('./ops/set')

-- interpolators
require('./interpolator/rgb')
require('./interpolator/lrgb')
require('./interpolator/lab')
require('./interpolator/lch')
require('./interpolator/num')
require('./interpolator/hcg')
require('./interpolator/hsi')
require('./interpolator/hsl')
require('./interpolator/hsv')
require('./interpolator/oklab')
require('./interpolator/oklch')

-- generators -- > create new colors
chroma.average = require('./generator/average')
chroma.bezier = require('./generator/bezier')
chroma.blend = require('./generator/blend')
chroma.cubehelix = require('./generator/cubehelix')
chroma.mix = require('./generator/mix')
chroma.interpolate = require('./generator/mix')
chroma.random = require('./generator/random')
chroma.scale = require('./generator/scale')

-- other utility methods
chroma.analyze = require('./utils/analyze').analyze
chroma.contrast = require('./utils/contrast')
chroma.deltaE = require('./utils/delta-e')
chroma.distance = require('./utils/distance')
chroma.limits = require('./utils/analyze').limits
chroma.valid = require('./utils/valid')

-- scale
chroma.scales = require('./utils/scales')

-- colors
chroma.colors = require('./colors/w3cx11')
chroma.brewer = require('./colors/colorbrewer')

return chroma
