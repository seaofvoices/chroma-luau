local ColorTypes = require('./color-types')

type Color = ColorTypes.Color

export type Cubehelix = ((number) -> Color) & {
    start: (() -> number) & ((number) -> Cubehelix),
    rotations: (() -> number) & ((number) -> Cubehelix),
    gamma: (() -> number) & ((number) -> Cubehelix),
    hue: (() -> number | { number }) & ((number | { number }) -> Cubehelix),
    lightness: (() -> { number }) & ((number | { number }) -> Cubehelix),
}

return nil
