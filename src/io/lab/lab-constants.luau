-- ROBLOX upstream: https://github.com/gka/chroma.js/blob/cd1b3c0926c7a85cbdc3b1453b3a94006de91a92/src/io/lab/lab-constants.js
return {
    -- Corresponds roughly to RGB brighter/darker
    Kn = 18,

    -- D65 standard referent
    Xn = 0.950470,
    Yn = 1,
    Zn = 1.088830,

    t0 = 0.137931034, -- 4 / 29
    t1 = 0.206896552, -- 6 / 29
    t2 = 0.12841855, -- 3 * t1 * t1
    t3 = 0.008856452, -- t1 * t1 * t1
}
