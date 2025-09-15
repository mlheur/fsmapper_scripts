local dev = {}

dev.name = "CH-Yoke"
dev.type = "dinput"
dev.identifier = {guid = '{1DDD4F20-8387-11ED-8001-444553540000}'}

-- X & Y axes are the yoke/stick for roll & pitch
-- Z axis is the barrel-shaped throttle lever
-- RY axis is the squarish crown-shaped prop lever
-- RX axis is the round spikey mixture lever


--$ awk '{for (i=1;i<=NF;i++){if($i=="return"){print $(i+1)}}}' planes.lua | awk -F, '{print $1}' | sort -u | grep -v '^mgr$' | xargs echo
--A20N A320 A5 B350 B748 B78X BE36 BE58 Bell407 C152 C172 C208 C25C C700 Cabri CC19 CP10 Cub DA40 DA62 Darkstar DC3 DGF DHC2 DR40 DV20 E300 FA18E FDCT G21A H4 JN4D MXS Orbis PC6 PIVI PTS2 S22T SAVG Spirit TBM9 VELO VL3 Wright

dev.presets = {}

dev.presets.A20N    = nil -- has a broken throttle complained about in many forums
dev.presets.A320    = "C700"
dev.presets.B350    = "TurboProp2"
dev.presets.B748    = nil -- has unique values from other jumbo jets
dev.presets.B78X    = nil -- has unique values from other jumbo jets
dev.presets.BE36    = "gaVariProp"
dev.presets.BE58    = "gaVariProp2"
-- dev.presets.Bell407 = -- helicopter
dev.presets.C152    = "gaFixedProp"
dev.presets.C172    = "gaFixedProp"
dev.presets.C208    = "TurboProp"
dev.presets.C25C    = nil -- has unique values from other jumbo jets
dev.presets.C700    = nil -- has unique values from other jumbo jets
-- dev.presets.Cabri   = -- helicopter
dev.presets.CC19    = "gaVariProp"
dev.presets.CP10    = "gaFixedProp"
dev.presets.Cub     = nil -- Throttle, Choke
dev.presets.DA40    = "automatic"
dev.presets.DA62    = "automatic2"
dev.presets.DC3     = "gaVariProp2"
-- dev.presets.DGF     = nil -- glider with engine...
dev.presets.DHC2    = "gaVariProp"
dev.presets.DR40    = "gaFixedProp"
dev.presets.DV20    = nil -- prop w/out mixture, carb-heat lever
dev.presets.E300    = "gaVariProp"
dev.presets.FA18E   = nil -- spoilers are unique
dev.presets.FDCT    = nil -- has choke and brakes levers
dev.presets.G21A    = "gaVariProp2"
dev.presets.H4      = nil -- unique engine controls
dev.presets.JN4D    = nil -- mixture action is reversed
-- dev.presets.MXS     = nil -- glider
dev.presets.Orbis   = nil -- not flyable, static display
dev.presets.PC6     = "TurboProp"
dev.presets.PIVI    = nil -- Throttle, Prop, Choke
dev.presets.PTS1    = "gaFixedProp"
dev.presets.PTS2    = "gaVariProp"
dev.presets.S22T    = nil
dev.presets.SAVG    = nil -- Zlin Aviation Savage Cub (little yellow thing)
dev.presets.Spirit  = nil
dev.presets.TBM9    = nil
-- dev.presets.VOLO    = -- drone
dev.presets.VL3     = nil
dev.presets.Wright  = nil

dev.profiles = {}

dev.map = {}

dev.map.z = {}
dev.map.z.change = {}

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


dev.profiles[0] = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }


dev.profiles.gaFixedProp = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.gaFixedProp = action_mgr.ENGINE_Throttle[1]
dev.map.rx.change.gaFixedProp = action_mgr.FUEL_Mixture[1]


dev.profiles.automatic = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.automatic = action_mgr.ENGINE_Throttle[1]


dev.profiles.automatic2 = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.automatic2 = action_mgr.ENGINE_Throttle[2]


dev.profiles.gaVariProp = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.gaVariProp = action_mgr.ENGINE_Throttle[1]
dev.map.ry.change.gaVariProp = action_mgr.ENGINE_Propeller[1]
dev.map.rx.change.gaVariProp = action_mgr.FUEL_Mixture[1]


dev.profiles.gaVariProp2 = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.gaVariProp2 = action_mgr.ENGINE_Throttle[2]
dev.map.ry.change.gaVariProp2 = action_mgr.ENGINE_Propeller[2]
dev.map.rx.change.gaVariProp2 = action_mgr.FUEL_Mixture[2]


dev.profiles.TurboProp = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.TurboProp = action_mgr.ENGINE_Throttle[1]
dev.map.ry.change.TurboProp = action_mgr.ENGINE_Propeller_feather[1]
dev.map.rx.change.TurboProp = action_mgr.FUEL_Condition[1]


dev.profiles.TurboProp2 = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.TurboProp2 = action_mgr.ENGINE_Throttle[2]
dev.map.ry.change.TurboProp2 = action_mgr.ENGINE_Propeller_feather[2]
dev.map.rx.change.TurboProp2 = action_mgr.FUEL_Condition[2]


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
dev.map.z.change.Darkstar = action_mgr.ENGINE_Throttle[2]
dev.map.ry.positive.Darkstar = action_mgr.SPOILERS_off
dev.map.ry.negative.Darkstar = action_mgr.SPOILERS_on
dev.map.rx.positive.Darkstar = action_mgr.SCRAM_ready
dev.map.rx.negative.Darkstar = action_mgr.SCRAM_unready
dev.map.button7.down.Darkstar = action_mgr.SCRAM_on
dev.map.button8.down.Darkstar = action_mgr.SCRAM_off


dev.profiles.DV20 = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.z.change.DV20 = action_mgr.ENGINE_Throttle[1]
dev.map.rx.change.DV20 = action_mgr.DEICE_Engine[1]
dev.map.ry.change.DV20 = action_mgr.ENGINE_Propeller[1]


dev.profiles.FA18E = { name=dev.name, type=dev.type, identifier=dev.identifier }
dev.profiles.FA18E.modifiers = {
    {
        name = 'ry',
        modtype = 'quantized_stick',
        modparam = {
            repeat_mode = true,
            repeat_delay = 100,
            repeat_interval = 100,
            activate_threshold = 49500,
            release_threshold  = 49501,
        }
    },
}
dev.map.z.change.FA18E = action_mgr.ENGINE_Throttle[2]
dev.map.ry.negative.FA18E = action_mgr.SPOILERS_decrement
dev.map.ry.positive.FA18E = action_mgr.SPOILERS_increment


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


return dev