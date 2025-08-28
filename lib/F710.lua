local F710 = {}

F710.name = "F710"

F710.device = mapper.device{
    name = F710.name,
    type = 'dinput',
    identifier = {name = 'Controller (Wireless Gamepad F710)'},
    modifiers = {
        {name = 'button9',  modtype = 'button'},
        {name = 'button10', modtype = 'button'},
        {name = 'x',        modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
        {name = 'y',        modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
        {name = 'rx',       modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
        {name = 'ry',       modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    }
}


F710.map = {}
F710.map.x = {}
F710.map.x.positive = {}
F710.map.x.positive.__event__ = F710.device.events.x.positive
F710.map.x.negative = {}
F710.map.x.negative.__event__ = F710.device.events.x.negative
F710.map.y = {}
F710.map.y.positive = {}
F710.map.y.positive.__event__ = F710.device.events.y.positive
F710.map.y.negative = {}
F710.map.y.negative.__event__ = F710.device.events.y.negative
F710.map.rx = {}
F710.map.rx.positive = {}
F710.map.rx.positive.__event__ = F710.device.events.rx.positive
F710.map.rx.negative = {}
F710.map.rx.negative.__event__ = F710.device.events.rx.negative
F710.map.ry = {}
F710.map.ry.positive = {}
F710.map.ry.positive.__event__ = F710.device.events.ry.positive
F710.map.ry.negative = {}
F710.map.ry.negative.__event__ = F710.device.events.ry.negative
F710.map.button9 = {}
F710.map.button9.down = {}
F710.map.button9.down.__event__ = F710.device.events.button9.down
F710.map.button10 = {}
F710.map.button10.down = {}
F710.map.button10.down.__event__ = F710.device.events.button10.down

F710.map.x.positive.G1000 = "(>H:AS1000_PFD_FMS_Upper_INC)"
F710.map.x.negative.G1000 = "(>H:AS1000_PFD_FMS_Upper_DEC)"
F710.map.y.positive.G1000 = "(>H:AS1000_PFD_FMS_Lower_INC)"
F710.map.y.negative.G1000 = "(>H:AS1000_PFD_FMS_Lower_DEC)"
F710.map.rx.positive.G1000 = "(>H:AS1000_MFD_FMS_Upper_INC)"
F710.map.rx.negative.G1000 = "(>H:AS1000_MFD_FMS_Upper_DEC)"
F710.map.ry.positive.G1000 = "(>H:AS1000_MFD_FMS_Lower_INC)"
F710.map.ry.negative.G1000 = "(>H:AS1000_MFD_FMS_Lower_DEC)"
F710.map.button9.down.G1000 = "(>H:AS1000_PFD_FMS_Upper_PUSH)"
F710.map.button10.down.G1000 = "(>H:AS1000_MFD_FMS_Upper_PUSH)"

F710.map.x.positive.GNS530 = "(>H:AS530_LeftSmallKnob_Right)"
F710.map.x.negative.GNS530 = "(>H:AS530_LeftSmallKnob_Left)"
F710.map.y.positive.GNS530 = "(>H:AS530_LeftLargeKnob_Right)"
F710.map.y.negative.GNS530 = "(>H:AS530_LeftLargeKnob_Left)"
F710.map.rx.positive.GNS530 = "(>H:AS530_RightSmallKnob_Right)"
F710.map.rx.negative.GNS530 = "(>H:AS530_RightSmallKnob_Left)"
F710.map.ry.positive.GNS530 = "(>H:AS530_RightLargeKnob_Right)"
F710.map.ry.negative.GNS530 = "(>H:AS530_RightLargeKnob_Left)"
F710.map.button9.down.GNS530 = "(>H:AS530_LeftSmallKnob_Push)"
F710.map.button10.down.GNS530 = "(>H:AS530_RightSmallKnob_Push)"

F710.map.x.positive.GNS430 = "(>H:AS430_LeftSmallKnob_Right)"
F710.map.x.negative.GNS430 = "(>H:AS430_LeftSmallKnob_Left)"
F710.map.y.positive.GNS430 = "(>H:AS430_LeftLargeKnob_Right)"
F710.map.y.negative.GNS430 = "(>H:AS430_LeftLargeKnob_Left)"
F710.map.rx.positive.GNS430 = "(>H:AS430_RightSmallKnob_Right)"
F710.map.rx.negative.GNS430 = "(>H:AS430_RightSmallKnob_Left)"
F710.map.ry.positive.GNS430 = "(>H:AS430_RightLargeKnob_Right)"
F710.map.ry.negative.GNS430 = "(>H:AS430_RightLargeKnob_Left)"
F710.map.button9.down.GNS430 = "(>H:AS430_LeftSmallKnob_Push)"
F710.map.button10.down.GNS430 = "(>H:AS430_RightSmallKnob_Push)"

F710.map.x.positive.LX9070 = "(>H:AS9070_BottomLeftKnobInc)"
F710.map.x.negative.LX9070 = "(>H:AS9070_BottomLeftKnobDec)"
F710.map.y.positive.LX9070 = "(>H:AS9070_UpperLeftKnobInc)"
F710.map.y.negative.LX9070 = "(>H:AS9070_UpperLeftKnobDec)"
F710.map.rx.positive.LX9070 = "(>H:AS9070_BottomRightKnobInc)"
F710.map.rx.negative.LX9070 = "(>H:AS9070_BottomRightKnobDec)"
F710.map.ry.positive.LX9070 = "(>H:AS9070_UpperRightKnobInc)"
F710.map.ry.negative.LX9070 = "(>H:AS9070_UpperRightKnobDec)"

return F710