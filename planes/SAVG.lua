---- Old
-- dev.profiles.SAVG = { name=dev.name, type=dev.type, identifier=dev.identifier, modifiers = {} }
-- dev.map.z.change.SAVG = action_mgr.ENGINE_Throttle[1]
-- dev.map.ry.change.SAVG = action_mgr.PASSENGER_Cabin_Heat[1]
-- dev.map.rx.change.SAVG = action_mgr.ENGINE_Choke[100]

local hAircraft = {}

hAircraft.name = "SAVG"

function hAircraft.applyControllerActions(tEventActionMap,hAircraft,sController,hController,tEventIDs)
    if sController == "CHYoke" then
        tEventActionMap[tEventIDs.z.change] = tManagers["Action"].ENGINE_Throttle[1]
        tEventActionMap[tEventIDs.ry.change] = tManagers["Action"].PASSENGER_Cabin_Heat[1]
        tEventActionMap[tEventIDs.rx.change] = tManagers["Action"].ENGINE_Choke[100]
    end
end

return hAircraft