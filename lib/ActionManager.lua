local mgr = {}


-- callback functions for arithmatic with event values, all the math
-- must be performed within the callback

local function inverse_mixmax_percent(value)
    return(( -50000 + value ) / -100000)
end

local function inverse_mixmax_percent_100(value)
    return(100 * inverse_mixmax_percent(value))
end

local function mixmax_percent(value)
    return(( 50000 + value ) / 100000)
end

local function mixmax_percent_100(value)
    return(100 * mixmax_percent(value))
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


-- iteretor and generator functions, to create multi-engine
-- handlers on the fly.

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


-- All the MSFS actions to do when an event happens

mgr.ENGINE_Throttle = {}
mgr.ENGINE_Throttle[0] = function(evid,args)
    msfs.execute_input_event("ENGINE_Throttle",inverse_mixmax_percent(args))
end
mgr.ENGINE_Throttle[1] = iterator_generator("ENGINE_Throttle_","",1,inverse_mixmax_percent)
mgr.ENGINE_Throttle[2] = iterator_generator("ENGINE_Throttle_","",2,inverse_mixmax_percent)
mgr.ENGINE_Throttle[4] = iterator_generator("ENGINE_Throttle_","",4,inverse_mixmax_percent)
mgr.ENGINE_Throttle_H4 = function(evid,args)
    value = inverse_mixmax_percent(args)
    msfs.execute_input_event("ENGINE_Throttle_1",value)
--    msfs.execute_input_event("ENGINE_Throttle_2",value)
    msfs.execute_input_event("ENGINE_Throttle_3",value)
--    msfs.execute_input_event("ENGINE_Throttle_4",value)
    msfs.execute_input_event("ENGINE_Throttle_5",value)
--    msfs.execute_input_event("ENGINE_Throttle_6",value)
    msfs.execute_input_event("ENGINE_Throttle_7",value)
--    msfs.execute_input_event("ENGINE_Throttle_8",value)
end


mgr.ENGINE_Throttle_Reverser = {}
mgr.ENGINE_Throttle_Reverser[2] = iterator_generator("ENGINE_Throttle_Reverser_","",2,mixmax_percent)
mgr.ENGINE_Throttle_Reverser[4] = iterator_generator("ENGINE_Throttle_Reverser_","",4,mixmax_percent)


mgr.ENGINE_Throttle_Reducer = {}
mgr.ENGINE_Throttle_Reducer[2] = iterator_generator("ENGINE_Throttle_","",2,throttle_reducer)
mgr.ENGINE_Throttle_Reducer[4] = iterator_generator("ENGINE_Throttle_","",4,throttle_reducer)


mgr.FUEL_Mixture = {}
mgr.FUEL_Mixture[1] = iterator_generator("FUEL_Mixture_","",1,inverse_mixmax_percent)
mgr.FUEL_Mixture[2] = iterator_generator("FUEL_Mixture_","",2,inverse_mixmax_percent)
mgr.FUEL_Mixture[0] = function(evid,args)
    msfs.execute_input_event("FUEL_Mixture",inverse_mixmax_percent(args))
end


mgr.FUEL_Mixture_inverted = {}
mgr.FUEL_Mixture_inverted[1] = iterator_generator("FUEL_Mixture_","",1,mixmax_percent)


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
mgr.SPOILERS_decrement = function(evid,args)
    msfs.execute_input_event('HANDLING_Spoilers', 0)
end
mgr.SPOILERS_increment = function(evid,args)
    msfs.execute_input_event('HANDLING_Spoilers', 2)
end
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


mgr.DEICE_Engine = {}
mgr.DEICE_Engine[1] = iterator_generator("DEICE_Engine_","",1,mixmax_percent)


mgr.DEICE_Engine_inverted = {}
mgr.DEICE_Engine_inverted[1] = iterator_generator("DEICE_Engine_","",1,inverse_mixmax_percent)


mgr.ENGINE_Choke = {}
mgr.ENGINE_Choke[100] = iterator_generator("ENGINE_Choke_","",1,mixmax_percent_100)
mgr.ENGINE_Choke_off = msfs.input_event_executer('ENGINE_Choke_1', 0)
mgr.ENGINE_Choke_on  = msfs.input_event_executer('ENGINE_Choke_1', 1)


mgr.LANDING_GEAR_Brake_lever = function(evid,args)
    msfs.execute_input_event('LANDING_GEAR_Brake', -1 + 2 * mixmax_percent(args))
end


mgr.PASSENGER_Cabin_Heat = {}
mgr.PASSENGER_Cabin_Heat[1] = iterator_generator("PASSENGER_Cabin_Heat_","",1,mixmax_percent_100)


mgr.ENGINE_Collective_Lever = function(evid,args)
    msfs.execute_input_event('ENGINE_Collective_Lever', inverse_mixmax_percent(args))
end
mgr.ENGINE_Collective_Axis = function(evid,args)
    msfs.mfwasm.execute_rpn( math.floor(-16384+32768*inverse_mixmax_percent(args)) .. " (>K:AXIS_COLLECTIVE_SET)" )
end
mgr.THROTTLE_CollectiveGrip = function(evid,args)
    msfs.mfwasm.execute_rpn(math.floor(100*inverse_mixmax_percent(args)) .. " (>L:CollectiveGrip,percent)")
end

function mgr.toggle(tTracker)
    tTracker.iValue = ((tTracker.iValue + 1) % 2)
    sType = type(tTracker.sSystem)
    if sType == "table" then
        for _,sEvent in ipairs(tTracker.sSystem) do
            msfs.execute_input_event(sEvent, tTracker.iValue)
        end
    else
        msfs.execute_input_event(tTracker.sSystem, tTracker.iValue)
    end
end

return mgr