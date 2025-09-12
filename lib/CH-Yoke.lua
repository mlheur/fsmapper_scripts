local dev = {}

dev.name = "CH-Yoke"
dev.type = "dinput"
dev.identifier = {guid = '{1DDD4F20-8387-11ED-8001-444553540000}'}

--$ awk '{for (i=1;i<=NF;i++){if($i=="return"){print $(i+1)}}}' planes.lua | awk -F, '{print $1}' | sort -u | grep -v '^mgr$' | xargs echo
--A20N A320 A5 B350 B748 B78X BE36 BE58 Bell407 C152 C172 C208 C25C C700 Cabri CC19 CP10 Cub DA40 DA62 Darkstar DC3 DGF DHC2 DR40 DV20 E300 FA18E FDCT G21A H4 JN4D MXS Orbis PC6 PIVI PTS2 S22T SAVG Spirit TBM9 VELO VL3 Wright

dev.presets = {}

-- dev.presets.A20N    =
-- dev.presets.A320    =
dev.presets.B350    = "TurboProp2"
-- dev.presets.B748    =
-- dev.presets.B78X    =
dev.presets.BE36    = "gaVariProp"
dev.presets.BE58    = "gaVariProp2"
-- dev.presets.Bell407 =
dev.presets.C152    = "gaFixedProp"
dev.presets.C172    = "gaFixedProp"
dev.presets.C208    = "TurboProp"
-- dev.presets.C25C    =
dev.presets.C700    = "JumboJet"
-- dev.presets.Cabri   =
-- dev.presets.CC19    =
dev.presets.CP10    = "gaFixedProp"
-- dev.presets.Cub     =
-- dev.presets.DA40    = nil; all configured in-game
-- dev.presets.DA62    = nil; all configured in-game
dev.presets.DC3     = "gaVariProp2"
-- dev.presets.DGF     =
-- dev.presets.DHC2    =
-- dev.presets.DR40    =
-- dev.presets.DV20    =
dev.presets.E300    = "gaVariProp"
-- dev.presets.FA18E   =
-- dev.presets.FDCT    =
dev.presets.G21A    = "gaVariProp2"
-- dev.presets.H4      =
-- dev.presets.JN4D    =
-- dev.presets.MXS     =
-- dev.presets.Orbis   =
-- dev.presets.PC6     =
-- dev.presets.PIVI    =
-- dev.presets.PTS2    =
-- dev.presets.S22T    =
-- dev.presets.SAVG    =
-- dev.presets.Spirit  =
-- dev.presets.TBM9    =
-- dev.presets.VELO    =
-- dev.presets.VL3     =
-- dev.presets.Wright  =

dev.profiles = {}

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


dev.profiles[0] = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }


dev.profiles.gaFixedProp = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.rx.change.gaFixedProp = action_mgr.FUEL_Mixture[1]


dev.profiles.gaVariProp = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.ry.change.gaVariProp = action_mgr.ENGINE_Propeller[1]
dev.map.rx.change.gaVariProp = action_mgr.FUEL_Mixture[1]


dev.profiles.gaVariProp2 = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.ry.change.gaVariProp2 = action_mgr.ENGINE_Propeller[2]
dev.map.rx.change.gaVariProp2 = action_mgr.FUEL_Mixture[2]


dev.profiles.TurboProp = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.ry.change.TurboProp = action_mgr.ENGINE_Propeller_feather[1]
dev.map.rx.change.TurboProp = action_mgr.FUEL_Condition[1]


dev.profiles.TurboProp2 = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.ry.change.TurboProp2 = action_mgr.ENGINE_Propeller_feather[2]
dev.map.rx.change.TurboProp2 = action_mgr.FUEL_Condition[2]


dev.profiles.JumboJet = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
dev.map.ry.change.JumboJet = action_mgr.SPOILERS_lever


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
dev.map.rx.positive.A5 = action_mgr.RUDDER_down
dev.map.rx.negative.A5 = action_mgr.RUDDER_up


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
dev.map.ry.positive.Darkstar = action_mgr.SPOILERS_off
dev.map.ry.negative.Darkstar = action_mgr.SPOILERS_on
dev.map.rx.positive.Darkstar = action_mgr.SCRAM_ready
dev.map.rx.negative.Darkstar = action_mgr.SCRAM_unready
dev.map.button7.down.Darkstar = action_mgr.SCRAM_on
dev.map.button8.down.Darkstar = action_mgr.SCRAM_off


return dev