/*
 * Author: [Tuntematon]
 * [Description]
 * Start script for clients
 * Arguments:
 * None
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [] call afi_startmarkers_fnc_init_client
 *
 * Public: [No]
 */
#include "script_component.hpp"


[] call FUNC(diaryEntry);



[{!(GVAR(hold_script))}, {
	if (time > 0) then {
		[] call FUNC(createVehicleMarkersJIP);
		[] call FUNC(createSquadMarkersJIP);

	} else {
		[{ GVAR(vehicledata_done) }, {
		    [] call FUNC(createVehicleMarkers);
		}] call CBA_fnc_waitUntilAndExecute;
		[] call FUNC(createSquadMarkers);
	};
}] call CBA_fnc_waitUntilAndExecute;
