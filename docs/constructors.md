# Constructors

This page highlights the various ways to create color objects. For information about the methods of color objects, read the [color](./color.md) page.

- [chroma](#chromacolor)
- [hsl](#chromahslhue-saturation-lightness)
- [hsv](#chromahsvhue-saturation-value)
- [lab](#chromalablightness-a-b)
- [oklab](#chromaoklablightness-a-b)
- [lch](#chromalchlightness-chroma-hue)
- [hcl](#chromahclhue-chroma-lightness)
- [oklch](#chromaoklchlightness-chromacity-hue)
- [cmyk](#chromacmykcyan-magenta-yellow-black)
- [gl](#chromaglred-green-blue-alpha)
- [temperature](#chromatemperaturek)

### chroma(*color*)

The first step is to get your color into chroma-luau. That's what the generic constructor `chroma()` does. This function attempts to guess the format of the input color for you. For instance, it will recognize any named color from the W3CX11 specification:

```lua
chroma('hotpink')
```

If there's no matching named color, chroma-luau checks for a **hexadecimal string**. It ignores case, the `#` sign is optional, and it can recognize the shorter three letter format as well. So, any of these are valid hexadecimal representations: `#ff3399`, `FF3399`, `#f39`, etc.

```lua
chroma('#ff3399')
chroma('F39')
```

In addition to hex strings, **hexadecimal numbers** (in fact, just any number between `0` and `16777215`) will be recognized, too.

```lua
chroma(0xff3399)
```

You also can pass RGB values individually. Each parameter must be within `0..255`. You can pass the numbers as individual arguments or as an array.

```lua
chroma(0xff, 0x33, 0x99)
chroma(255, 51, 153)
chroma({255, 51, 153})
```

You can construct colors from different color spaces by passing the name of color space as the last argument. Here we define the same color in HSL by passing the h*ue angle (0-360) and percentages for *s*aturation and *l*ightness:

```lua
chroma(330, 1, 0.6, 'hsl')
```

You can also construct colors by passing an plain JS object with attributes corresponding to a color space supported by chroma-luau:

```lua
chroma({ h = 120, s = 1, l = 0.75})
chroma({ l = 80, c = 25, h = 200 })
chroma({ c = 1, m = 0.5, y = 0, k = 0.2})
```

### chroma.hsl(hue, saturation, lightness)

Alternatively, every color space has its own constructor function under the `chroma` namespace. For a list of all supported color spaces, check the [appendix](#supported-color-spaces-and-output-formats).

```lua
chroma.hsl(330, 1, 0.6)
```

### chroma.hsv(hue, saturation, value)

### chroma.lab(lightness, a, b)

CIELAB color space

```lua
chroma.lab(40, -20, 50)
chroma.lab(50, -20, 50)
chroma.lab(80, -20, 50)
```

### chroma.oklab(lightness, a, b)

[Oklab color space](https://bottosson.github.io/posts/oklab/)

```lua
chroma.oklab(0.4, -0.2, 0.5)
chroma.oklab(0.5, -0.2, 0.5)
chroma.oklab(0.8, -0.2, 0.5)
```

### chroma.lch(lightness, chroma, hue)

The range for `lightness` and `chroma` depend on the hue, but go roughly from 0..100-150. The range for `hue` is 0..360.

```lua
chroma.lch(80, 40, 130)
chroma(80, 40, 130, 'lch')
```

### chroma.hcl(hue, chroma, lightness)

You can use **hcl** instead of Lch. Lightness and hue channels are switched to be more consistent with HSL.

```lua
chroma.hcl(130, 40, 80)
chroma(130, 40, 80, 'hcl')
```

### chroma.oklch(Lightness, chromacity, hue)

```lua
chroma.oklch(0.5, 0.2, 240)
chroma(0.8, 0.12, 60, 'oklch')
```

### chroma.cmyk(cyan, magenta, yellow, black)

Each between 0 and 1.

```lua
chroma.cmyk(0.2, 0.8, 0, 0)
chroma(0.2, 0.8, 0, 0, 'cmyk')
```

### chroma.gl(red, green, blue, [alpha])

**GL** is a variant of RGB(A), with the only difference that the components are normalized to the range of `0..1`.

```lua
chroma.gl(0.6, 0, 0.8)
chroma.gl(0.6, 0, 0.8, 0.5)
chroma(0.6, 0, 0.8, 'gl')
```

### chroma.temperature(K)

Returns a color from the [color temperature](https://web.archive.org/web/20220618201011/http://www.zombieprototypes.com/?p=210) scale. Based on [Neil Bartlett's implementation](https://github.com/neilbartlett/color-temperature).

```lua
chroma.temperature(2000) -- candle light
chroma.temperature(3500) -- sunset
chroma.temperature(6500) -- daylight
```

The effective temperature range goes from `0` to about `30000` Kelvin,

```lua
local function f(i: number)
    return chroma.temperature(i * 30000)
end
```
