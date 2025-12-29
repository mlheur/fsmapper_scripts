local dev = {}

dev.name = "F710"
dev.type = "dinput"
dev.identifier = {name = 'Controller (Wireless Gamepad F710)'}

dev.profiles = {}
dev.profiles[0] = { name=dev.name, type=dev.type, identifier=dev.identifier }
dev.profiles[0].modifiers = {
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
    {name = 'x',        modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    {name = 'y',        modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    {name = 'rx',       modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    {name = 'ry',       modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
}

dev.map = {}
dev.map.x = {}
dev.map.x.positive = {}
dev.map.x.negative = {}
dev.map.y = {}
dev.map.y.positive = {}
dev.map.y.negative = {}
dev.map.rx = {}
dev.map.rx.positive = {}
dev.map.rx.negative = {}
dev.map.ry = {}
dev.map.ry.positive = {}
dev.map.ry.negative = {}
dev.map.button9 = {}
dev.map.button9.down = {}
dev.map.button10 = {}
dev.map.button10.down = {}

dev.map.x.positive.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Upper_INC)")
dev.map.x.negative.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Upper_DEC)")
dev.map.y.positive.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Lower_INC)")
dev.map.y.negative.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Lower_DEC)")
dev.map.rx.positive.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Upper_INC)")
dev.map.rx.negative.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Upper_DEC)")
dev.map.ry.positive.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Lower_INC)")
dev.map.ry.negative.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Lower_DEC)")
dev.map.button9.down.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Upper_PUSH)")
dev.map.button10.down.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Upper_PUSH)")

dev.map.x.positive.GNS530 = msfs.mfwasm.rpn_executer("(>H:AS530_LeftSmallKnob_Right)")
dev.map.x.negative.GNS530 = msfs.mfwasm.rpn_executer("(>H:AS530_LeftSmallKnob_Left)")
dev.map.y.positive.GNS530 = msfs.mfwasm.rpn_executer("(>H:AS530_LeftLargeKnob_Right)")
dev.map.y.negative.GNS530 = msfs.mfwasm.rpn_executer("(>H:AS530_LeftLargeKnob_Left)")
dev.map.rx.positive.GNS530 = msfs.mfwasm.rpn_executer("(>H:AS530_RightSmallKnob_Right)")
dev.map.rx.negative.GNS530 = msfs.mfwasm.rpn_executer("(>H:AS530_RightSmallKnob_Left)")
dev.map.ry.positive.GNS530 = msfs.mfwasm.rpn_executer("(>H:AS530_RightLargeKnob_Right)")
dev.map.ry.negative.GNS530 = msfs.mfwasm.rpn_executer("(>H:AS530_RightLargeKnob_Left)")
dev.map.button9.down.GNS530 = msfs.mfwasm.rpn_executer("(>H:AS530_LeftSmallKnob_Push)")
dev.map.button10.down.GNS530 = msfs.mfwasm.rpn_executer("(>H:AS530_RightSmallKnob_Push)")

dev.map.x.positive.GNS430 = msfs.mfwasm.rpn_executer("(>H:AS430_LeftSmallKnob_Right)")
dev.map.x.negative.GNS430 = msfs.mfwasm.rpn_executer("(>H:AS430_LeftSmallKnob_Left)")
dev.map.y.positive.GNS430 = msfs.mfwasm.rpn_executer("(>H:AS430_LeftLargeKnob_Right)")
dev.map.y.negative.GNS430 = msfs.mfwasm.rpn_executer("(>H:AS430_LeftLargeKnob_Left)")
dev.map.rx.positive.GNS430 = msfs.mfwasm.rpn_executer("(>H:AS430_RightSmallKnob_Right)")
dev.map.rx.negative.GNS430 = msfs.mfwasm.rpn_executer("(>H:AS430_RightSmallKnob_Left)")
dev.map.ry.positive.GNS430 = msfs.mfwasm.rpn_executer("(>H:AS430_RightLargeKnob_Right)")
dev.map.ry.negative.GNS430 = msfs.mfwasm.rpn_executer("(>H:AS430_RightLargeKnob_Left)")
dev.map.button9.down.GNS430 = msfs.mfwasm.rpn_executer("(>H:AS430_LeftSmallKnob_Push)")
dev.map.button10.down.GNS430 = msfs.mfwasm.rpn_executer("(>H:AS430_RightSmallKnob_Push)")

dev.map.x.positive.LX9070 = msfs.mfwasm.rpn_executer("(>H:AS9070_BottomLeftKnobInc)")
dev.map.x.negative.LX9070 = msfs.mfwasm.rpn_executer("(>H:AS9070_BottomLeftKnobDec)")
dev.map.y.positive.LX9070 = msfs.mfwasm.rpn_executer("(>H:AS9070_UpperLeftKnobInc)")
dev.map.y.negative.LX9070 = msfs.mfwasm.rpn_executer("(>H:AS9070_UpperLeftKnobDec)")
dev.map.rx.positive.LX9070 = msfs.mfwasm.rpn_executer("(>H:AS9070_BottomRightKnobInc)")
dev.map.rx.negative.LX9070 = msfs.mfwasm.rpn_executer("(>H:AS9070_BottomRightKnobDec)")
dev.map.ry.positive.LX9070 = msfs.mfwasm.rpn_executer("(>H:AS9070_UpperRightKnobInc)")
dev.map.ry.negative.LX9070 = msfs.mfwasm.rpn_executer("(>H:AS9070_UpperRightKnobDec)")

return dev