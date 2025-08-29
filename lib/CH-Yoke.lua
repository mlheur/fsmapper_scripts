local Yoke = {}

Yoke.name = "Yoke"

Yoke.device = mapper.device{
    name = Yoke.name,
    type = 'dinput',
    identifier = {guid = '{1DDD4F20-8387-11ED-8001-444553540000}'},
    modifiers = {
        { name = "button7", modtype = 'button' },
        { name = "button8", modtype = 'button' },
        {
            name = 'ry',
            modtype = 'quantized_stick',
            modparam = {
                repeat_mode = false,
                activate_threshold = 48000,
                release_threshold  = 48001,
            }
        },
        {
            name = 'rx',
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
Yoke.map.rx = {}
Yoke.map.rx.positive = {}
Yoke.map.rx.negative = {}

Yoke.map.ry = {}
Yoke.map.ry.positive = {}
Yoke.map.ry.negative = {}

Yoke.map.button7 = {}
Yoke.map.button7.down = {}

Yoke.map.button8 = {}
Yoke.map.button8.down = {}

Yoke.map.ry.positive.Darkstar = msfs.input_event_executer('HANDLING_Spoilers', 0)
Yoke.map.ry.negative.Darkstar = msfs.input_event_executer('HANDLING_Spoilers', 1)

Yoke.map.rx.positive.Darkstar = function(evid,args)
    msfs.execute_input_event('ELECTRICAL_Fuel_Cell', 1)
    msfs.execute_input_event('COMMON_Cover_Transition', 0)
end

Yoke.map.rx.negative.Darkstar = function(evid,args)
    msfs.execute_input_event('ELECTRICAL_Fuel_Cell', 1)
    msfs.execute_input_event('COMMON_Cover_Transition', 1)
end

Yoke.map.button7.down.Darkstar = msfs.input_event_executer('ENGINE_Transition', 1)
Yoke.map.button8.down.Darkstar = msfs.input_event_executer('ENGINE_Transition', 0)

return Yoke