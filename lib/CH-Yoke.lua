local Yoke = {}

Yoke.name = "Yoke"

Yoke.device = mapper.device{
    name = Yoke.name,
    type = 'dinput',
    identifier = {guid = '{1DDD4F20-8387-11ED-8001-444553540000}'},
    modifiers = {
        { name = 'x', modtype = 'button' },
        { name = 'y', modtype = 'button' },
        { name = 'rx', modtype = 'button' },
        { name = 'ry', modtype = 'quantized_stick', modparam = {
            repeat_mode = false,
            activate_threshold = 48000,
            release_threshold  = 48001,
        }},
    }
}

return Yoke