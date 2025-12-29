local Darkstar = {}

Darkstar.tStateTrackers = {
    battery     = { iValue = 0, sSystem = "ELECTRICAL_Battery_1" },
    beacons     = { iValue = 0, sSystem = {'LIGHTING_BEACON_1','LIGHTING_BEACON_2','LIGHTING_NAV_1'}  },
    landlights  = { iValue = 0, sSystem = "LIGHTING_LANDING_1"  },
    alternator1 = { iValue = 0, sSystem = "ELECTRICAL_Alternator_1"  },
    alternator2 = { iValue = 0, sSystem = "ELECTRICAL_Alternator_2"  },
}

-- build functions for simple toggles
for _,sTrackerName in ipairs({"battery","beacons","landlights","alternator1","alternator2"}) do
    sFnName = "toggle_"..sTrackerName
    Darkstar[sFnName] = function() action_mgr.toggle(Darkstar.tStateTrackers[sTrackerName]) end
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
for X = 1, 2 do
    sSwitch = "ENGINE_Engine_Switch_" .. X
    for Y = 0, 2 do
        sFnName = "engine"..X.."_state"..Y
        Darkstar[sFnName] = msfs.input_event_executer(sSwitch,Y)
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

function Darkstar.add_mappings(F710,Yoke)
    local tActionEventMap = {
        toggle_battery    = F710.device.events.button7.down,
        toggle_beacons    = F710.device.events.button1.down,
        toggle_landlights = F710.device.events.button4.down,
        APU_Start_press   = F710.device.events.button3.down,
        APU_Start_release = F710.device.events.button3.up,
        APU_Stop_press    = F710.device.events.button2.down,
        APU_Stop_release  = F710.device.events.button2.up,
        engine1_state0    = F710.device.events.y.negative,
        engine1_state1    = F710.device.events.x.negative,
        engine1_state2    = F710.device.events.y.positive,
        engine2_state0    = F710.device.events.ry.negative,
        engine2_state1    = F710.device.events.rx.positive,
        engine2_state2    = F710.device.events.ry.positive,
        onGeneratorHat    = F710.device.events.pov1.change,
    }
    local lMappings = {}
    for callback,eventid in pairs(tActionEventMap) do
        local fn = 
        mapper.print("Darkstar:add_mappings() callback=["..(callback or "nil").."] eventid=["..(eventid or "nil").."]")
        table.insert(lMappings,{event=eventid,action=Darkstar[callback]})
    end
    mapper.add_secondary_mappings(lMappings)
end

return Darkstar