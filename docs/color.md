# Color

This page highlights the various methods available on Color objects. For information about how to construct a color object, read the [constructors](./constructors.md) page.

- [alpha](#coloralphaa)
- [darken](#colordarkenvalue1)
- [brighten](#colorbrightenvalue1)
- [saturate](#colorsaturatevalue1)
- [desaturate](#colordesaturatevalue1)
- [set](#colorsetchannel-value)
- [get](#colorgetchannel)
- [luminance](#colorluminancelum-modergb)
- [hex](#colorhexmodeautorgbrgba)
- [rgb](#colorrgbaroundtrue)
- [rgba](#colorrgbaroundtrue)
- [hsl](#colorhsl)
- [hsv](#colorhsv)
- [hsi](#colorhsi)
- [lab](#colorlab)
- [oklab](#coloroklab)
- [lch](#colorlch)
- [hcl](#colorhcl)
- [oklch](#coloroklch)
- [num](#colornum)
- [temperature](#colortemperature)
- [gl](#colorgl)
- [clipped](#colorclipped)

## color:alpha(a)

Get and set the color opacity using ``color.alpha``.

```lua
chroma('red'):alpha(0.5)
chroma('rgba(255,0,0,0.35)'):alpha()
```

## color:darken(value=1)

Once loaded, chroma.js can change colors. One way we already saw above, you can change the lightness.

```lua
chroma('hotpink').darken()
chroma('hotpink').darken(2)
chroma('hotpink').darken(2.6)
```

## color:brighten(value=1)

Similar to `darken`, but the opposite direction

```lua
chroma('hotpink').brighten()
chroma('hotpink').brighten(2)
chroma('hotpink').brighten(3)
```

## color:saturate(value=1)

Changes the saturation of a color by manipulating the Lch chromaticity.

```lua
chroma('slategray').saturate()
chroma('slategray').saturate(2)
chroma('slategray').saturate(3)
```

## color:desaturate(value=1)

Similar to `saturate`, but the opposite direction.

```lua
chroma('hotpink').desaturate()
chroma('hotpink').desaturate(2)
chroma('hotpink').desaturate(3)
```


## color:set(channel, value)

Changes a single channel and returns the result a new `chroma` object.

```lua
-- change hue to 0 deg (=red)
chroma('skyblue'):set('hsl.h', 0)
-- set chromaticity to 30
chroma('hotpink'):set('lch.c', 30)
```

Relative changes work, too:

```lua
-- half Lab lightness
chroma('orangered'):set('lab.l', '*0.5')
-- double Lch saturation
chroma('darkseagreen'):set('lch.c', '*2')
```

## color:get(channel)

Returns a single channel value.

```lua
chroma('orangered'):get('lab.l')
chroma('orangered'):get('hsl.l')
chroma('orangered'):get('rgb.g')
```

## color:luminance([lum, mode='rgb'])

If called without arguments color.luminance returns the relative brightness, according to the [WCAG definition](http://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef). Normalized to `0` for darkest black and `1` for lightest white.

```lua
chroma('white'):luminance()
chroma('aquamarine'):luminance()
chroma('hotpink'):luminance()
chroma('darkslateblue'):luminance()
chroma('black'):luminance()
```

chroma.js also allows you to **adjust the luminance** of a color. The source color will be interpolated with black or white until the correct luminance is found.

```lua
-- set lumincance to 50% for all colors
chroma('white'):luminance(0.5)
chroma('aquamarine'):luminance(0.5)
chroma('hotpink'):luminance(0.5)
chroma('darkslateblue'):luminance(0.5)
```

By default, this interpolation is done in RGB, but you can interpolate in different color spaces by passing them as second argument:

```lua
chroma('aquamarine'):luminance(0.5) -- rgb
chroma('aquamarine'):luminance(0.5, 'lab')
chroma('aquamarine'):luminance(0.5, 'hsl')
```

## color:hex(mode='auto|rgb|rgba')

Finally, chroma.js allows you to output colors in various color spaces and formats. Most often you will want to output the color as hexadecimal string.

```lua
chroma('orange'):hex()
```

**Note** that as of version 1.4.0 the default mode is "auto" which means that the hex string will include the alpha channel if it's less than 1. If you don't want the alpha channel to be included you must explicitly set the mode to "rgb" now:

```lua
chroma('orange'):hex()
chroma('orange'):alpha(0.5):hex()
chroma('orange'):alpha(0.5):hex('rgb')
```

## color.name

Returns the named color. Falls back to hexadecimal RGB string, if the color isn't present.

```lua
chroma('#ffa500'):name()
chroma('#ffa505'):name()
```

## color.css

Returns a `RGB()` or `HSL()` string representation that can be used as CSS-color definition.

```lua
chroma('teal'):css()
chroma('teal'):alpha(0.5):css()
chroma('teal'):css('hsl')
```

## color:rgb(round=true)

Returns an array with the `red`, `green`, and `blue` component, each as number within the range `0..255`. Chroma internally stores RGB channels as floats but rounds the numbers before returning them. You can pass `false` to prevent the rounding.

```lua
chroma('orange'):rgb()
chroma('orange'):darken():rgb()
chroma('orange'):darken():rgb(false)
```

## color:rgba(round=true)

Just like `color.rgb` but adds the alpha channel to the returned array.

```lua
chroma('orange'):rgba()
chroma('hsla(20, 100%, 40%, 0.5)'):rgba()
```

## color:hsl()

Returns an array with the `hue`, `saturation`, and `lightness` component. Hue is the color angle in degree (`0..360`), saturation and lightness are within `0..1`. Note that for hue-less colors (black, white, and grays), the hue component will be NaN.

```lua
chroma('orange'):hsl()
chroma('white'):hsl()
```

## color:hsv()

Returns an array with the `hue`, `saturation`, and `value` components. Hue is the color angle in degree (`0..360`), saturation and value are within `0..1`. Note that for hue-less colors (black, white, and grays), the hue component will be NaN.

```lua
chroma('orange'):hsv()
chroma('white'):hsv()
```

## color:hsi()

Returns an array with the `hue`, `saturation`, and `intensity` components. Hue is the color angle in degree (`0..360`), saturation and intensity are within `0..1`. Note that for hue-less colors (black, white, and grays), the hue component will be NaN.

```lua
chroma('orange'):hsi()
chroma('white'):hsi()
```

## color:lab()

Returns an array with the **L**, **a**, and **b** components.

```lua
chroma('orange'):lab()
```

## color:oklab()

Returns an array with the **L**, **a**, and **b** components.

```lua
chroma('orange'):oklab()
```


## color:lch()

Returns an array with the **Lightness**, **chroma**, and **hue** components.

```lua
chroma('skyblue'):lch()
```

## color:hcl()

Alias of [lch](#color-lch), but with the components in reverse order.

```lua
chroma('skyblue'):hcl()
```

## color:oklch()

Returns an array with the **Lightness**, **chroma**, and **hue** components.

```lua
chroma('skyblue'):oklch()
```

## color:num()

Returns the numeric representation of the hexadecimal RGB color.

```lua
chroma('#000000'):num()
chroma('#0000ff'):num()
chroma('#00ff00'):num()
chroma('#ff0000'):num()
```

## color:temperature()

Estimate the temperature in Kelvin of any given color, though this makes the only sense for colors from the [temperature gradient](#chroma-temperature) above.

```lua
chroma('#ff3300'):temperature()
chroma('#ff8a13'):temperature()
chroma('#ffe3cd'):temperature()
chroma('#cbdbff'):temperature()
chroma('#b3ccff'):temperature()
```

## color:gl()

Like RGB, but in the channel range of `[0..1]` instead of `[0..255]`

```lua
chroma('33cc00').gl()
```

## color:clipped()

When converting colors from CIELab color spaces to RGB the color channels get clipped to the range of `[0..255]`. Colors outside that range may exist in nature but are not displayable on RGB monitors (such as ultraviolet). you can use color.clipped to test if a color has been clipped or not.

```lua
local c = chroma.hcl(50, 40, 20)
print(c:clipped())
local c = chroma.hcl(50, 40, 40)
print(c:clipped())
local c = chroma.hcl(50, 40, 60)
print(c:clipped())
local c = chroma.hcl(50, 40, 80)
print(c:clipped())
local c = chroma.hcl(50, 40, 100)
print(c:clipped())
```

As a bonus feature you can access the unclipped RGB components using `color._rgb._unclipped`.

```lua
chroma.hcl(50, 40, 100).rgb()
chroma.hcl(50, 40, 100)._rgb._unclipped
```
