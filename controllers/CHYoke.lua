local hController = {}

hController.tTombstone = {
    name = "CHYoke",
    type = "dinput",
    identifier = {
        guid = '{1DDD4F20-8387-11ED-8001-444553540000}'
    },
}

-- X & Y axes are the yoke/stick for roll & pitch
-- Z axis is the barrel-shaped throttle lever
-- RY axis is the squarish crown-shaped prop lever
-- RX axis is the round spikey mixture lever


--$ awk '{for (i=1;i<=NF;i++){if($i=="return"){print $(i+1)}}}' planes.lua | awk -F, '{print $1}' | sort -u | grep -v '^mgr$' | xargs echo
--A20N A320 A5 B350 B748 B78X BE36 BE58 B407 C152 C172 C208 C25C C700 Cabri CC19 CP10 Cub DA40 DA62 Darkstar DC3 DGF DHC2 DR40 DV20 E300 FA18E FDCT G21A H4 JN4D MXS Orbis PC6 PIVI PTS2 S22T SAVG Spirit TBM9 VELO VL3 Wright

-- The only default actions for this controller are pitch and roll, managed by the in-game
-- controller settings.

function hController.applyDefaultActions(tEventActionMap,hAircraft,tEventIDs)
    if hAircraft then
        if hAircraft.nEngines and tManagers["Action"].ENGINE_Throttle and tManagers["Action"].ENGINE_Throttle[hAircraft.nEngines] then
            tEventActionMap[tEventIDs.z.change] = tManagers["Action"].ENGINE_Throttle[hAircraft.nEngines]
        end
        if hAircraft.nMixture and tManagers["Action"].FUEL_Mixture and tManagers["Action"].FUEL_Mixture[hAircraft.nMixture] then
            tEventActionMap[tEventIDs.rx.change] = tManagers["Action"].FUEL_Mixture[hAircraft.nMixture]
        end
    end
end

return hController