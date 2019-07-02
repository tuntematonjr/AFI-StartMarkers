/*
 * Author: [Tuntematon]
 * [Description]
 * Create Squad markers
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_startmarkers_fnc_createSquadMarkers
 *
 * Public: [No]
 */
#include "script_component.hpp"

//if !(GVAR(group_marker_status)) exitWith { };

private _groupsToCreateMarkers = [];
private _allplayers = [switchableUnits, playableUnits] select isMultiplayer;

if (GVAR(showFriendlyMarkers) && {playerSide != civilian}) then {
	_groupsToCreateMarkers = allGroups select {[side _x, playerSide] call BIS_fnc_sideIsFriendly && { (side _x != civilian) } && {_x getVariable [QGVAR(enable_marker), true]} };
} else {
	_groupsToCreateMarkers = allGroups select {side _x == playerSide && {_x getVariable [QGVAR(enable_marker), true]} };
};

{
	_group = _x;
	_group_side = side _group;
	_group_icon = [_group] call FUNC(squadIcon);
	_position = getPos leader _group;
	_text = groupId _group;
	_side = side leader _group;
	_color = [_side,  true] call BIS_fnc_sideColor;

	_marker_name =  format ["%1_%2",QGVAR(inf), _group];

	//Add Ai tag if no playable slots and system is enabled
	if (GVAR(show_ai) && { count ((units _group) select { _x in _allplayers }) == 0 }) then {
		_text = format ["%1 (AI)", _text]
	};

	GVAR(INF_Markers) pushBack _marker_name;

	_merk = createMarkerLocal [_marker_name, _position];
	_merk setMarkerShapeLocal "ICON";
	_merk setMarkerTypeLocal _group_icon;
	_merk setMarkerSizeLocal [0.7,0.7];
	_merk setMarkerColorLocal _color;
	_merk setMarkerTextLocal _text;

} forEach _groupsToCreateMarkers;