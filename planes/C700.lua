hAircraft = {}

hAircraft.name = "C700"
hAircraft.nEng = 2
hAircraft.bReducer = true

function hAircraft.applyControllerActions(tEventActionMap,hAircraft,sController,hController,tEventIDs)
    if sController == "F710" then
        tEventActionMap[tEventIDs.button4.down] = tManagers["Action"].setAutopilotOn
    elseif sController == "CHYoke" then
        --tEventActionMap[tEventIDs.button11.down] = msfs.input_event_executer('HANDLING_ElevatorTrim_1', 2)
        --tEventActionMap[tEventIDs.button12.down] = msfs.input_event_executer('HANDLING_ElevatorTrim_1', 0)
        --tEventActionMap[tEventIDs.button11.up] = msfs.input_event_executer('HANDLING_ElevatorTrim_1', 1)
        --tEventActionMap[tEventIDs.button12.up] = msfs.input_event_executer('HANDLING_ElevatorTrim_1', 1)
        tEventActionMap[tEventIDs.ry.change] = tManagers["Action"].SPOILERS_lever_16k
    end
end


return hAircraft