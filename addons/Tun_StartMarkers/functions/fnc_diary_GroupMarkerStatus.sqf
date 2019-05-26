/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * Arguments:
 * 0: status <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true]  call Tun_startmarkers_fnc_diary_GroupMarkerStatus
 *
 * Public: [No]
 */
#include "script_component.hpp"
params ["_status"];
if (str GVAR(group_marker_status)  == str _status) exitWith {};

GVAR(group_marker_status) = _status;
_value = 0;

if (_status) then {
	_value = 1;
};


{
	_x setMarkerAlphaLocal _value;
} forEach GVAR(INF_Markers);