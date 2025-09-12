local mgr = {}

local function inverse_mixmax_percent(value)
    return(( -50000 + value ) / -100000)
end

local function mixmax_percent(value)
    return(( 50000 + value ) / 100000)
end

local function tristate(value)
    return(math.floor(3*mixmax_percent(value)))
end

local function feather_25pct(value)
    return(-.25 + 1.25*inverse_mixmax_percent(value))
end

local function throttle_reducer(value)
    return(-.25 * mixmax_percent(value))
end


local function iterate_event(prestring,poststring,iterations,value)
    i = 0
    while i < iterations do
        i = i+1
        eventstring = prestring .. i .. poststring
        msfs.execute_input_event(eventstring,value)
    end
end

local function iterator_generator(prestring,poststring,iterations,value_callback)
    local it_fn = function(evid,args)
        iterate_event(prestring,poststring,iterations,value_callback(args))
    end
    return it_fn
end


mgr.ENGINE_Throttle = {}
mgr.ENGINE_Throttle[1] = iterator_generator("ENGINE_Throttle_","",1,inverse_mixmax_percent)
mgr.ENGINE_Throttle[2] = iterator_generator("ENGINE_Throttle_","",2,inverse_mixmax_percent)
mgr.ENGINE_Throttle[4] = iterator_generator("ENGINE_Throttle_","",4,inverse_mixmax_percent)


mgr.ENGINE_Throttle_Reverser = {}
mgr.ENGINE_Throttle_Reverser[2] = iterator_generator("ENGINE_Throttle_Reverser_","",2,mixmax_percent)
mgr.ENGINE_Throttle_Reverser[4] = iterator_generator("ENGINE_Throttle_Reverser_","",4,mixmax_percent)


mgr.ENGINE_Throttle_Reducer = {}
mgr.ENGINE_Throttle_Reducer[2] = iterator_generator("ENGINE_Throttle_","",2,throttle_reducer)
mgr.ENGINE_Throttle_Reducer[4] = iterator_generator("ENGINE_Throttle_","",4,throttle_reducer)


mgr.FUEL_Mixture = {}
mgr.FUEL_Mixture[1] = iterator_generator("FUEL_Mixture_","",1,inverse_mixmax_percent)
mgr.FUEL_Mixture[2] = iterator_generator("FUEL_Mixture_","",2,inverse_mixmax_percent)


mgr.FUEL_Condition = {}
mgr.FUEL_Condition[1] = iterator_generator("FUEL_","_Condition_Lever",1,tristate)
mgr.FUEL_Condition[2] = iterator_generator("FUEL_","_Condition_Lever",2,tristate)


mgr.ENGINE_Propeller = {}
mgr.ENGINE_Propeller[1] = iterator_generator("ENGINE_Propeller_","",1,inverse_mixmax_percent)
mgr.ENGINE_Propeller[2] = iterator_generator("ENGINE_Propeller_","",2,inverse_mixmax_percent)


mgr.ENGINE_Propeller_feather = {}
mgr.ENGINE_Propeller_feather[1] = iterator_generator("ENGINE_Propeller_","",1,feather_25pct)
mgr.ENGINE_Propeller_feather[2] = iterator_generator("ENGINE_Propeller_","",2,feather_25pct)


mgr.SPOILERS_off = msfs.input_event_executer('HANDLING_Spoilers', 0)
mgr.SPOILERS_on  = msfs.input_event_executer('HANDLING_Spoilers', 1)
mgr.SPOILERS_lever = function(evid,args)
    msfs.execute_input_event('HANDLING_Spoilers',mixmax_percent(args))
end
mgr.SPOILERS_lever_16k = function(evid,args)
    msfs.execute_input_event('HANDLING_Spoilers',16384*mixmax_percent(args))
end


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