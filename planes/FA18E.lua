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
hAircraft.tModifiers["DualAction2"] = {
    {
        name = 'x',
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

local nStateLandingAlt1 = 1
local nStateLandingAlt2 = 1
function hAircraft.onElectricHat(evid,args)
--  mapper.print("hAircraft:onElectricHat() args=["..(args or "nil").."]")
    if args < 0 then return end
    iDirection = args / 9000
    if iDirection == 0 then
        msfs.execute_input_event('ELECTRICAL_Battery_1', 1)
    elseif iDirection == 1 then
        nStateLandingAlt2 = nStateLandingAlt2 + 1
        nStateLandingAlt2 = nStateLandingAlt2 % 2
        msfs.execute_input_event('ELECTRICAL_Alternator_2', nStateLandingAlt2)
    elseif iDirection == 2 then
        msfs.execute_input_event('ELECTRICAL_Battery_1', 0)
    elseif iDirection == 3 then
        nStateLandingAlt1 = nStateLandingAlt1 + 1
        nStateLandingAlt1 = nStateLandingAlt1 % 2
        msfs.execute_input_event('ELECTRICAL_Alternator_1', nStateLandingAlt1)
    end
end

local nStateHdgTk = 1.0
function hAircraft.___Old___onHdgTk(nEventID,tArgs)
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
local nSelectedHeading = 0
function adjustHeading(amt)
    nSelectedHeading = nSelectedHeading + amt
    rpnCommand = string.format("%d (>L:XMLVAR_AS04F_HSI_HDG_TK)", nSelectedHeading)
    msfs.mfwasm.execute_rpn(rpnCommand)
end
function incrementHeading()
    adjustHeading(1)
end
function decrementHeading()
    adjustHeading(-1)
end
hAircraft.onHdgTk = filter.branch(
    {condition="exceeded", value=49500, action=incrementHeading},
    {condition="falled", value=-49500, action=decrementHeading}
)


local nStateLandingLights = 0
function hAircraft.onLandingLights(nEventID,tArgs)
    nStateLandingLights = nStateLandingLights + 1
    nStateLandingLights = nStateLandingLights % 2
    msfs.execute_input_event('LIGHTING_LANDING_1', nStateLandingLights)
end

function setAfterburner(newValue)
    msfs.execute_input_event('ENGINE_Throttle_1_Afterburner', newValue)
    msfs.execute_input_event('ENGINE_Throttle_2_Afterburner', newValue)
    mapper.print("setAfterburner()")
end
function setAfterburnerOn()
    setAfterburner(1)
end
function setAfterburnerOff()
    setAfterburner(0)
end

function setEngineStop(newValue)
    msfs.execute_input_event('ENGINE_Throttle_1_STOP', newValue)
    msfs.execute_input_event('ENGINE_Throttle_2_STOP', newValue)
    mapper.print("setEngineStop()")
end
function setEngineStopOn()
    setEngineStop(1)
end
function setEngineStopOff()
    setEngineStop(0)
end






local Item1 = filter.lerp(
    tManagers["Action"].ENGINE_Throttle[2],
    {
        {-50000, -50000},
        {-30000, -50000},
        {50000, 50000}
    }
)
local Item2 = filter.branch(
    {condition="falled", value=-44000, action=setAfterburnerOn},
    {condition="exceeded", value=-39000, action=setAfterburnerOff},
    {condition="falled", value=49000, action=setEngineStopOff},
    {condition="exceeded", value=49500, action=setEngineStopOn}
)
local throttle_fn = filter.duplicator(Item1,Item2)




function hAircraft.applyControllerActions(tEventActionMap,hAircraft,sController,hController,tEventIDs)
    if sController == "CHYoke" then
        tEventActionMap[tEventIDs.z.change]      = throttle_fn
        tEventActionMap[tEventIDs.ry.negative]   = tManagers["Action"].SPOILERS_decrement
        tEventActionMap[tEventIDs.ry.positive]   = tManagers["Action"].SPOILERS_increment
        tEventActionMap[tEventIDs.rx.change]     = onChangeNWS
        tEventActionMap[tEventIDs.pov1.change]   = tManagers["Action"].onTrimHat
        tEventActionMap[tEventIDs.button11.down] = msfs.input_event_executer('AS04F_DDI_Push_12_MFD_3', 1)
        tEventActionMap[tEventIDs.button12.down] = msfs.input_event_executer('AS04F_DDI_Push_13_MFD_3', 1)
        tEventActionMap[tEventIDs.button11.up]   = nil
        tEventActionMap[tEventIDs.button12.up]   = nil
    elseif sController == "F710" then
        tEventActionMap[tEventIDs.button1.up]    = msfs.input_event_executer('AUTOPILOT_Speed_Mode', 1)
    elseif sController == "DualAction2" then
        tEventActionMap[tEventIDs.pov1.change]   = hAircraft.onElectricHat
        tEventActionMap[tEventIDs.x.positive]    = incrementHeading
        tEventActionMap[tEventIDs.x.negative]    = decrementHeading
    elseif sController == "DualAction" then
        tEventActionMap[tEventIDs.button1.down]  = msfs.input_event_executer('LIGHTING_STROBE_1', 2)
        tEventActionMap[tEventIDs.button2.down]  = msfs.input_event_executer('LIGHTING_STROBE_1', 1)
        tEventActionMap[tEventIDs.button3.down]  = msfs.input_event_executer('LIGHTING_STROBE_1', 0)
        tEventActionMap[tEventIDs.button4.down]  = hAircraft.onLandingLights
        tEventActionMap[tEventIDs.pov1.change]   = hAircraft.onStarterHat
    end
end


return hAircraft