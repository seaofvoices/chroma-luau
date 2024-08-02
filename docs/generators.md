# Generators

### chroma.mix(color1, color2, ratio=0.5, mode='lrgb')

Mixes two colors. The mix _ratio_ is a value between 0 and 1.

```lua
chroma.mix('red', 'blue')
chroma.mix('red', 'blue', 0.25)
chroma.mix('red', 'blue', 0.75)
```

The color mixing produces different results based the color space used for interpolation.

```lua
chroma.mix('red', 'blue', 0.5, 'rgb')
chroma.mix('red', 'blue', 0.5, 'hsl')
chroma.mix('red', 'blue', 0.5, 'lab')
chroma.mix('red', 'blue', 0.5, 'lch')
chroma.mix('red', 'blue', 0.5, 'lrgb')
```

### chroma.average(colors, mode='lrgb', weights=[])

Similar to `chroma.mix`, but accepts more than two colors. Simple averaging of R,G,B components and the alpha channel.

```lua
colors = {'#ddd', 'yellow', 'red', 'teal'}
chroma.average(colors) -- lrgb
chroma.average(colors, 'rgb')
chroma.average(colors, 'lab')
chroma.average(colors, 'lch')
```

Also works with alpha channels.

```lua
chroma.average({'red', 'rgba(0,0,0,0.5)'}):css()
```

As of version 2.1 you can also provide an array of `weights` to
compute a **weighted average** of colors.

```lua
colors = {'#ddd', 'yellow', 'red', 'teal'}
chroma.average(colors, 'lch') -- unweighted
chroma.average(colors, 'lch', {1,1,2,1})
chroma.average(colors, 'lch', {1.5,0.5,1,2.3})
```

### chroma.blend(color1, color2, mode)

Blends two colors using RGB channel-wise blend functions. Valid blend modes are `multiply`, `darken`, `lighten`, `screen`, `overlay`, `burn`, and `dodge`.

```lua
chroma.blend('4CBBFC', 'EEEE22', 'multiply')
chroma.blend('4CBBFC', 'EEEE22', 'darken')
chroma.blend('4CBBFC', 'EEEE22', 'lighten')
```

### chroma.random()

Creates a random color by generating a [random hexadecimal string](https://github.com/gka/chroma.js/blob/main/src/generator/random.js).

```lua
chroma.random()
chroma.random()
chroma.random()
```

### chroma.scale(colors=['white','black'])

A color scale, created with `chroma.scale`, is a function that maps numeric values to a color palette. The default scale has the domain `0..1` and goes from white to black.

```lua
f = chroma.scale()
f(0.25)
f(0.5)
f(0.75)
```

You can pass an array of colors to `chroma.scale`. Any color that can be read by `chroma()` will work here, too. If you pass more than two colors, they will be evenly distributed along the gradient.

```lua
chroma.scale({'yellow', '008ae5'})
chroma.scale({'yellow', 'red', 'black'})
```

### scale.domain(domain)

You can change the input domain to match your specific use case.

```lua
-- default domain is [0,1]
chroma.scale({'yellow', '008ae5'})
-- set domain to [0,100]
chroma.scale({'yellow', '008ae5'}).domain({0,100})
```

You can use the domain to set the exact positions of each color.

```lua
-- default domain is [0,1]
chroma.scale({'yellow', 'lightgreen', '008ae5'})
    .domain({0,0.25,1})
```

### scale.mode(mode)

As with `chroma.mix`, the result of the color interpolation will depend on the color mode in which the channels are interpolated. The default mode is `RGB`:

```lua
chroma.scale({'yellow', '008ae5'})
```

This is often fine, but sometimes, two-color `RGB` gradients goes through kind of grayish colors, and `Lab` interpolation produces better results:

```lua
chroma.scale({'yellow', 'navy'})
chroma.scale({'yellow', 'navy'}).mode('lab')
```

Also note how the RGB interpolation can get very dark around the center. You can achieve better results using [linear RGB interpolation](https://www.youtube.com/watch?v=LKnqECcg6Gw):

```lua
chroma.scale({'#f00', '#0f0'})
chroma.scale({'#f00', '#0f0'}).mode('lrgb')
```

Other useful interpolation modes could be `HSL` or `Lch`, though both tend to produce too saturated / glowing gradients.

```lua
chroma.scale({'yellow', 'navy'}).mode('lab')
chroma.scale({'yellow', 'navy'}).mode('hsl')
chroma.scale({'yellow', 'navy'}).mode('lch')
```

### scale.gamma

Gamma-correction can be used to "shift" a scale's center more the the beginning (gamma < 1) or end (gamma > 1), typically used to "even" the lightness gradient. Default is 1.

```lua
chroma.scale('YlGn').gamma(0.5)
chroma.scale('YlGn').gamma(1)
chroma.scale('YlGn').gamma(2)
```

### scale.correctLightness

This makes sure the lightness range is spread evenly across a color scale. Especially useful when working with [multi-hue color scales](https://www.vis4.net/blog/mastering-multi-hued-color-scales/), where simple gamma correction can't help you very much.

```lua
chroma.scale({'black','red','yellow','white'})

chroma.scale({'black','red','yellow','white'})
    .correctLightness()
```

### scale.cache(true|false)

By default `chroma.scale` instances will cache each computed value => color pair. You can turn off the cache by setting

```lua
chroma.scale({'yellow', '008ae5'}).cache(false)
```

### scale.padding(pad)

Reduces the color range by cutting of a fraction of the gradient on both sides. If you pass a single number, the same padding will be applied to both ends.

```lua
chroma.scale('RdYlBu')
chroma.scale('RdYlBu').padding(0.15)
chroma.scale('RdYlBu').padding(0.3)
chroma.scale('RdYlBu').padding(-0.15)
```

Alternatively you can specify the padding for each sides individually by passing an array of two numbers.

```lua
chroma.scale('OrRd')
chroma.scale('OrRd').padding({0.2, 0})
```

### scale.colors(num, format='hex')

You can call `scale.colors(n)` to quickly grab `n` equi-distant colors from a color scale. If called with no arguments, `scale.colors` returns the original array of colors used to create the scale.

```lua
chroma.scale('OrRd').colors(5)
chroma.scale({'white', 'black'}).colors(12)
```

If you want to return `chroma` instances just pass _nil_ as `format`.

### scale.classes(numOrArray)

If you want the scale function to return a distinct set of colors instead of a continuous gradient, you can use `scale.classes`. If you pass a number the scale will broken into equi-distant classes:

```lua
-- continuous
chroma.scale('OrRd')
-- class breaks
chroma.scale('OrRd').classes(5)
chroma.scale('OrRd').classes(8)
```

You can also define custom class breaks by passing them as array:

```lua
chroma.scale('OrRd').classes({0,0.3,0.55,0.85,1})
```

### scale.nodata(color)

When you pass a non-numeric value like `nil` to a chroma.scale, "#cccccc" is returned as fallback or "no data" color. You can change the no-data color:

```lua
chroma.scale('OrRd')(nil)
chroma.scale('OrRd').nodata('#eee')(nil)
```

### chroma.brewer

chroma.js includes the definitions from [ColorBrewer2.org](http://colorbrewer2.org/). Read more about these colors [in the corresponding paper](https://www.cs.rpi.edu/~cutler/classes/visualization/S18/papers/colorbrewer.pdf) by Mark Harrower and Cynthia A. Brewer.

```lua
chroma.scale('YlGnBu')
chroma.scale('Spectral')
```

To reverse the colors you could simply reverse the domain:

```lua
chroma.scale('Spectral').domain({1, 0})
```

You can access the colors directly using `chroma.brewer`.

```lua
chroma.brewer.OrRd
```

### chroma.bezier(colors)

`chroma.bezier` returns a function that [bezier-interpolates between colors](https://www.vis4.net/blog/mastering-multi-hued-color-scales/) in `Lab` space. The input range of the function is `[0..1]`.

```lua
-- linear interpolation
chroma.scale({'yellow', 'red', 'black'})
-- bezier interpolation
chroma.bezier({'yellow', 'red', 'black'})
```

You can convert an bezier interpolator into a chroma.scale instance

```lua
chroma.bezier({'yellow', 'red', 'black'})
    .scale()
    .colors(5)
```

## cubehelix

### chroma.cubehelix(start=300, rotations=-1.5, hue=1, gamma=1, lightness=[0,1])

Dave Green's [cubehelix color scheme](http://www.mrao.cam.ac.uk/~dag/CUBEHELIX/)!!

```lua
-- use the default helix...
chroma.cubehelix()
-- or customize it
chroma.cubehelix()
    .start(200)
    .rotations(-0.5)
    .gamma(0.8)
    .lightness({0.3, 0.8})
```

### cubehelix.start(hue)

**start** color for [hue rotation](http://en.wikipedia.org/wiki/Hue#/media/File:HueScale.svg), default=`300`

```lua
chroma.cubehelix().start(300)
chroma.cubehelix().start(200)
```

### cubehelix.rotations(num)

number (and direction) of hue rotations (e.g. 1=`360°`, 1.5=`540°``), default=-1.5

```lua
chroma.cubehelix().rotations(-1.5)
chroma.cubehelix().rotations(0.5)
chroma.cubehelix().rotations(3)
```

### cubehelix.hue(numOrRange)

hue controls how saturated the colour of all hues are. either single value or range, default=1

```lua
chroma.cubehelix()
chroma.cubehelix().hue(0.5)
chroma.cubehelix().hue({1, 0})
```

### cubehelix.gamma(factor)

gamma factor can be used to emphasise low or high intensity values, default=1

```lua
chroma.cubehelix().gamma(1)
chroma.cubehelix().gamma(0.5)
```

### cubehelix.lightness(range)

lightness range: default: {0, 1} (black -> white)

```lua
chroma.cubehelix().lightness({0, 1})
chroma.cubehelix().lightness({1, 0})
chroma.cubehelix().lightness({0.3, 0.7})
```

### cubehelix.scale

You can call `cubehelix.scale()` to use the cube-helix through the `chroma.scale` interface.

```lua
chroma.cubehelix()
    .start(200)
    .rotations(-0.35)
    .gamma(0.7)
    .lightness({0.3, 0.8})
  .scale() -- convert to chroma.scale
    .correctLightness()
    .colors(5)
```
