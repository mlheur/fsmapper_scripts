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

local function mergeMods(tBase,tOverride)
    local tOut = {}
    for i,tMod in pairs(tBase) do
        bOveridden = false
        for j,tOver in pairs(tOverride) do
            if tOver.name == tMod.name then
                mapper.print()
                bOveridden = true
                tOut[i] = deepCopy(tOver)
            end
        end
        if not bOveridden then
            tOut[i] = deepCopy(tMod)
        end
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
            tMapperDetails = deepCopy(ControllerManager.tCtlMgrs[sController].tTombstone)
            -- N.B. deepCopy will output an empty table on a nil input, this is good.
            tMapperDetails.modifiers = deepCopy(ControllerManager.tCtlMgrs[sController].defaultMods)
            if hAircraft and hAircraft.tModifiers and hAircraft.tModifiers[sController] then
                mapper.print("Merging custom controller modifiers for this aircraft")
                tMapperDetails.modifiers = mergeMods(tMapperDetails.modifiers,hAircraft.tModifiers[sController])
            end
            if ControllerManager.tHandles[sController] then
                ControllerManager.tHandles[sController]:close()
                mapper.print("Closed open controller handle for "..sController)
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


function ControllerManager.updateAvionicsActions(tEventActionMap,sAvionics)
    if sAvionics == nil then return end
end


function ControllerManager.updateAircraftActions(tEventActionMap,hAircraft)
    if hAircraft == nil then return end
    for i,sController in ipairs(tControllerList) do
        if hAircraft.applyControllerActions then
            hAircraft.applyControllerActions(tEventActionMap,sController,ControllerManager.tCtlMgrs[sController],ControllerManager.tEventIDs[sController])
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