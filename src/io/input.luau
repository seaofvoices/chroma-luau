export type Format = {
    -- cmyk
    cmyk: (...any) -> { number },
    -- css
    css: (css: string) -> { number }?,
    -- gl
    gl: (...any) -> { number },
    -- hcg
    hcg: (...any) -> { number },

    -- hex
    hex: (string) -> { number },
    -- hsi
    hsi: (...any) -> { number },
    -- hsl
    hsl: (...any) -> { number },
    -- hsv
    hsv: (...any) -> { number },

    -- lab
    lab: (...any) -> { number },
    -- lch
    lch: (...any) -> { number },
    hcl: (...any) -> { number },
    -- named
    named: (...any) -> { number },
    -- num
    num: (...any) -> { number },
    -- oklab
    oklab: (...any) -> { number },
    -- oklch
    oklch: (...any) -> { number },
    -- rgb
    rgb: (...any) -> { number },
    -- temp
    temperature: (number) -> { number },
    kelvin: (number) -> { number },
    temp: (number) -> { number },
    -- roblox
    roblox: (Color3) -> { number },
}

export type AutoDetect = { p: number, test: (...any) -> string? }

return {
    sorted = false,
    format = {} :: Format,
    autodetect = {} :: { AutoDetect },
}
