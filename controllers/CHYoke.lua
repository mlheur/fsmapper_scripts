local hController = {}

hController.tTombstone = {
    name = "CHYoke",
    type = "dinput",
    identifier = {
        guid = '{1DDD4F20-8387-11ED-8001-444553540000}'
    },
}

hController.defaultMods = {
    { name =  "button1", modtype = 'button' },
    { name =  "button2", modtype = 'button' },
    { name =  "button3", modtype = 'button' },
    { name =  "button4", modtype = 'button' },
    { name =  "button5", modtype = 'button' },
    { name =  "button6", modtype = 'button' },
    { name =  "button7", modtype = 'button' },
    { name =  "button8", modtype = 'button' },
    { name =  "button9", modtype = 'button' },
    { name = "button10", modtype = 'button' },
    { name = "button11", modtype = 'button', modparam = { repeat_interval = 10, } },
    { name = "button12", modtype = 'button', modparam = { repeat_interval = 10, } },
    { name = 'x', modtype = 'quantized_stick', modparam = { repeat_mode = false, activate_threshold = 49999, release_threshold = 50000, } },
    { name = 'y', modtype = 'quantized_stick', modparam = { repeat_mode = false, activate_threshold = 49999, release_threshold = 50000, } },
}

-- X & Y axes are the yoke/stick for roll & pitch
-- Z axis is the barrel-shaped throttle lever
-- RY axis is the squarish crown-shaped prop lever
-- RX axis is the round spikey mixture lever

function hController.applyDefaultActions(tEventActionMap,hAircraft,tEventIDs)
    tEventActionMap[tEventIDs.button12.down] = msfs.input_event_executer('HANDLING_ElevatorTrim_Yoke', 2)
    tEventActionMap[tEventIDs.button11.down] = msfs.input_event_executer('HANDLING_ElevatorTrim_Yoke', 0)
    tEventActionMap[tEventIDs.button12.up]   = msfs.input_event_executer('HANDLING_ElevatorTrim_Yoke', 1)
    tEventActionMap[tEventIDs.button11.up]   = msfs.input_event_executer('HANDLING_ElevatorTrim_Yoke', 1)
    if hAircraft then
        if hAircraft.nEng then
            if tManagers["Action"].ENGINE_Throttle and tManagers["Action"].ENGINE_Throttle[hAircraft.nEng] then
                mapper.print("CHYoke:applyDefaultActions() is mapping event z.change to action tManagers[Action].ENGINE_Throttle["..hAircraft.nEng.."]")
                tEventActionMap[tEventIDs.z.change] = tManagers["Action"].ENGINE_Throttle[hAircraft.nEng]
            end
        end
        if hAircraft.nMix then
            if tManagers["Action"].FUEL_Mixture and tManagers["Action"].FUEL_Mixture[hAircraft.nMix] then
                mapper.print("CHYoke:applyDefaultActions() is mapping event rx.change to action tManagers[Action].FUEL_Mixture["..hAircraft.nMix.."]")
                tEventActionMap[tEventIDs.rx.change] = tManagers["Action"].FUEL_Mixture[hAircraft.nMix]
            end
        end
        if hAircraft.nProp then
            if tManagers["Action"].ENGINE_Propeller and tManagers["Action"].ENGINE_Propeller[hAircraft.nProp] then
                mapper.print("CHYoke:applyDefaultActions() is mapping event ry.change to action tManagers[Action].ENGINE_Propeller["..hAircraft.nProp.."]")
                tEventActionMap[tEventIDs.ry.change] = tManagers["Action"].ENGINE_Propeller[hAircraft.nProp]
            end
        end
        if hAircraft.nCond then
            if tManagers["Action"].FUEL_Condition and tManagers["Action"].FUEL_Condition[hAircraft.nCond] then
                mapper.print("CHYoke:applyDefaultActions() is mapping event ry.change to action tManagers[Action].FUEL_Condition["..hAircraft.nCond.."]")
                tEventActionMap[tEventIDs.rx.change] = tManagers["Action"].FUEL_Condition[hAircraft.nCond]
            end
        end
        if hAircraft.nFthr then
            if tManagers["Action"].ENGINE_Propeller_feather and tManagers["Action"].ENGINE_Propeller_feather[hAircraft.nFthr] then
                mapper.print("CHYoke:applyDefaultActions() is mapping event ry.change to action tManagers[Action].ENGINE_Propeller_feather["..hAircraft.nFthr.."]")
                tEventActionMap[tEventIDs.ry.change] = tManagers["Action"].ENGINE_Propeller_feather[hAircraft.nFthr]
            end
        end
    end
end

return hController