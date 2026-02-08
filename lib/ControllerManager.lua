local ControllerManager = {}

local tControllerList = {"F710","DualAction","CHYoke"}

local function deepCopy(tInput)
    if type(tInput) ~= "table" then
        return tInput
    end
    local tOut = {}
    for k,v in pairs(tInput or {}) do
        tOut[k] = deepCopy(v)
    end
    return tOut
end

function ControllerManager.onInit()
    ControllerManager.tCtlMgrs = {}
    ControllerManager.tHandles = {}
    ControllerManager.tEventIDs = {}
    for i,sController in ipairs(tControllerList) do
        mapper.print("Loading: controller library for "..sController)
        ControllerManager.tCtlMgrs[sController] = require("controllers/"..sController)
        if ControllerManager.tCtlMgrs[sController].onInit then
            ControllerManager.tCtlMgrs[sController].onInit()
        end
    end
end


function ControllerManager.openControllers(hAircraft)
    for i,sController in ipairs(tControllerList) do
        if ControllerManager.tCtlMgrs[sController].tTombstone then
            -- Close any existing handles to the controller
            if ControllerManager.tHandles[sController] then
                ControllerManager.tHandles[sController]:close()
                mapper.print("Closed open controller handle for "..sController)
            end
            -- Get the tombstone details of the controller
            tMapperDetails = deepCopy(ControllerManager.tCtlMgrs[sController].tTombstone)
            -- Get the default modifiers of the controller
            -- N.B. deepCopy will output an empty table on a nil input, this is good.
            tMapperDetails.modifiers = deepCopy(ControllerManager.tCtlMgrs[sController].defaultMods)
            -- Merge in any aircraft-specific modifiers for this controller
            if hAircraft and hAircraft.tModifiers and hAircraft.tModifiers[sController] then
                mapper.print("Merging custom "..sController.." modifiers for this aircraft")
                for i1,v1 in pairs(hAircraft.tModifiers[sController]) do
                    local bDidReplace = false
                    for i2,v2 in pairs(tMapperDetails.modifiers) do
                        if v1.name == v2.name then
                            bDidReplace = true
                            tMapperDetails.modifiers[i2] = deepCopy(v1)
                            break
                        end
                    end
                    if not bDidReplace then
                        table.insert(tMapperDetails.modifiers,deepCopy(v1))
                    end
                end
            end
            for k,v in pairs(tMapperDetails.modifiers) do
            end
            ControllerManager.tHandles[sController] = mapper.device(tMapperDetails)
            ControllerManager.tEventIDs[sController] = ControllerManager.tHandles[sController].events
            mapper.print("Opened controller handle for "..sController)
        else
            mapper.print("WARNING: controller "..sController.." is missing its tTombstone details")
        end
    end
end


function ControllerManager.updateControllerActions(tEventActionMap,hAircraft)
    for i,sController in ipairs(tControllerList) do
        if ControllerManager.tCtlMgrs[sController] and ControllerManager.tCtlMgrs[sController].applyDefaultActions then
            ControllerManager.tCtlMgrs[sController].applyDefaultActions(tEventActionMap,hAircraft,ControllerManager.tEventIDs[sController])
        end
    end
end

-- applyAvionicsKnobs(tEventActionMap,sCtl,hAvi,tEventIDs)
function ControllerManager.updateAvionicsActions(tEventActionMap,hAircraft,sAvionics)
    if sAvionics == nil then return end
    local bLoadedAvionics,hAvionics = pcall(tryImport,"avionics/"..sAvionics)
    if bLoadedAvionics then
        mapper.print("Found avionics handler for "..sAvionics)
        for i,sController in ipairs(tControllerList) do
            if hAvionics.tKnobSpecs and hAvionics.tKnobSpecs.sDesiredController and hAvionics.tKnobSpecs.sDesiredController == sController and ControllerManager.tCtlMgrs[sController] and ControllerManager.tCtlMgrs[sController].applyAvionicsKnobs then
                ControllerManager.tCtlMgrs[sController].applyAvionicsKnobs(
                    tEventActionMap,
                    hAvionics.tKnobSpecs,
                    ControllerManager.tEventIDs[sController]
                )
            end
        end
    end
end


function ControllerManager.updateAircraftActions(tEventActionMap,hAircraft)
    if hAircraft == nil then return end
    for i,sController in ipairs(tControllerList) do
        if hAircraft.applyControllerActions then
            hAircraft.applyControllerActions(
                    tEventActionMap,
                    hAircraft,
                    sController,
                    ControllerManager.tCtlMgrs[sController],
                    ControllerManager.tEventIDs[sController]
                )
        end
    end
end


function ControllerManager.applyActions(tEventActionMap)
    tAdditionalMappings = {}
    for nEventID,hActionFn in pairs(tEventActionMap) do
        tMapping = {}
        tMapping.event  = nEventID
        tMapping.action = hActionFn
        table.insert(tAdditionalMappings,tMapping)
    end
    mapper.add_secondary_mappings(tAdditionalMappings)
end

return ControllerManager