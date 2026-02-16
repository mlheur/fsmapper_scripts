local hController = {}
hController.tTombstone = {
    name = "DualAction",
    type = "dinput",
    identifier = {
        name = 'Logitech Dual Action',
    }
}
hController.defaultMods = {
    {name = 'button1',  modtype = 'button'},
    {name = 'button2',  modtype = 'button'},
    {name = 'button3',  modtype = 'button'},
    {name = 'button4',  modtype = 'button'},
    {name = 'button5',  modtype = 'button'},
    {name = 'button6',  modtype = 'button'},
    {name = 'button7',  modtype = 'button'},
    {name = 'button8',  modtype = 'button'},
    {name = 'button9',  modtype = 'button'},
    {name = 'button10', modtype = 'button'},
    {name = 'button12', modtype = 'button'},
    --{name = 'x' },
    {name = 'z',        modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    {name = 'rz',       modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    -- Y axis (Left Thumbstick, up & down) controls the global Altimeter through Kohlsman SimVar.
    -- Clicking said thumbstick toggles between STD and BARO altimeter readouts on glass cockpits.
    {name = 'button11', modtype = 'button'},
    {
        name     = 'y',
        modtype  = 'quantized_stick',
        modparam = {
            repeat_interval    = 10,
            repeat_delay       = 100,
            activate_threshold = 40000,
            release_threshold  = 40001,
        }
    },
}


function hController.onInit()
    hController.nAltimeter = 16211 --millibars, 29.92 inHg truncated to int.
    hController.nAltStep   = 1
    hController.nAltBaroID = 0
    hController.bStdBaro   = 0
    --mapper.print("DualAction.onInit() set hController.nAltimeter=["..hController.nAltimeter.."]")
end


local function doAltimiterChange(nStep)
    hController.nAltimeter = hController.nAltimeter + nStep
    RPN = tostring(hController.nAltimeter).." (>K:"..hController.nAltBaroID..":KOHLSMAN_SET)"
    --mapper.print("DualAction:doAltimeterChange with RPN=["..RPN.."]")
    msfs.mfwasm.execute_rpn(RPN)
end
local function doAltimeterIncrease(nEventID, tArgs)
    doAltimiterChange(hController.nAltStep)
end
local function doAltimeterDecrease(nEventID, tArgs)
    doAltimiterChange(hController.nAltStep * -1)
end


local function toggleStdBaro(nEventID, tArgs)
    --msfs.execute_input_event("AUTOPILOT_Baro_1_Std_Button",1)
    hController.bStdBaro = (hController.bStdBaro + 1) % 2
    RPN = hController.bStdBaro.." (>A:KOHLSMAN SETTING STD:0, Bool)"
    msfs.mfwasm.execute_rpn(RPN)
end


function hController.applyDefaultActions(tEventActionMap,hAircraft,tEventIDs)
    hController.onInit() -- reset nAltimeter
    tEventActionMap[tEventIDs.y.negative]    = doAltimeterIncrease
    tEventActionMap[tEventIDs.y.positive]    = doAltimeterDecrease
    tEventActionMap[tEventIDs.button11.down] = toggleStdBaro
end


return hController