-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/utils/index.js
local PI = math.pi

return {
    clip_rgb = require('./clip_rgb'),
    limit = require('./limit'),
    type = require('./type'),
    unpack = require('./unpack'),
    last = require('./last'),
    PI = PI,
    TWOPI = PI * 2,
    PITHIRD = PI / 3,
    DEG2RAD = PI / 180,
    RAD2DEG = 180 / PI,
}
