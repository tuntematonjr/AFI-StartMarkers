/*
 * Author: [Tuntematon]
 * [Description]
 * Vehicle marker text status update
 * Arguments:
 * 0: The first argument <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_startmarkers_fnc_diary_VehicleMarkerTextStatus
 *
 * Public: [No]
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