/*
 * Author: [Tuntematon]
 * [Description]
 * Create squad markers
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * []  call Tun_startmarkers_fnc_createSquadMarkersBFT
 *
 * Public: [No]
 */
#include "script_component.hpp"

//if !(GVAR(group_marker_status)) exitWith { };


private _groupsToCreateMarkers = [];
private _allplayers = [switchableUnits, playableUnits] select isMultiplayer;

//Delete old markers
{
	_x params ["_marker_name", ["_time", 0]];
	if ((_time + 60) < time) then {
		_marker_name setMarkerAlphaLocal 0.5;
	};
} forEach GVAR(INF_Markers);
//GVAR(INF_Markers) = [];


if (Tun_startmarkers_showFriendlyMarkers && {playerSide != civilian}) then {

	_groupsToCreateMarkers = allGroups select { [side _x, playerSide] call BIS_fnc_sideIsFriendly && { (side _x != civilian) }  && { ("ItemGPS" in assignedItems leader _x || "ACE_microDAGR" in items leader _x) } && { !((leader _x) getVariable [QGVAR(disabled_unit), false]) } && { leader _x getVariable ["AFI_Aloitusmerkit_Ryhmamerkki", true] } };
} else {

	_groupsToCreateMarkers = allGroups select { side _x == playerSide  && { ("ItemGPS" in assignedItems leader _x || "ACE_microDAGR" in items leader _x) } && { !((leader _x) getVariable [QGVAR(disabled_unit), false]) } && { leader _x getVariable ["AFI_Aloitusmerkit_Ryhmamerkki", true] } };
};



//Update BFT markers
{
	private _group = _x;
	if ( vehicle leader _group == leader _group || !(GVAR(show_vehicle_groupid)) || !(GVAR(add_allunits))) then {
		_group_side = side _group;
		_group_icon = [_group] call Tun_startmarkers_fnc_squadIcon;
		_position = getPos leader _group;
		_text = groupId _group;
		_color = [_group_side,  true] call BIS_fnc_sideColor;

		_marker_name = format ["%1_%2",QGVAR(inf), _group];
		//Make room for new marker
		deleteMarkerLocal _marker_name;
		REM(GVAR(INF_Markers),_marker_name);
		GVAR(INF_Markers) pushBack [_marker_name, time];

		//Add Ai tag if no playable slots and system is enabled
		if (GVAR(show_ai) && { count ((units _group) select { _x in _allplayers }) == 0 }) then {
			_text = format ["%1 (AI)", _text]
		};

		_merk = createMarkerLocal [_marker_name, _position];
		_merk setMarkerShapeLocal "ICON";
		_merk setMarkerTypeLocal _group_icon;
		_merk setMarkerSizeLocal [0.7,0.7];
		_merk setMarkerColorLocal _color;
		_merk setMarkerTextLocal _text;
		//_merk setMarkerAlphaLocal GVAR(marker_alpha);
	} else {
		_marker_name = format ["%1_%2",QGVAR(inf), _group];
		if (getMarkerColor _marker_name != "") then {
			deleteMarkerLocal _marker_name;
			REM(GVAR(INF_Markers),_marker_name);
		};
	};

} forEach _groupsToCreateMarkers;


