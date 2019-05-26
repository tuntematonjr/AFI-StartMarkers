/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: status <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true] call Tun_startmarkers_fnc_diary_VehicleMarkerStatus
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"
params ["_status"];
if (str GVAR(vehicle_marker_status) == str _status) exitWith {};

GVAR(vehicle_marker_status) = _status;

if (_status) then {
	if (time == 0) then {
		[] call FUNC(createVehicleMarkers)
	} else {
		[] call FUNC(createVehicleMarkersJIP)
	};
} else {
	{
		(findDisplay GVAR(display)) displayCtrl 51 ctrlRemoveEventHandler ["Draw", _x];
	} forEach GVAR(VEHICLE_Markers);
	GVAR(VEHICLE_Markers) = [];
};