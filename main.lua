local plane_mgr = require("lib/planes")
local device_mgr = require("lib/devices")

--------------------------------------------------------------------------------
-- Main: Reload everything whenever the aircraft is changed.
--------------------------------------------------------------------------------
mapper.set_primary_mappings{
    {
        event=mapper.events.change_aircraft,
        action = function (evid,args)
            mapper.set_secondary_mappings{}
            plane_mgr.add_mappings(args.aircraft,device_mgr)
        end
    },
}