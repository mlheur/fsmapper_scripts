hAircraft = {}

hAircraft.name = "FA18E"

local nElevatorValue = 50
local nElevatorStep = 10
function hAircraft.onIncreaseElevator(nEventID,tArgs)
    nElevatorValue = nElevatorValue + nElevatorStep
    msfs.execute_input_event('HANDLING_ElevatorTrim_1', nElevatorValue)
end
function hAircraft.onDecreaseElevator(nEventID,tArgs)
    nElevatorValue = nElevatorValue - nElevatorStep
    msfs.execute_input_event('HANDLING_ElevatorTrim_1', nElevatorValue)
end

function hAircraft.applyControllerActions(tEventActionMap,hAircraft,sController,hController,tEventIDs)
    if sController == "CHYoke" then
        tEventActionMap[tEventIDs.button12.down] = hAircraft.onIncreaseElevator
        tEventActionMap[tEventIDs.button11.down] = hAircraft.onDecreaseElevator
        tEventActionMap[tEventIDs.button12.up]   = nil
        tEventActionMap[tEventIDs.button11.up]   = nil
    end
end

return hAircraft