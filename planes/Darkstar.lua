local Darkstar = {}

Darkstar.tModifiers = {}
Darkstar.tModifiers["CHYoke"] = {
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

-- build functions for simple toggles
Darkstar.tStateTrackers = {
    battery     = { iValue = 0, sSystem = "ELECTRICAL_Battery_1" },
    beacons     = { iValue = 0, sSystem = {'LIGHTING_BEACON_1','LIGHTING_BEACON_2','LIGHTING_NAV_1'}  },
    landlights  = { iValue = 0, sSystem = "LIGHTING_LANDING_1"  },
    alternator1 = { iValue = 0, sSystem = "ELECTRICAL_Alternator_1"  },
    alternator2 = { iValue = 0, sSystem = "ELECTRICAL_Alternator_2"  },
}
for _,sTrackerName in ipairs({"battery","beacons","landlights","alternator1","alternator2"}) do
    sFnName = "toggle_"..sTrackerName
    Darkstar[sFnName] = function() tManagers["Action"].toggle(Darkstar.tStateTrackers[sTrackerName]) end
end

-- Build functions for APU_sVerb_sState
for _,sVerb in ipairs({"Start","Stop"}) do
    sAPU = "ELECTRICAL_APU_"..sVerb
    for iState,sState in ipairs({"press","release"}) do
        sFnName = "APU_"..sVerb.."_"..sState
        Darkstar[sFnName] = msfs.input_event_executer(sAPU,(iState)%2)
    end
end

-- Build functions for engineX_stateY
for iEngine = 1, 2 do
    sSwitch = "ENGINE_Engine_Switch_" .. iEngine
    for iState = 0, 2 do
        sFnName = "engine"..iEngine.."_state"..iState
        Darkstar[sFnName] = msfs.input_event_executer(sSwitch,iState)
    end
end

function Darkstar.onGeneratorHat(evid,args)
--  mapper.print("Darkstar:onGeneratorHat() args=["..(args or "nil").."]")
    if args < 0 then return end
    iDirection = args / 9000
    if iDirection == 0 then
        msfs.execute_input_event('COMMON_Cover_Generator_1', 1)
        msfs.execute_input_event('COMMON_Cover_Generator_2', 1)
    elseif iDirection == 1 then
        Darkstar.toggle_alternator2()
    elseif iDirection == 2 then
        msfs.execute_input_event('COMMON_Cover_Generator_1', 0)
        msfs.execute_input_event('COMMON_Cover_Generator_2', 0)
    elseif iDirection == 3 then
        Darkstar.toggle_alternator1()
    end
end

function Darkstar.onTrimHat(evid,args)
--  mapper.print("Darkstar:onTrimHat() args=["..(args or "nil").."]")
    iDirection = args / 9000
    if args < 0 then
        msfs.execute_input_event('HANDLING_AILERON_ELEVATOR_Trim', 4)
    elseif iDirection == 0 then
        msfs.execute_input_event('HANDLING_AILERON_ELEVATOR_Trim', 3)
    elseif iDirection == 1 then
        msfs.execute_input_event('HANDLING_AILERON_ELEVATOR_Trim', 1)
    elseif iDirection == 2 then
        msfs.execute_input_event('HANDLING_AILERON_ELEVATOR_Trim', 2)
    elseif iDirection == 3 then
        msfs.execute_input_event('HANDLING_AILERON_ELEVATOR_Trim', 0)
    end
end


function Darkstar.SCRAM_ready(nEventID,tArgs)
    msfs.execute_input_event('ELECTRICAL_Fuel_Cell', 1)
    msfs.execute_input_event('COMMON_Cover_Transition', 0)
end
function Darkstar.SCRAM_unready(nEventID,tArgs)
    msfs.execute_input_event('ENGINE_Transition', 0)
    msfs.execute_input_event('ELECTRICAL_Fuel_Cell', 1)
    msfs.execute_input_event('COMMON_Cover_Transition', 1)
end
Darkstar.SCRAM_on     = msfs.input_event_executer('ENGINE_Transition', 1)
Darkstar.SCRAM_off    = msfs.input_event_executer('ENGINE_Transition', 0)
Darkstar.SPOILERS_off = msfs.input_event_executer('HANDLING_Spoilers', 0)
Darkstar.SPOILERS_on  = msfs.input_event_executer('HANDLING_Spoilers', 1)



function Darkstar.applyControllerActions(tEventActionMap,hAircraft,sController,hController,tEventIDs)
    mapper.print("Darkstar:applyControllerActions() for sController=["..sController.."]")
    if sController == "F710" then
        tEventActionMap[tEventIDs.button7.down] = Darkstar.toggle_battery
        tEventActionMap[tEventIDs.button1.down] = Darkstar.toggle_beacons
        tEventActionMap[tEventIDs.button4.down] = Darkstar.toggle_landlights

        mapper.print("Setting F710 button3 down nEventID=["..tEventIDs.button3.down.."] to APU_Start_press")
        tEventActionMap[tEventIDs.button3.down] = Darkstar.APU_Start_press
        tEventActionMap[tEventIDs.button3.up]   = Darkstar.APU_Start_release
        tEventActionMap[tEventIDs.button2.down] = Darkstar.APU_Stop_press
        tEventActionMap[tEventIDs.button2.up]   = Darkstar.APU_Stop_release

        tEventActionMap[tEventIDs.y.negative]   = Darkstar.engine1_state0
        tEventActionMap[tEventIDs.x.positive]   = Darkstar.engine1_state1
        tEventActionMap[tEventIDs.x.negative]   = Darkstar.engine1_state1
        tEventActionMap[tEventIDs.y.positive]   = Darkstar.engine1_state2

        tEventActionMap[tEventIDs.ry.negative]  = Darkstar.engine2_state0
        tEventActionMap[tEventIDs.rx.positive]  = Darkstar.engine2_state1
        tEventActionMap[tEventIDs.rx.negative]  = Darkstar.engine2_state1
        tEventActionMap[tEventIDs.ry.positive]  = Darkstar.engine2_state2

        tEventActionMap[tEventIDs.pov1.change]  = Darkstar.onGeneratorHat
    elseif sController == "CHYoke" then

        tEventActionMap[tEventIDs.pov1.change]  = Darkstar.onTrimHat

        tEventActionMap[tEventIDs.ry.positive]  = Darkstar.SPOILERS_off
        tEventActionMap[tEventIDs.ry.negative]  = Darkstar.SPOILERS_on
        tEventActionMap[tEventIDs.rx.positive]  = Darkstar.SCRAM_ready
        tEventActionMap[tEventIDs.rx.negative]  = Darkstar.SCRAM_unready
        tEventActionMap[tEventIDs.button7.down] = Darkstar.SCRAM_on
        tEventActionMap[tEventIDs.button8.down] = Darkstar.SCRAM_off

    end
end

return Darkstar