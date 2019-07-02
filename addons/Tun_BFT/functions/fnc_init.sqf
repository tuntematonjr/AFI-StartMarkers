/*
 * Author: [Tuntematon]
 * [Description]
 * init stuff
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_bft_fnc_init
 *
 * Public: [No]
 */
#include "script_component.hpp"



[{
	if ("ItemGPS" in assignedItems player || "ACE_microDAGR" in items player || player getVariable ["Tun_BFT_Always_On", false]) then {
		[] call FUNC(SquadMarkers);
		[] call FUNC(VehicleMarkers);
	};
}, GVAR(update_interval)] call CBA_fnc_addPerFrameHandler;




