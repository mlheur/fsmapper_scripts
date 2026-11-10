local hController = {}
hController.tTombstone = {
    name = "DualAction",
    type = "dinput",
    identifier = {
        guid = '{17A8F9C0-BD62-11F0-8001-444553540000}',
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
    {name = 'button12', modtype = 'button'},
    --{name = 'x' },
    {name = 'z',        modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    {name = 'rz',       modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    -- Y axis (Left Thumbstick, up & down) controls the global Altimeter through Kohlsman SimVar.
    -- Clicking said thumbstick toggles between STD and BARO altimeter readouts on glass cockpits.
    {name = 'button11', modtype = 'button'},
    {
        name     = 'y',
        modtype  = 'quantized_stick',
        modparam = {
            repeat_interval    = 10,
            repeat_delay       = 100,
            activate_threshold = 40000,
            release_threshold  = 40001,
        }
    },
}


return hController