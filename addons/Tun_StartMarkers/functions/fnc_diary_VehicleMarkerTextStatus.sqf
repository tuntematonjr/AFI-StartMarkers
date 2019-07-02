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
 * ["something", player] call Tun_startmarkers_fnc_diary_VehicleMarkerTextStatus
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"
params [["_status",false]];
if (str GVAR(vehicle_marker_text_status) == str _status) exitWith {};

GVAR(vehicle_marker_text_status) = _status;

if (time == 0) then {
	[true] call FUNC(createVehicleMarkers)
} else {
	[true] call FUNC(createVehicleMarkersJIP)
};