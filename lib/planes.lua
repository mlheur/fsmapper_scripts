local mgr = {}

local F710 = require("lib/F710")
local Yoke = require("lib/CH-Yoke")

local function get_make_model(aircraft)
    local string_mgr = require("lib/strings")
    local first_word,first_two_words = string_mgr.get_first_two_words(aircraft)

    -- Some aircraft come with different dashboard instrumentation
    -- but use the same name in the first few words.
    if first_two_words == "Cessna Skyhawk" then
        if string.find(aircraft,"G1000") ~= nil then
            return "C172","G1000"
        end
        return "C172","GNS530"
    end

    if first_two_words == "Pilatus PC-6" then
        if string.find(aircraft,"G950") ~= nil then
            return "PC6","G1000"
        end
        return "PC6","GNS530"
    end

    if first_two_words == "DA 40" or first_word == "DA40-NG" or first_word == "DA40" then
        if string.find(aircraft," TDI ") ~= nil then
            return "DA40","GNS430"
        end
        return "DA40","G1000"
    end

    -- G1000
    model = "G1000"
    if first_two_words == "Asobo Baron"           then return "BE58",model end
    if first_two_words == "Baron G58"             then return "BE58",model end
    if first_two_words == "Bonanza G36"           then return "BE36",model end
    if first_two_words == "Cessna 208B"           then return "C208",model end
    if first_two_words == "Cessna Grand"          then return "C208",model end
    if first_word      == "DA62"                  then return "DA62",model end
    if first_two_words == "DA 62"                 then return "DA62",model end
    if first_word      == "SR22T"                 then return "S22T",model end
    if first_two_words == "SR 22"                 then return "S22T",model end
    
    -- GNS 530
    model = "GNS530"
    if first_two_words == "Bell 407"              then return "Bell 407",model end
    if first_two_words == "Blackbird Simulations" then return "DHC2",model end -- DHC-2, Beaver
    if first_two_words == "Hercules H-4"          then return "H4",model end
    
    -- GNS 430
    model = "GNS430"
    if first_two_words == "Mudry Cap"             then return "CP10",model end
    if first_word      == "DV20"                  then return "DV20",model end
    if first_two_words == "DV 20"                 then return "DV20",model end
    
    -- MFD 9070
    model = "LX9070"
    if first_two_words == "Asobo DG1001E"         then return "DGF",model end

    -- I haven't decided if I want to map the GDU370, or the GNS; GNS is low hanging fruit for now.
    model = "GNS430"
    if first_word      == "Pipistrel"             then return "PIVI",model end
    if first_two_words == "Extra 330"             then return "E300",model end

    -- The rest of the aircraft have either touch input or minimal instruments
    model = nil
    if first_two_words == "Airbus A320"           then return "A320",model end
    if first_two_words == "A320neo"               then return "A20N",model end
    if first_two_words == "Boeing 747-8i"         then return "B748",model end
    if first_two_words == "Boeing 787-10"         then return "B78X",model end
    if first_word      == "B787"                  then return "B78X",model end
    if first_word      == "C152"                  then return "C152",model end
    if first_two_words == "Cessna CJ4"            then return "C25C",model end
    if first_two_words == "Experimental Darkstar" then return "Darkstar",model end
    if first_two_words == "DR400 Robin"           then return "DR40",model end
    if first_word      == "F18"                   then return "FA18E",model end
    if first_word      == "FlightDesignCT"        then return "FDCT",model end
    if first_two_words == "Flight Design"         then return "FDCT",model end
    if first_two_words == "Icon A5"               then return "A5",model end
    if first_two_words == "Beechcraft King"       then return "B350",model end
    if first_two_words == "Cessna Longitude"      then return "C700",model end
    if first_two_words == "Asobo LS8"             then return "MXS",model end
    if first_two_words == "Asobot NXCub"          then return "CC19",model end
    if first_two_words == "Asobo XCub"            then return "CC19",model end
    if first_word      == "XCub"                  then return "CC19",model end
    if first_word      == "Pitts"                 then return "PTS2",model end
    if first_two_words == "Orbis Asobo"           then return "Orbis",model end
    if first_two_words == "Asobo Savage"          then return "SAVG",model end
    if first_word      == "Savage"                then return "SAVG",model end
    if first_two_words == "Savage Shock"          then return "Cub",model end
    if first_two_words == "TBM 930"               then return "TBM9",model end
    if first_word      == "VL3"                   then return "VL3",model end
    if first_two_words == "Douglas DC-3"          then return "DC3",model end
    if first_two_words == "Grumman Goose"         then return "G21A",model end
    if first_two_words == "Curtiss JN-4D"         then return "JN4D",model end
    if first_two_words == "Spirit Of"             then return "Spirit",model end
    if first_word      == "Velocity"              then return "VELO",model end
    if first_two_words == "Asobo Cabri"           then return "Cabri",model end
    if first_word      == "Wright"                then return "Wright",model end
end

function mgr.add_mappings(aircraft,device_mgr)
    make,model = get_make_model(aircraft)
    if model ~= nil then
        device_mgr.add_mappings(model,F710)
    end
    if make == "Darkstar" then
        device_mgr.add_mappings(make,Yoke)
    end
end

return mgr