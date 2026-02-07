local hController = {}

hController.tTombstone = {
    name = "F710",
    type = "dinput",
    identifier = {
        name = 'Controller (Wireless Gamepad F710)',
    }
}

hController.defaultMods = {
    {name = 'button1',  modtype = 'button'},
    {name = 'button2',  modtype = 'button'},
    {name = 'button3',  modtype = 'button'},
    {name = 'button4',  modtype = 'button'},
    {name = 'button5',  modtype = 'button'},
    {name = 'button6',  modtype = 'button'},
    {name = 'button7',  modtype = 'button'},
    {name = 'button8',  modtype = 'button'},
    {name = 'button9',  modtype = 'button'},
    {name = 'button10', modtype = 'button'},
    {name = 'x',        modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    {name = 'y',        modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    {name = 'rx',       modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    {name = 'ry',       modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    {name = 'z',        modtype = 'quantized_stick', modparam = { repeat_mode = false, } }, -- z.negative == L2 analog trigger down; z.positive == R2 analog trigger down
}

return hController