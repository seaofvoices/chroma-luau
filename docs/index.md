# chroma-luau

Here are a couple of things chroma-luau can do for you:

- read colors from a wide range of formats ([see constructors](./constructors.md))
- analyze and manipulate colors ([see color object](./color.md) and [utils](./utils.md))
- convert colors into wide range of formats ([see color object](./color.md))
- linear and bezier interpolation in different color spaces ([see generators](./generators.md))

Here's an example for a simple read / manipulate / output chain:

```lua
chroma('pink'):darken():saturate(2):hex()
```

Aside from that, chroma-luau can also help you **generate nice colors** using various methods, for instance to be [used](https://www.vis4.net/blog/avoid-equidistant-hsv-colors/) in color palette for maps or data visualization.

```lua
chroma.scale({'#fafa6e','#2A4858'})
    .mode('lch')
    .colors(6)
```
