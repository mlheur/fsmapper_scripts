local hController = {}

hController.tTombstone = {
    name = "F710",
    type = "dinput",
    identifier = {
        name = 'Controller (Wireless Gamepad F710)',
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
    {name = 'x',        modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    {name = 'y',        modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    {name = 'rx',       modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    {name = 'ry',       modtype = 'quantized_stick', modparam = { repeat_interval = 100, } },
    {name = 'z',        modtype = 'quantized_stick', modparam = { repeat_mode = false, } }, -- z.negative == L2 analog trigger down; z.positive == R2 analog trigger down
}

local function compileRPN(tKnobSpecs,bPilotCoPilot,bInnerOuter,bClockCounter,bClick)
    local sSide = tKnobSpecs.sCoPilotSide
    if bPilotCoPilot then sSide = tKnobSpecs.sPilotSide end
    local sInOut = tKnobSpecs.sOuter
    if bInnerOuter then sInOut = tKnobSpecs.sInner end
    local sAction = tKnobSpecs.sCounterClockwise
    if bClick and tKnobSpecs.sClick then
        sAction = tKnobSpecs.sClick
    else
        if bClockCounter then
            sAction = tKnobSpecs.sClockwise
        end
    end
    if tKnobSpecs.fnCompileRPN then
        mapper.print("Runing custom RPN compiler")
        return tKnobSpecs.fnCompileRPN(tKnobSpecs,sSide,sInOut,sAction)
    end
    return tKnobSpecs.sIdentifier..sSide..sInOut..sAction
end

function hController.applyAvionicsKnobs(tEventActionMap,tKnobSpecs,tEventIDs)

    local bPilotCopilot = true
    RPN = ("(>H:"..compileRPN(tKnobSpecs,bPilotCopilot,false,true,nil)..")")
    tEventActionMap[tEventIDs.x.positive]    = msfs.mfwasm.rpn_executer(RPN)
    RPN = ("(>H:"..compileRPN(tKnobSpecs,bPilotCopilot,false,false,nil)..")")
    tEventActionMap[tEventIDs.x.negative]    = msfs.mfwasm.rpn_executer(RPN)
    RPN = ("(>H:"..compileRPN(tKnobSpecs,bPilotCopilot,true,true,nil)..")")
    tEventActionMap[tEventIDs.y.positive]    = msfs.mfwasm.rpn_executer(RPN)
    RPN = ("(>H:"..compileRPN(tKnobSpecs,bPilotCopilot,true,false,nil)..")")
    tEventActionMap[tEventIDs.y.negative]    = msfs.mfwasm.rpn_executer(RPN)
    RPN = ("(>H:"..compileRPN(tKnobSpecs,bPilotCopilot,true,nil,true)..")")
    tEventActionMap[tEventIDs.button9.down]  = msfs.mfwasm.rpn_executer(RPN)

    bPilotCopilot = false
    RPN = ("(>H:"..compileRPN(tKnobSpecs,bPilotCopilot,false,true,nil)..")")
    tEventActionMap[tEventIDs.rx.positive]   = msfs.mfwasm.rpn_executer(RPN)
    RPN = ("(>H:"..compileRPN(tKnobSpecs,bPilotCopilot,false,false,nil)..")")
    tEventActionMap[tEventIDs.rx.negative]   = msfs.mfwasm.rpn_executer(RPN)
    RPN = ("(>H:"..compileRPN(tKnobSpecs,bPilotCopilot,true,true,nil)..")")
    tEventActionMap[tEventIDs.ry.positive]   = msfs.mfwasm.rpn_executer(RPN)
    RPN = ("(>H:"..compileRPN(tKnobSpecs,bPilotCopilot,true,false,nil)..")")
    tEventActionMap[tEventIDs.ry.negative]   = msfs.mfwasm.rpn_executer(RPN)
    RPN = ("(>H:"..compileRPN(tKnobSpecs,bPilotCopilot,true,nil,true)..")")
    tEventActionMap[tEventIDs.button10.down] = msfs.mfwasm.rpn_executer(RPN)
end

return hController