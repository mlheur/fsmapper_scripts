local Autobrake_Value = 0
local Autobrake_Disarm_Value = 0

F710_device = mapper.device{
    name = 'F710',
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

local F710 = F710_device.events

local F710_maps = {}
-- G1000 PFD/MFD
F710_maps["LT_PFD_FMS"] = {
    { event = F710.x.positive,    action = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Upper_INC)")  },
    { event = F710.x.negative,    action = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Upper_DEC)")  },
    { event = F710.y.positive,    action = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Lower_INC)")  },
    { event = F710.y.negative,    action = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Lower_DEC)")  },
    { event = F710.button9.down,  action = msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FMS_Upper_PUSH)") },
}
F710_maps["RT_MFD_FMS"] = {
    { event = F710.rx.positive,   action = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Upper_INC)")  },
    { event = F710.rx.negative,   action = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Upper_DEC)")  },
    { event = F710.ry.positive,   action = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Lower_INC)")  },
    { event = F710.ry.negative,   action = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Lower_DEC)")  },
    { event = F710.button10.down, action = msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FMS_Upper_PUSH)") },
}
-- GNS 530 Left & Right knobs
F710_maps["LT_AS530_CV"] = {
    { event = F710.x.positive,    action = msfs.mfwasm.rpn_executer("(>H:AS530_LeftSmallKnob_Right)") },
    { event = F710.x.negative,    action = msfs.mfwasm.rpn_executer("(>H:AS530_LeftSmallKnob_Left)")  },
    { event = F710.y.positive,    action = msfs.mfwasm.rpn_executer("(>H:AS530_LeftLargeKnob_Right)") },
    { event = F710.y.negative,    action = msfs.mfwasm.rpn_executer("(>H:AS530_LeftLargeKnob_Left)")  },
    { event = F710.button9.down,  action = msfs.mfwasm.rpn_executer("(>H:AS530_LeftSmallKnob_Push)")  },
}
F710_maps["RT_AS530_GPS"] = {
    { event = F710.rx.positive,   action = msfs.mfwasm.rpn_executer("(>H:AS530_RightSmallKnob_Right)") },
    { event = F710.rx.negative,   action = msfs.mfwasm.rpn_executer("(>H:AS530_RightSmallKnob_Left)") },
    { event = F710.ry.positive,   action = msfs.mfwasm.rpn_executer("(>H:AS530_RightLargeKnob_Right)") },
    { event = F710.ry.negative,   action = msfs.mfwasm.rpn_executer("(>H:AS530_RightLargeKnob_Left)") },
    { event = F710.button10.down, action = msfs.mfwasm.rpn_executer("(>H:AS530_RightSmallKnob_Push)")  },
}
-- GNS 430 Left & Right knobs
F710_maps["LT_AS430_CV"] = {
    { event = F710.x.positive,    action = msfs.mfwasm.rpn_executer("(>H:AS430_LeftSmallKnob_Right)") },
    { event = F710.x.negative,    action = msfs.mfwasm.rpn_executer("(>H:AS430_LeftSmallKnob_Left)")  },
    { event = F710.y.positive,    action = msfs.mfwasm.rpn_executer("(>H:AS430_LeftLargeKnob_Right)") },
    { event = F710.y.negative,    action = msfs.mfwasm.rpn_executer("(>H:AS430_LeftLargeKnob_Left)")  },
    { event = F710.button9.down,  action = msfs.mfwasm.rpn_executer("(>H:AS430_LeftSmallKnob_Push)")  },
}
F710_maps["RT_AS430_GPS"] = {
    { event = F710.rx.positive,   action = msfs.mfwasm.rpn_executer("(>H:AS430_RightSmallKnob_Right)") },
    { event = F710.rx.negative,   action = msfs.mfwasm.rpn_executer("(>H:AS430_RightSmallKnob_Left)") },
    { event = F710.ry.positive,   action = msfs.mfwasm.rpn_executer("(>H:AS430_RightLargeKnob_Right)") },
    { event = F710.ry.negative,   action = msfs.mfwasm.rpn_executer("(>H:AS430_RightLargeKnob_Left)") },
    { event = F710.button10.down, action = msfs.mfwasm.rpn_executer("(>H:AS430_RightSmallKnob_Push)")  },
}
-- MFD 9070 four knobs
F710_maps["LT_AS9070_Left"] = {
    { event = F710.x.positive,    action = msfs.mfwasm.rpn_executer("(>H:AS9070_BottomLeftKnobInc)") },
    { event = F710.x.negative,    action = msfs.mfwasm.rpn_executer("(>H:AS9070_BottomLeftKnobDec)")  },
    { event = F710.y.positive,    action = msfs.mfwasm.rpn_executer("(>H:AS9070_UpperLeftKnobInc)") },
    { event = F710.y.negative,    action = msfs.mfwasm.rpn_executer("(>H:AS9070_UpperLeftKnobDec)")  },
}
F710_maps["RT_AS9070_Right"] = {
    { event = F710.rx.positive,   action = msfs.mfwasm.rpn_executer("(>H:AS9070_BottomRightKnobInc)") },
    { event = F710.rx.negative,   action = msfs.mfwasm.rpn_executer("(>H:AS9070_BottomRightKnobDec)") },
    { event = F710.ry.positive,   action = msfs.mfwasm.rpn_executer("(>H:AS9070_UpperRightKnobInc)") },
    { event = F710.ry.negative,   action = msfs.mfwasm.rpn_executer("(>H:AS9070_UpperRightKnobDec)") },
}

function GetThumbs(aircraft)
    if aircraft == nil then return end

    -- Need to do some string mangling first to generalize the aircraft name

    local first_space = string.find(aircraft," ")
    if first_space == nil then return end

    local first_word = string.sub(aircraft,1,first_space-1)
    local first_two_words = aircraft
    local second_space = string.find(aircraft," ",first_space+1)
    if second_space ~= nil then first_two_words = string.sub(aircraft,1,second_space-1) end

    -- From the generalized name, determine what the sticks are used for

    if first_two_words == "Cessna Skyhawk" then
        if string.find(aircraft,"G1000") == nil then
            return "LT_AS530_CV","RT_AS530_GPS"
        end
        return "LT_PFD_FMS","RT_MFD_FMS"
    end

    if first_two_words == "Pilatus PC-6" then
        if string.find(aircraft,"G950") == nil then
            return "LT_AS530_CV","RT_AS530_GPS"
        end
        return "LT_PFD_FMS","RT_MFD_FMS"
    end

    -- G1000
    if first_two_words == "Asobo Baron"           then return "LT_PFD_FMS","RT_MFD_FMS" end
    if first_two_words == "Baron G58"             then return "LT_PFD_FMS","RT_MFD_FMS" end
    if first_two_words == "Bonanza G36"           then return "LT_PFD_FMS","RT_MFD_FMS" end
    if first_two_words == "Cessna 208B"           then return "LT_PFD_FMS","RT_MFD_FMS" end
    if first_two_words == "Cessna Grand"          then return "LT_PFD_FMS","RT_MFD_FMS" end
    if first_word      == "DA40-NG"               then return "LT_PFD_FMS","RT_MFD_FMS" end
    if first_two_words == "DA 40"                 then return "LT_PFD_FMS","RT_MFD_FMS" end
    if first_word      == "DA62"                  then return "LT_PFD_FMS","RT_MFD_FMS" end
    if first_two_words == "DA 62"                 then return "LT_PFD_FMS","RT_MFD_FMS" end
    if first_word      == "SR22T"                 then return "LT_PFD_FMS","RT_MFD_FMS" end
    if first_two_words == "SR 22"                 then return "LT_PFD_FMS","RT_MFD_FMS" end
    -- GNS 530
    if first_two_words == "Bell 407"              then return "LT_AS530_CV","RT_AS530_GPS" end
    if first_two_words == "Blackbird Simulations" then return "LT_AS530_CV","RT_AS530_GPS" end -- DHC-2, Beaver
    if first_two_words == "Hercules H-4"          then return "LT_AS530_CV","RT_AS530_GPS" end
    -- GNS 430
    if first_two_words == "Murdy Cap"             then return "LT_AS430_CV","RT_AS430_GPS" end
    if first_two_words == "DA40 TDI"              then return "LT_AS430_CV","RT_AS430_GPS" end
    if first_word      == "DV20"                  then return "LT_AS430_CV","RT_AS430_GPS" end
    if first_two_words == "DV 20"                 then return "LT_AS430_CV","RT_AS430_GPS" end
    -- MFD 9070
    if first_two_words == "Asobo DG1001E"         then return "LT_AS9070_Left","RT_AS9070_Right" end

    -- G3X with GNS 430
        -- Pipistrel
        -- Extra 330

    -- Return Nil:
        -- Airbus A320; A320neo
        -- Boeing 787-10; B787
        -- C152
        -- Cessna CJ4 Citation
        -- Darkstar
        -- DR400 Robin Cadet
        -- F18
        -- FlightDesignCT; Flight Design
        -- Icon A5
        -- Beechcraft King
        -- Cessna Longitude
        -- Asobo LS8 (Glider)
        -- Asobot NXCub
        -- Pitts
        -- Asobo Savage; Savage
        -- Savage Shock
        -- TBM 930
        -- VL3
        -- Asobo XCub; XCub
        -- Douglas DC-3
        -- Grumman Goose
        -- Curtiss JN-4D
        -- Spirit Of
        -- Velocity
    
end

local RemapAircraft = function (evid,args)
    LT,RT = GetThumbs(args.aircraft)
    mapper.set_secondary_mappings {}
    if LT ~= nil then
        mapper.add_secondary_mappings(F710_maps[LT])
    end
    if RT ~= nil then
        mapper.add_secondary_mappings(F710_maps[RT])
    end
end

mapper.set_primary_mappings{
    { event=mapper.events.change_aircraft,    action = RemapAircraft           },
}