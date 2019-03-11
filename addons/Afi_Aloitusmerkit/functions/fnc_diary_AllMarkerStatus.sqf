/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: status <BOOL>
 *
 * Return Value:
 * nothing
 *
 * Example:
 * [true] call afi_startmarkers_fnc_diary_AllMarkerStatus
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"
params ["_status"];


if (_status) then {
	if !(GVAR(group_marker_status)) then { [true] call FUNC(diary_GroupMarkerStatus) };
	if !(GVAR(vehicle_marker_status)) then { [true] call FUNC(diary_VehicleMarkerStatus) };
} else {
	if (GVAR(group_marker_status)) then { [false] call FUNC(diary_GroupMarkerStatus) };
	if (GVAR(vehicle_marker_status)) then { [false] call FUNC(diary_VehicleMarkerStatus) };
};