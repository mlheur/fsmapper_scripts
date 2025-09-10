local dev = {}

dev.name = "CH-Yoke"
dev.type = "dinput"
dev.identifier = {guid = '{1DDD4F20-8387-11ED-8001-444553540000}'}


dev.presets = {}
dev.presets.E300 = "gaVariProp"
dev.presets.C172 = "gaFixedProp"


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


dev.profiles[0] = { name=dev.name, type=dev.type, identifier=dev.identifier }
dev.profiles[0].modifiers = {}


dev.profiles.gaFixedProp = { name=dev.name, type=dev.type, identifier=dev.identifier }
dev.profiles.gaFixedProp.modifiers = {
    { name = 'rx', modtype = 'raw', },  -- mixture
}
dev.map.rx.change.gaFixedProp = action_mgr.FUEL_Mixture_1


dev.profiles.gaVariProp = { name=dev.name, type=dev.type, identifier=dev.identifier }
dev.profiles.gaVariProp.modifiers = {
    { name = 'ry', modtype = 'raw', },  -- prop lever
    { name = 'rx', modtype = 'raw', },  -- mixture
}
dev.map.ry.change.gaVariProp = action_mgr.ENGINE_Propeller_1
dev.map.rx.change.gaVariProp = action_mgr.FUEL_Mixture_1


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