/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * []  call afi_startmarkers_fnc_createSquadMarkersBFT
 *
 * Public: [No]
 */
#include "script_component.hpp"

//if !(GVAR(group_marker_status)) exitWith { };


private _groupsToCreateMarkers = [];

//Delete old markers
{
	_x params ["_marker_name", ["_time", 0]];
	if ((_time + 60) < time) then {
		_marker_name setMarkerAlphaLocal 0.5;
	};
} forEach GVAR(INF_Markers);
//GVAR(INF_Markers) = [];


if (afi_startmarkers_showFriendlyMarkers && {playerSide != civilian}) then {

	_groupsToCreateMarkers = allGroups select {[side _x, playerSide] call BIS_fnc_sideIsFriendly && {(side _x != civilian)}  && { ("ItemGPS" in assignedItems leader _x || "ACE_microDAGR" in items leader _x) } && { !((leader _x) getVariable [QGVAR(disabled_unit), false]) } };
} else {

	_groupsToCreateMarkers = allGroups select { side _x == playerSide  && { ("ItemGPS" in assignedItems leader _x || "ACE_microDAGR" in items leader _x) } && { !((leader _x) getVariable [QGVAR(disabled_unit), false]) } };
};



//Update BFT markers
{

	_group = _x;
	_group_side = side _group;
	_group_icon = [_group] call afi_startmarkers_fnc_squadIcon;
	_position = getPos leader _group;
	_text = groupId _group;
	_color = [_group_side,  true] call BIS_fnc_sideColor;

	_marker_name =  format ["%1_%2",QGVAR(inf), _group];
	//Make room for new marker
	deleteMarkerLocal _marker_name;
	REM(GVAR(INF_Markers),_marker_name);
	GVAR(INF_Markers) pushBack [_marker_name, time];

	_merk = createMarkerLocal [_marker_name, _position];
	_merk setMarkerShapeLocal "ICON";
	_merk setMarkerTypeLocal _group_icon;
	_merk setMarkerSizeLocal [0.7,0.7];
	_merk setMarkerColorLocal _color;
	_merk setMarkerTextLocal _text;
	//_merk setMarkerAlphaLocal GVAR(marker_alpha);

} forEach _groupsToCreateMarkers;


