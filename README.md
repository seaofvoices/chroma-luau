[![checks](https://github.com/seaofvoices/chroma-luau/actions/workflows/test.yml/badge.svg)](https://github.com/seaofvoices/chroma-luau/actions/workflows/test.yml)
![version](https://img.shields.io/github/package-json/v/seaofvoices/chroma-luau)
[![GitHub top language](https://img.shields.io/github/languages/top/seaofvoices/chroma-luau)](https://github.com/luau-lang/luau)
![license](https://img.shields.io/npm/l/chroma-luau)
![npm](https://img.shields.io/npm/dt/chroma-luau)

# chroma-luau

A library to work with all kinds of color conversions and color scales.

This library is a translation of [chroma.js](https://github.com/gka/chroma.js).

## [Documentation](./docs/index.md)

- [color constructors](./docs/constructors.md)
- [manipulate the color object and convert into different color spaces](./docs/color.md)
- [generate colors and scales](./docs/generators.md)
- [utils](./docs/utils.md)

## Installation

Add `chroma-luau` in your dependencies:

```bash
yarn add chroma-luau
```

Or if you are using `npm`:

```bash
npm install chroma-luau
```

## Releases

Versions of chroma-luau are also pre-built and linked to [GitHub releases](https://github.com/seaofvoices/chroma-luau/releases):

- `chroma.rbxm` is a Roblox model file
- `chroma.lua` is a single-file version of the library (with Luau type annotations removed)

## Other Lua Environments Support

If you would like to use this library on a Lua environment, where it is currently incompatible, open an issue (or comment on an existing one) to request the appropriate modifications.

The library uses [darklua](https://github.com/seaofvoices/darklua) to process its code.

## License

This project is available under the MIT license. See [LICENSE.txt](LICENSE.txt) for details.
