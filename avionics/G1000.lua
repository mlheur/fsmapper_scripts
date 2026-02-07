
F710.map.x.positive.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Upper_INC)")
F710.map.x.negative.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Upper_DEC)")
F710.map.y.positive.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Lower_INC)")
F710.map.y.negative.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Lower_DEC)")
F710.map.rx.positive.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Upper_INC)")
F710.map.rx.negative.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Upper_DEC)")
F710.map.ry.positive.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Lower_INC)")
F710.map.ry.negative.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Lower_DEC)")
F710.map.button9.down.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Upper_PUSH)")
F710.map.button10.down.G1000 = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Upper_PUSH)")

hAvionics = {}

function hAvionics.updateMappings(hController)
    
end

return hAvionics