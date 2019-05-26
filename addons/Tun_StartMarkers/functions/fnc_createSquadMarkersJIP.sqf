/*
 * Author: [Tuntematon]
 * [Description]
 * Create markers for JIP
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call afi_startmarkers_fnc_createSquadMarkersJIP
 *
 * Public: [No]
 */
#include "script_component.hpp"


private _groupsToCreateMarkers = [];


if (GVAR(showFriendlyMarkers) && {playerSide != civilian}) then {
	_groupsToCreateMarkers = allGroups select {[side _x, playerSide] call BIS_fnc_sideIsFriendly && {(side _x != civilian)} && {count (_x getVariable QGVAR(marker_data)) > 0} && { _x getVariable [QGVAR(enable_marker), true] } };
} else {
	_groupsToCreateMarkers = allGroups select { side _x == playerSide && { count (_x getVariable QGVAR(marker_data)) > 0} && { _x getVariable [QGVAR(enable_marker), true] } };
};

{
	_group = _x;
	_data = _group getVariable QGVAR(marker_data);
	_group_side = side _group;
	_group_icon =  _data select 1;
	_position = _data select 0;
	_text = groupId _group;
	_side = side leader _group;
	_color = [_side,  true] call BIS_fnc_sideColor;

	_marker_name =  format ["%1_%2",QGVAR(inf), _group];
	GVAR(INF_Markers) pushBack _marker_name;

	_merk = createMarkerLocal [_marker_name, _position];
	_merk setMarkerShapeLocal "ICON";
	_merk setMarkerTypeLocal _group_icon;
	_merk setMarkerSizeLocal [0.7,0.7];
	_merk setMarkerColorLocal _color;
	_merk setMarkerTextLocal _text;

} forEach _groupsToCreateMarkers;




