local PlaneManager = {}

--$ awk '{for (i=1;i<=NF;i++){if($i=="return"){print $(i+1)}}}' planes.lua | awk -F, '{print $1}' | sort -u | grep -v '^mgr$' | xargs echo
--A20N A320 A5 B350 B748 B78X BE36 BE58 B407 C152 C172 C208 C25C C700 Cabri CC19 CP10 Cub DA40 DA62 Darkstar DC3 DGF DHC2 DR40 DV20 E300 FA18E FDCT G21A H4 JN4D MXS Orbis PC6 PIVI PTS2 S22T SAVG Spirit TBM9 VELO VL3 Wright

local tPresets = {}
tPresets.A5       = nil -- unique single engine, no avionics, with rudders
tPresets.A20N     = nil -- has a broken throttle complained about in many forums
tPresets.A320     = "C700"
tPresets.B350     = "TurboProp2"
tPresets.B748     = nil -- has unique values from other jumbo jets
tPresets.B78X     = nil -- has unique values from other jumbo jets
tPresets.BE36     = "gaVariProp"
tPresets.BE58     = "gaVariProp2"
tPresets.B407     = nil -- helicopter
tPresets.C152     = "gaFixedProp"
tPresets.C172     = "gaFixedProp"
tPresets.C208     = "TurboProp"
tPresets.C25C     = nil -- has unique values from other jumbo jets
tPresets.C700     = nil -- has unique values from other jumbo jets
tPresets.Cabri    = nil -- helicopter
tPresets.CC19     = "gaVariProp"
tPresets.CP10     = "gaFixedProp"
tPresets.Cub      = "automatic" -- Throttle from auto, Choke in plane/Cub.lua
tPresets.Darkstar = "automatic2"
tPresets.DA40     = "automatic"
tPresets.DA62     = "automatic2"
tPresets.DC3      = "gaVariProp2"
tPresets.DGF      = nil -- glider with engine...
tPresets.DHC2     = "gaVariProp"
tPresets.DR40     = "gaFixedProp"
tPresets.DV20     = nil -- prop w/out mixture, carb-heat lever
tPresets.E300     = "gaVariProp"
tPresets.FA18E    = "automatic2" -- spoilers are unique
tPresets.FDCT     = nil -- has choke and brakes levers
tPresets.G21A     = "gaVariProp2"
tPresets.H4       = nil -- unique engine controls
tPresets.JN4D     = nil -- mixture action is reversed
tPresets.MXS      = nil -- glider
tPresets.Orbis    = nil -- not flyable, static display
tPresets.PC6      = "TurboProp"
tPresets.PIVI     = nil -- Throttle, Prop, Choke
tPresets.PTS1     = "gaFixedProp"
tPresets.PTS2     = "gaVariProp"
tPresets.S22T     = nil
tPresets.SAVG     = nil -- Zlin Aviation Savage Cub (little yellow thing)
tPresets.Spirit   = nil
tPresets.TBM9     = nil
tPresets.VOLO     = nil -- drone
tPresets.VL3      = nil
tPresets.Wright   = nil

tAircraft = {}
tAircraft.automatic   = { nEng = 1, }
tAircraft.automatic2  = { nEng = 2, }
tAircraft.gaFixedProp = { nEng = 1, nMix  = 1, }
tAircraft.gaVariProp  = { nEng = 1, nMix  = 1, nProp = 1, }
tAircraft.gaVariProp2 = { nEng = 2, nMix  = 2, nProp = 2, }
tAircraft.TurboProp   = { nEng = 1, nCond = 1, nFthr = 1, }
tAircraft.TurboProp2  = { nEng = 2, nCond = 2, nFthr = 2, }

local function getMakeAvionics(sAircraftPrettyName)
    local sFirstWord,sFirstTwoWords = tManagers["String"].getFirstTwoWords(sAircraftPrettyName)

    -- Some aircraft come with different avionics, but
    -- use the same name in the first few words.  Find and
    -- resolve those first.
    if sFirstTwoWords == "Cessna Skyhawk" then
        if string.find(sAircraftPrettyName,"G1000") ~= nil then
            return "C172","G1000"
        end
        return "C172","GNS530"
    elseif sFirstTwoWords == "Pilatus PC-6" then
        if string.find(sAircraftPrettyName,"G950") ~= nil then
            return "PC6","G1000"
        end
        return "PC6","GNS530"
    elseif sFirstTwoWords == "DA 40" or sFirstWord == "DA40-NG" or sFirstWord == "DA40" then
        if string.find(sAircraftPrettyName," TDI ") ~= nil then
            return "DA40","GNS430"
        end
        return "DA40","G1000"
    elseif sFirstWord == "Pitts" then
        if string.find(sAircraftPrettyName," S1 Reno") ~= nil then
            return "PTS1",nil
        end
        return "PTS2",nil
    end

    -- G1000
    sAvionics = "G1000"
    if sFirstTwoWords == "Asobo Baron"           then return "BE58",sAvionics end
    if sFirstTwoWords == "Baron G58"             then return "BE58",sAvionics end
    if sFirstTwoWords == "Bonanza G36"           then return "BE36",sAvionics end
    if sFirstTwoWords == "Cessna 208B"           then return "C208",sAvionics end
    if sFirstTwoWords == "Cessna Grand"          then return "C208",sAvionics end
    if sFirstWord     == "DA62"                  then return "DA62",sAvionics end
    if sFirstTwoWords == "DA 62"                 then return "DA62",sAvionics end
    if sFirstWord     == "SR22T"                 then return "S22T",sAvionics end
    if sFirstTwoWords == "SR 22"                 then return "S22T",sAvionics end
    
    -- GNS 530
    sAvionics = "GNS530"
    if sFirstTwoWords == "Bell 407"              then return "B407",sAvionics end
    if sFirstTwoWords == "Blackbird Simulations" then return "DHC2",sAvionics end -- DHC-2, Beaver
    if sFirstTwoWords == "Hercules H-4"          then return "H4",sAvionics end
    
    -- GNS 430
    sAvionics = "GNS430"
    if sFirstTwoWords == "Mudry Cap"             then return "CP10",sAvionics end
    if sFirstWord     == "DV20"                  then return "DV20",sAvionics end
    if sFirstTwoWords == "DV 20"                 then return "DV20",sAvionics end
    
    -- MFD 9070
    sAvionics = "LX9070"
    if sFirstTwoWords == "Asobo DG1001E"         then return "DGF",sAvionics end

    -- I haven't decided if I want to map the GDU370, or the GNS; GNS is low hanging fruit for now.
    sAvionics = "GNS430"
    if sFirstWord     == "Pipistrel"             then return "PIVI",sAvionics end
    if sFirstTwoWords == "Extra 330"             then return "E300",sAvionics end

    -- The rest of the aircraft have either touch input or minimal instruments
    sAvionics = nil
    if sFirstTwoWords == "Airbus A320"           then return "A320",sAvionics end
    if sFirstWord     == "A320neo"               then return "A20N",sAvionics end
    if sFirstTwoWords == "Boeing 747-8i"         then return "B748",sAvionics end
    if sFirstTwoWords == "Boeing 787-10"         then return "B78X",sAvionics end
    if sFirstWord     == "B787"                  then return "B78X",sAvionics end
    if sFirstWord     == "C152"                  then return "C152",sAvionics end
    if sFirstTwoWords == "Cessna 152"            then return "C152",sAvionics end
    if sFirstTwoWords == "Cessna CJ4"            then return "C25C",sAvionics end
    if sFirstTwoWords == "Experimental Darkstar" then return "Darkstar",sAvionics end
    if sFirstWord     == "DR400"                 then return "DR40",sAvionics end
    if sFirstTwoWords == "DR 400"                then return "DR40",sAvionics end
    if sFirstTwoWords == "Boeing F/A"            then return "FA18E",sAvionics end
    if sFirstWord     == "F18"                   then return "FA18E",sAvionics end
    if sFirstWord     == "FlightDesignCT"        then return "FDCT",sAvionics end
    if sFirstTwoWords == "Flight Design"         then return "FDCT",sAvionics end
    if sFirstTwoWords == "Icon A5"               then return "A5",sAvionics end
    if sFirstTwoWords == "Beechcraft King"       then return "B350",sAvionics end
    if sFirstTwoWords == "Cessna Longitude"      then return "C700",sAvionics end
    if sFirstTwoWords == "Asobo LS8"             then return "MXS",sAvionics end
    if sFirstTwoWords == "Asobo NXCub"           then return "CC19",sAvionics end
    if sFirstTwoWords == "Asobo XCub"            then return "CC19",sAvionics end
    if sFirstWord     == "Xcub"                  then return "CC19",sAvionics end
    if sFirstTwoWords == "Orbis Asobo"           then return "Orbis",sAvionics end
    if sFirstTwoWords == "Asobo Savage"          then return "SAVG",sAvionics end
    if sFirstTwoWords == "Savage Shock"          then return "Cub",sAvionics end
    if sFirstWord     == "Savage"                then return "SAVG",sAvionics end
    if sFirstTwoWords == "TBM 930"               then return "TBM9",sAvionics end
    if sFirstWord     == "VL3"                   then return "VL3",sAvionics end
    if sFirstTwoWords == "Douglas DC-3"          then return "DC3",sAvionics end
    if sFirstTwoWords == "Grumman Goose"         then return "G21A",sAvionics end
    if sFirstTwoWords == "Curtiss JN-4D"         then return "JN4D",sAvionics end
    if sFirstTwoWords == "Spirit Of"             then return "Spirit",sAvionics end
    if sFirstWord     == "Volocity"              then return "VOLO",sAvionics end
    if sFirstTwoWords == "Asobo Cabri"           then return "Cabri",sAvionics end
    if sFirstWord     == "Wright"                then return "Wright",sAvionics end
end

function PlaneManager.setMappings(sAircraftPrettyName)
    local sMake,sAvionics = getMakeAvionics(sAircraftPrettyName)
    if not sMake then
        mapper.print("FATAL: unable to determine the make and avionics of the aircraft, loading nothing")
        return
    end

    local hPreset = nil
    -- when a tPreset exists, some auto-config options can be applied
    if tPresets[sMake] then
        -- when a tAircraft exists for a preset, the auto-config knows what to do
        if tAircraft[tPresets[sMake]] then
            hPreset = tAircraft[tPresets[sMake]]
        else
            -- but when a tPreset exists without a related tAircraft,
            -- that's a full-on clone, e.g. A320 clones all from C700
            sMake = tPresets[sMake]
        end
    end

    local bLoadedAircraftFile,hAircraft = pcall(tryImport, "planes/"..sMake)
    if not bLoadedAircraftFile then
        hAircraft = hPreset
    else
        for k,v in pairs(hPreset) do
            hAircraft[k] = v
        end
        if hAircraft.onInit then hAircraft.onInit() end
        mapper.print("Loaded aircraft configuration "..sMake)
    end

    local tEventActionMap = {}
    tManagers["Controller"].openControllers(hAircraft)

    tManagers["Controller"].updateControllerActions(tEventActionMap,hAircraft)
    tManagers["Controller"].updateAvionicsActions(tEventActionMap,hAircraft,sAvionics)
    tManagers["Controller"].updateAircraftActions(tEventActionMap,hAircraft)

    tManagers["Controller"].applyActions(tEventActionMap)
end

return PlaneManager