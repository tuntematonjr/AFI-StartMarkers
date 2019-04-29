/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: The first argument <STRING>
 * 1: The second argument <OBJECT>
 * 2: Multiple input types <STRING|ARRAY|CODE>
 * 3: Optional input <BOOL> (default: true)
 * 4: Optional input with multiple types <CODE|STRING> (default: {true})
 * 5: Not mandatory input <STRING> (default: nil)
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["something", player] call afi_bft_fnc_init
 *
 * Public: [No]
 */
#include "script_component.hpp"



[{
	if ("ItemGPS" in assignedItems player || "ACE_microDAGR" in items player || player getVariable ["Afi_BFT_Always_On", false]) then {
		[] call FUNC(SquadMarkers);
		[] call FUNC(VehicleMarkers);
	};
}, GVAR(update_interval)] call CBA_fnc_addPerFrameHandler;




