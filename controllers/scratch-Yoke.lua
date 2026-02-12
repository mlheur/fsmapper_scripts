

-- vvvvvvvvvvvvvvvvv Old Code vvvvvvvvvvvvvvvv


dev.profiles.A5 = { name=dev.name, type=dev.type, identifier=dev.identifier }
dev.profiles.A5.modifiers = {
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
dev.map.z.change.A5 = action_mgr.ENGINE_Throttle[1]
dev.map.rx.positive.A5 = action_mgr.RUDDER_down
dev.map.rx.negative.A5 = action_mgr.RUDDER_up


dev.profiles.B407 = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.B407 = action_mgr.ENGINE_Collective_Axis
dev.map.ry.change.B407 = action_mgr.THROTTLE_CollectiveGrip


dev.profiles.B748 = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.B748 = action_mgr.ENGINE_Throttle[4]
dev.map.rx.change.B748 = action_mgr.ENGINE_Throttle_Reverser[4]
dev.map.ry.change.B748 = action_mgr.SPOILERS_lever


dev.profiles.B78X = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.B78X = action_mgr.ENGINE_Throttle[2]
dev.map.rx.change.B78X = action_mgr.ENGINE_Throttle_Reverser[2]
dev.map.ry.change.B78X = action_mgr.SPOILERS_lever


dev.profiles.C25C = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.C25C = action_mgr.ENGINE_Throttle[2]
dev.map.ry.change.C25C = action_mgr.SPOILERS_lever_16k


dev.profiles.C700 = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.C700 = action_mgr.ENGINE_Throttle[2]
dev.map.rx.change.C700 = action_mgr.ENGINE_Throttle_Reducer[2]
dev.map.ry.change.C700 = action_mgr.SPOILERS_lever_16k


dev.profiles.Cabri = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.Cabri = action_mgr.ENGINE_Collective_Lever
dev.map.ry.change.Cabri = action_mgr.ENGINE_Propeller[1]
dev.map.rx.change.Cabri = action_mgr.FUEL_Mixture[1]


dev.profiles.Cub = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.profiles.Cub.modifiers = {
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
dev.map.z.change.Cub = action_mgr.ENGINE_Throttle[1]
dev.map.rx.positive.Cub = action_mgr.ENGINE_Choke_on
dev.map.rx.negative.Cub = action_mgr.ENGINE_Choke_off


dev.profiles.DV20 = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.DV20 = action_mgr.ENGINE_Throttle[1]
dev.map.rx.change.DV20 = action_mgr.DEICE_Engine[1]
dev.map.ry.change.DV20 = action_mgr.ENGINE_Propeller[1]


dev.profiles.FDCT = { name=dev.name, type=dev.type, identifier=dev.identifier }
dev.profiles.FDCT.modifiers = {
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
dev.map.z.change.FDCT = action_mgr.ENGINE_Throttle[1]
dev.map.ry.positive.FDCT = action_mgr.ENGINE_Choke_on
dev.map.ry.negative.FDCT = action_mgr.ENGINE_Choke_off
dev.map.rx.change.FDCT = action_mgr.LANDING_GEAR_Brake_lever


dev.profiles.H4 = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.H4 = action_mgr.ENGINE_Throttle_H4


dev.profiles.JN4D = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.JN4D = action_mgr.ENGINE_Throttle[1]
dev.map.rx.change.JN4D = action_mgr.FUEL_Mixture_inverted[1]


dev.profiles.PIVI = { name=dev.name, type=dev.type, identifier=dev.identifier }
dev.profiles.PIVI.modifiers = {
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
dev.map.z.change.PIVI = action_mgr.ENGINE_Throttle[1]
dev.map.ry.change.PIVI = action_mgr.ENGINE_Propeller[1]
dev.map.rx.positive.PIVI = action_mgr.ENGINE_Choke_on
dev.map.rx.negative.PIVI = action_mgr.ENGINE_Choke_off


dev.profiles.S22T = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.S22T = action_mgr.ENGINE_Throttle[1]
dev.map.rx.change.S22T = action_mgr.FUEL_Mixture[0]


dev.profiles.SAVG = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.SAVG = action_mgr.ENGINE_Throttle[1]
dev.map.ry.change.SAVG = action_mgr.PASSENGER_Cabin_Heat[1]
dev.map.rx.change.SAVG = action_mgr.ENGINE_Choke[100]


dev.profiles.Spirit = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.Spirit = action_mgr.ENGINE_Throttle[1]
dev.map.ry.change.Spirit = action_mgr.DEICE_Engine_inverted[1]
dev.map.rx.change.Spirit = action_mgr.FUEL_Mixture[1]


dev.profiles.TBM9 = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.TBM9 = function(evid,args)
    pct = 1-(((50000+args)/100000)/1.15)
    msfs.execute_input_event("ENGINE_Throttle",pct)
    msfs.execute_input_event("ENGINE_Throttle_Feathering",0.0)
end
dev.map.ry.change.TBM9 = function(evid,args)
    if args >= -50000 and args < -20000 then
        msfs.execute_input_event("ENGINE_Throttle",1.0)
    elseif args >= -20000 and args < 20000 then
        msfs.execute_input_event("ENGINE_Throttle",0.5)
    elseif args >= 20000 and args <= 50000 then
        msfs.execute_input_event("ENGINE_Throttle",0.0)
    end
    msfs.execute_input_event("ENGINE_Throttle_Feathering",1.0)
end
dev.map.rx.change.TBM9 = function(evid,args)
    pct = (1-(1/1.15))*((-50000+args)/-100000)
    if pct < 0.01 then pct = 0.01 end
    msfs.execute_input_event("ENGINE_Throttle",pct)
    msfs.execute_input_event("ENGINE_Throttle_Feathering",0.0)
end


dev.profiles.VL3 = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.VL3 = action_mgr.ENGINE_Throttle[1]
dev.map.rx.change.VL3 = action_mgr.ENGINE_Choke[100]
