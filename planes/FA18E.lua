hAircraft = {}

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
    if     nValue >  45000 and nStateNWS == 0 then
        msfs.execute_input_event('HANDLING_GLimiter', 0)
        mapper.print("Trigger GLimiter")
        nStateNWS = 1
    elseif nValue < -45000 and nStateNWS == 0 then
        mapper.print("Trigger NWS")
        msfs.execute_input_event('AS04F_Push_NWS', 1)
        nStateNWS = -1
    elseif nValue > -45000 and nValue < 45000 and nStateNWS ~= 0 then
        mapper.print("Release NWS")
        msfs.execute_input_event('AS04F_Push_NWS', 0)
        nStateNWS = 0
    end
end

function hAircraft.applyControllerActions(tEventActionMap,hAircraft,sController,hController,tEventIDs)
    if sController == "CHYoke" then
        tEventActionMap[tEventIDs.ry.negative] = tManagers["Action"].SPOILERS_decrement
        tEventActionMap[tEventIDs.ry.positive] = tManagers["Action"].SPOILERS_increment
        tEventActionMap[tEventIDs.rx.change]   = onChangeNWS
    end
end

return hAircraft