local ColorTypes = require('./color-types')

type Color = ColorTypes.Color
type AsColor = ColorTypes.AsColor

export type BlendMode =
    'normal'
    | 'multiply'
    | 'screen'
    | 'overlay'
    | 'darken'
    | 'lighten'
    | 'dodge'
    | 'burn'

type BlendFn = ({ number }, { number }) -> { number }

export type Blend = ((AsColor, AsColor, mode: BlendMode) -> Color) & {
    normal: BlendFn,
    multiply: BlendFn,
    screen: BlendFn,
    overlay: BlendFn,
    darken: BlendFn,
    lighten: BlendFn,
    dodge: BlendFn,
    burn: BlendFn,
}

return nil
