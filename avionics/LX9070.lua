hAvionics = {}

local function as9070_RPN(tKnobSpecs,sSide,sInOut,sAction)
    return tKnobSpecs.sIdentifier..sInOut..sSide.."Knob"..sAction
end

hAvionics.tKnobSpecs = {
    sDesiredController = "F710",
    sIdentifier        = "AS9070",
    sPilotSide         = "Left",
    sCoPilotSide       = "Right",
    sOuter             = "_Upper",
    sInner             = "_Bottom",
    sClockwise         = "Inc",
    sCounterClockwise  = "Dec",
    fnCompileRPN       = as9070_RPN
}

return hAvionics