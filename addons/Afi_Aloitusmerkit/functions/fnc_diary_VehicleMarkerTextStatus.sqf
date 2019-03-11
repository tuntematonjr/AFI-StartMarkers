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
 * ["something", player] call afi_startmarkers_fnc_diary_VehicleMarkerTextStatus
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"
params ["_status"];
if (str GVAR(vehicle_marker_text_status) == str _status) exitWith {};

GVAR(vehicle_marker_text_status) = _status;


if (GVAR(BFT)) then {
	 /* Your code */
} else {
	if (time == 0) then {
		[] call FUNC(createVehicleMarkers)
	} else {
		[] call FUNC(createVehicleMarkersJIP)
	};
};