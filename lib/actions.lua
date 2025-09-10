local mgr = {}

local function inverse_mixmax_percent(value)
    return(( -50000 + value ) / -100000)
end

local function mixmax_percent(value)
    return(( 50000 + value ) / 100000)
end

mgr.FUEL_Mixture_1 = function(evid,args)
    msfs.execute_input_event('FUEL_Mixture_1',inverse_mixmax_percent(args))
end


mgr.ENGINE_Propeller_1 = function(evid,args)
    msfs.execute_input_event('ENGINE_Propeller_1',inverse_mixmax_percent(args))
end

mgr.ENGINE_Propeller_1_feather = function(evid,args)
    msfs.execute_input_event('ENGINE_Propeller_1',-.25 + 1.25*inverse_mixmax_percent(args))
end


mgr.FUEL_1_Condition = function(evid,args)
    msfs.execute_input_event('FUEL_1_Condition_Lever',math.floor(3*mixmax_percent(args)))
end


mgr.SPOILERS_off = msfs.input_event_executer('HANDLING_Spoilers', 0)
mgr.SPOILERS_on  = msfs.input_event_executer('HANDLING_Spoilers', 1)


mgr.SCRAM_ready = function(evid,args)
    msfs.execute_input_event('ELECTRICAL_Fuel_Cell', 1)
    msfs.execute_input_event('COMMON_Cover_Transition', 0)
end

mgr.SCRAM_unready = function(evid,args)
    msfs.execute_input_event('ENGINE_Transition', 0)
    msfs.execute_input_event('ELECTRICAL_Fuel_Cell', 1)
    msfs.execute_input_event('COMMON_Cover_Transition', 1)
end

mgr.SCRAM_on  = msfs.input_event_executer('ENGINE_Transition', 1)
mgr.SCRAM_off = msfs.input_event_executer('ENGINE_Transition', 0)


mgr.RUDDER_up   = msfs.input_event_executer('HANDLING_Water_Rudder', 0)
mgr.RUDDER_down = msfs.input_event_executer('HANDLING_Water_Rudder', 1)


return mgr