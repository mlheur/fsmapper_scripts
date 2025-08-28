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
    if first_two_words == "Asobo Baron"           then return "Baron",model end
    if first_two_words == "Baron G58"             then return "Baron",model end
    if first_two_words == "Bonanza G36"           then return "Bonanza",model end
    if first_two_words == "Cessna 208B"           then return "GrandCaravan",model end
    if first_two_words == "Cessna Grand"          then return "GrandCaravan",model end
    if first_word      == "DA40-NG"               then return "DA40",model end
    if first_word      == "DA62"                  then return "DA62",model end
    if first_two_words == "DA 62"                 then return "DA62",model end
    if first_word      == "SR22T"                 then return "SR22",model end
    if first_two_words == "SR 22"                 then return "SR22",model end
    
    -- GNS 530
    model = "GNS530"
    if first_two_words == "Bell 407"              then return "Bell407",model end
    if first_two_words == "Blackbird Simulations" then return "Beaver",model end -- DHC-2, Beaver
    if first_two_words == "Hercules H-4"          then return "H4",model end
    
    -- GNS 430
    model = "GNS430"
    if first_two_words == "Mudry Cap"             then return "CAP10",model end
    if first_word      == "DV20"                  then return "DV20",model end
    if first_two_words == "DV 20"                 then return "DV20",model end
    
    -- MFD 9070
    model = "LX9070"
    if first_two_words == "Asobo DG1001E"         then return "Glider",model end

    -- I haven't decided if I want to map the GDU370, or the GNS; GNS is low hanging fruit for now.
    model = "GNS430"
    if first_word      == "Pipistrel"             then return "DV20",model end
    if first_two_words == "Extra 330"             then return "E330",model end

    -- The rest of the aircraft have either touch input or minimal instruments
    model = nil
    if first_two_words == "Airbus A320"           then return "A320",model end
    if first_two_words == "A320neo"               then return "A320neo",model end
    if first_two_words == "Boeing 787-10"         then return "B787",model end
    if first_word      == "B787"                  then return "B787",model end
    if first_word      == "C152"                  then return "C152",model end
    if first_two_words == "Cessna CJ4"            then return "CJ4",model end
    if first_two_words == "Experimental Darkstar" then return "Darkstar",model end
    if first_two_words == "DR400 Robin"           then return "DR400",model end
    if first_word      == "F18"                   then return "F18",model end
    if first_word      == "FlightDesignCT"        then return "CTSL",model end
    if first_two_words == "Flight Design"         then return "CTSL",model end
    if first_two_words == "Icon A5"               then return "A5",model end
    if first_two_words == "Beechcraft King"       then return "B350",model end
    if first_two_words == "Cessna Longitude"      then return "C700",model end
    if first_two_words == "Asobo LS8"             then return "LS8",model end
    if first_two_words == "Asobot NXCub"          then return "NXCub",model end
    if first_word      == "Pitts"                 then return "Pitts",model end
    if first_two_words == "Asobo Savage"          then return "Savage",model end
    if first_word      == "Savage"                then return "Savage",model end
    if first_two_words == "Savage Shock"          then return "Cub",model end
    if first_two_words == "TBM 930"               then return "F18",model end
    if first_word      == "VL3"                   then return "F18",model end
    if first_two_words == "Asobo XCub"            then return "XCub",model end
    if first_word      == "XCub"                  then return "XCub",model end
    if first_two_words == "Douglas DC-3"          then return "DC3",model end
    if first_two_words == "Grumman Goose"         then return "Goose",model end
    if first_two_words == "Curtiss JN-4D"         then return "JN4D",model end
    if first_two_words == "Spirit Of"             then return "Spirit",model end
    if first_word      == "Velocity"              then return "VELO",model end
end

function mgr.add_mappings(aircraft,device_mgr)
    make,model = get_make_model(aircraft)
    if model ~= nil then
        device_mgr.add_mappings(model,F710)
    end
end

return mgr