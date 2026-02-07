tManagerNames = {"Plane","Controller","Action","String"}
tManagers = {}


function tryImport(sFile) return require(sFile) end


local function onChangeAircraft(nEventID,tArgs)
    if tArgs.aircraft == nil then return end
    -- wipe the slate clean
    mapper.set_secondary_mappings( {} )
    -- Do the thing with the thing
    tManagers["Plane"].setMappings(tArgs.aircraft)
end


local function onInit()
    for i,sMgr in ipairs(tManagerNames) do
        tManagers[sMgr] = require("lib/"..sMgr.."Manager")
        if tManagers[sMgr].onInit then tManagers[sMgr].onInit() end
    end
    local tTopLevelMap = {}
    tTopLevelMap[1] = {}
    tTopLevelMap[1].event  = mapper.events.change_aircraft
    tTopLevelMap[1].action = onChangeAircraft
    mapper.set_primary_mappings(tTopLevelMap)
end


onInit()