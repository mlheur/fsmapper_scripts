device_mgr = require("lib/devices")
action_mgr = require("lib/actions")
plane_mgr  = require("lib/planes")

--------------------------------------------------------------------------------
-- Main: Reload everything whenever the aircraft is changed.
--------------------------------------------------------------------------------
local function onChangeAircraft(evid,args)
    if args.aircraft == nil then return end
    mapper.set_secondary_mappings( {} )
    plane_mgr.add_mappings(args.aircraft)
end

tTopLevelMap = {}
table.insert( tTopLevelMap, { event = mapper.events.change_aircraft, action = onChangeAircraft } )

mapper.set_primary_mappings(tTopLevelMap)