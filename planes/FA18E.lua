hAircraft = {}

hAircraft.name = "FA18E"

hAircraft.tModifiers = {}
hAircraft.tModifiers["CHYoke"] = {
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

local nStateNWS = 0
local function onChangeNWS(nEventID,nValue)
    if     nValue >  49500 and nStateNWS <= 0 then
        msfs.execute_input_event('HANDLING_GLimiter', 0)
        mapper.print("Trigger GLimiter")
        nStateNWS = 1
    elseif nValue < -49500 and nStateNWS >= 0 then
        mapper.print("Trigger NWS")
        msfs.execute_input_event('AS04F_Push_NWS', 1)
        nStateNWS = -1
    elseif nValue > -49500 and nValue < 49500 and nStateNWS < 0 then
        mapper.print("Release NWS")
        msfs.execute_input_event('AS04F_Push_NWS', 0)
        nStateNWS = 0
    elseif nValue > -49500 and nValue < 49500 and nStateNWS > 0 then
        nStateNWS = 0
    end
end

function hAircraft.onStarterHat(evid,args)
--  mapper.print("hAircraft:onGeneratorHat() args=["..(args or "nil").."]")
    if args < 0 then return end
    iDirection = args / 9000
    if iDirection == 0 then
        msfs.execute_input_event('ELECTRICAL_APU_Starter', 1)
    elseif iDirection == 1 then
        msfs.execute_input_event('ENGINE_Starter_Ignition_1', 2)
    elseif iDirection == 2 then
        msfs.execute_input_event('ELECTRICAL_APU_Starter', 0)
    elseif iDirection == 3 then
        msfs.execute_input_event('ENGINE_Starter_Ignition_1', 0)
    end
end

local nStateHdgTk = 1.0
function hAircraft.onHdgTk(nEventID,tArgs)
    --mapper.print("hAircraft.onHdgTk tArgs=["..tArgs.."]")
    local bChanged = false
    if nStateHdgTk == 1.0 and tArgs < -49000 then
        bChanged = true
        nStateHdgTk = 0.0
    elseif nStateHdgTk == 1.0 and tArgs > 49000 then
        bChanged = true
        nStateHdgTk = 2.0
    elseif nStateHdgTk ~= 1.0 and tArgs > -40000 and tArgs < 40000 then
        bChanged = true
        nStateHdgTk = 1.0
    end
    if bChanged then
        --mapper.print("bChanged")
        msfs.execute_input_event('AS04F_EFD_Switch_HDG_TK', nStateHdgTk)
    end
end

local nStateLandingLights = 0
function hAircraft.onLandingLights(nEventID,tArgs)
    nStateLandingLights = nStateLandingLights + 1
    nStateLandingLights = nStateLandingLights % 2
    msfs.execute_input_event('LIGHTING_LANDING_1', nStateLandingLights)
end

function hAircraft.applyControllerActions(tEventActionMap,hAircraft,sController,hController,tEventIDs)
    if sController == "CHYoke" then
        tEventActionMap[tEventIDs.ry.negative] = tManagers["Action"].SPOILERS_decrement
        tEventActionMap[tEventIDs.ry.positive] = tManagers["Action"].SPOILERS_increment
        tEventActionMap[tEventIDs.rx.change]   = onChangeNWS
        tEventActionMap[tEventIDs.pov1.change]  = tManagers["Action"].onTrimHat
        tEventActionMap[tEventIDs.button11.down] = msfs.input_event_executer('AS04F_DDI_Push_12_MFD_3', 1)
        tEventActionMap[tEventIDs.button12.down] = msfs.input_event_executer('AS04F_DDI_Push_13_MFD_3', 1)
        tEventActionMap[tEventIDs.button11.up]   = nil
        tEventActionMap[tEventIDs.button12.up]   = nil
    elseif sController == "F710" then
        tEventActionMap[tEventIDs.pov1.change]  = hAircraft.onStarterHat
        tEventActionMap[tEventIDs.button4.down] = hAircraft.onLandingLights
    elseif sController == "DualAction" then
        --mapper.print("F18 setup DualAction x.change handler")
        tEventActionMap[tEventIDs.x.change]  = hAircraft.onHdgTk
    end
end


return hAircraft