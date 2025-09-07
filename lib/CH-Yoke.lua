local dev = {}

dev.name = "CH-Yoke"
dev.type = "dinput"
dev.identifier = {guid = '{1DDD4F20-8387-11ED-8001-444553540000}'}
dev.profiles = {}

dev.profiles[0] = { name=dev.name, type=dev.type, identifier=dev.identifier }
dev.profiles[0].modifiers = {}

dev.profiles.Darkstar = { name=dev.name, type=dev.type, identifier=dev.identifier }
dev.profiles.Darkstar.modifiers = {
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

dev.profiles.E300 = { name=dev.name, type=dev.type, identifier=dev.identifier }
dev.profiles.E300.modifiers = {
    { name = "button7", modtype = 'button' },
    { name = "button8", modtype = 'button' },
    { name = 'ry', modtype = 'raw', },
    { name = 'rx', modtype = 'raw', },
}

dev.map = {}
dev.map.rx = {}
dev.map.rx.positive = {}
dev.map.rx.negative = {}
dev.map.rx.change = {}

dev.map.ry = {}
dev.map.ry.positive = {}
dev.map.ry.negative = {}
dev.map.ry.change = {}

dev.map.button7 = {}
dev.map.button7.down = {}

dev.map.button8 = {}
dev.map.button8.down = {}

local function inverse_mixmax_percent(value)
    return(( -50000 + value ) / -100000)
end

dev.map.ry.change.E300 = function(evid,args)
    msfs.execute_input_event('ENGINE_Propeller_1',inverse_mixmax_percent(args))
end

dev.map.rx.change.E300 = function(evid,args)
    msfs.execute_input_event('FUEL_Mixture_1',inverse_mixmax_percent(args))
end

dev.map.ry.positive.Darkstar = msfs.input_event_executer('HANDLING_Spoilers', 0)
dev.map.ry.negative.Darkstar = msfs.input_event_executer('HANDLING_Spoilers', 1)

dev.map.rx.positive.Darkstar = function(evid,args)
    msfs.execute_input_event('ELECTRICAL_Fuel_Cell', 1)
    msfs.execute_input_event('COMMON_Cover_Transition', 0)
end

dev.map.rx.negative.Darkstar = function(evid,args)
    msfs.execute_input_event('ELECTRICAL_Fuel_Cell', 1)
    msfs.execute_input_event('COMMON_Cover_Transition', 1)
end

dev.map.button7.down.Darkstar = msfs.input_event_executer('ENGINE_Transition', 1)
dev.map.button8.down.Darkstar = msfs.input_event_executer('ENGINE_Transition', 0)

return dev