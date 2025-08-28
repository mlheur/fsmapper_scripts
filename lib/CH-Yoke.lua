local Yoke = {}

Yoke.name = "Yoke"

Yoke.device = mapper.device{
    name = Yoke.name,
    type = 'dinput',
    identifier = {guid = '{1DDD4F20-8387-11ED-8001-444553540000}'},
    modifiers = {
        {
            name = 'ry',
            modtype = 'quantized_stick',
            modparam = {
                repeat_mode = false,
                activate_threshold = 48000,
                release_threshold  = 48001,
            }
        },
    }
}

Yoke.map = {}
Yoke.map.ry = {}
Yoke.map.ry.positive = {}
Yoke.map.ry.positive.__event__ = Yoke.device.events.ry.positive
Yoke.map.ry.negative = {}
Yoke.map.ry.negative.__event__ = Yoke.device.events.ry.negative

Yoke.map.ry.positive.Darkstar = msfs.input_event_executer('HANDLING_Spoilers', 0)
Yoke.map.ry.negative.Darkstar = msfs.input_event_executer('HANDLING_Spoilers', 1)

return Yoke