# Utils

- [chroma.valid](#chromavalid)
- [chroma.contrast](#chromacontrastcolor1-color2)
- [chroma.distance](#chromadistancecolor1-color2-modelab)
- [chroma.deltaE](#chromadeltaecolor1-color2-kl1-kc1-kh1)
- [chroma.limits](#chromalimitsdata-mode-n)

## chroma.valid

You can use `chroma.valid` to try if a color argument can be correctly parsed as color by chroma-luau:

```lua
chroma.valid('red')
chroma.valid('bread')
chroma.valid('#F0000D')
chroma.valid('#FOOOOD')
```

## chroma.contrast(color1, color2)

Computes the WCAG contrast ratio between two colors. A minimum contrast of 4.5:1 [is recommended](http://www.w3.org/TR/WCAG20-TECHS/G18.html) to ensure that text is still readable against a background color.

```lua
-- contrast smaller than 4.5 = too low
chroma.contrast('pink', 'hotpink')
-- contrast greater than 4.5 = high enough
chroma.contrast('pink', 'purple')
```

## chroma.distance(color1, color2, mode='lab')

Computes the [Euclidean distance](https://en.wikipedia.org/wiki/Euclidean_distance#Three_dimensions) between two colors in a given color space (default is `Lab`).

```lua
chroma.distance('#fff', '#ff0', 'rgb')
chroma.distance('#fff', '#f0f', 'rgb')
chroma.distance('#fff', '#ff0')
chroma.distance('#fff', '#f0f')
```

## chroma.deltaE(color1, color2, Kl=1, Kc=1, Kh=1)

Computes [color difference](https://en.wikipedia.org/wiki/Color_difference#CIEDE2000) as developed by the International Commission on Illumination (CIE) in 2000. The implementation is based on the formula from [Bruce Lindbloom](http://www.brucelindbloom.com/index.html?Eqn_DeltaE_CIE2000.html). Resulting values range from 0 (no difference) to 100 (maximum difference), and are a metric for how the human eye percieves color difference. The optional parameters Kl, Kc, and Kh may be used to adjust weightings of lightness, chroma, and hue.

```lua
chroma.deltaE('#ededee', '#ededee')
chroma.deltaE('#ededee', '#edeeed')
chroma.deltaE('#ececee', '#eceeec')
chroma.deltaE('#e9e9ee', '#e9eee9')
chroma.deltaE('#e4e4ee', '#e4eee4')
chroma.deltaE('#e0e0ee', '#e0eee0')
chroma.deltaE('#000000', '#ffffff')
```

## chroma.limits(data, mode, n)

A helper function that computes class breaks for you, based on data. It supports the modes _equidistant_ (e), _quantile_ (q), _logarithmic_ (l), and _k-means_ (k). Let's take a few numbers as sample data.

```lua
local data = {
    2.0, 3.5, 3.6, 3.8, 3.8, 4.1, 4.3, 4.4,
    4.6, 4.9, 5.2, 5.3, 5.4, 5.7, 5.8, 5.9,
    6.2, 6.5, 6.8, 7.2, 8
}
```

**equidistant** breaks are computed by dividing the total range of the data into _n_ groups of equal size.

```lua
chroma.limits(data, 'e', 4)
```

In the **quantile** mode, the input domain is divided by quantile ranges.

```lua
chroma.limits(data, 'q', 4)
```

**logarithmic** breaks are equidistant breaks but on a logarithmic scale.

```lua
chroma.limits(data, 'l', 4)
```

**k-means** break is using the 1-dimensional [k-means clustering](https://en.wikipedia.org/wiki/K-means_clustering) algorithm to find (roughly) _n_ groups of "similar" values. Note that this k-means implementation does not guarantee to find exactly _n_ groups.

```lua
chroma.limits(data, 'k', 4)
```
