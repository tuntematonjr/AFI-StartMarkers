/*
 * Author: [Tuntematon]
 * [Description]
 * Save squad data
 * Arguments:
 * 0: None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_startmarkers_fnc_squadData
 * Public: [Yes]
 */
#include "script_component.hpp"

{
    _group = _x;
    _leader = leader _x;
    //_group_side = side _group;
    _group_icon = [_group] call FUNC(squadIcon);
    _position = getPos leader _group;
    //_text = groupId _group;
    //_color = [_group_side,  true] call BIS_fnc_sideColor;

    _isAiSquad = (GVAR(show_ai) && { count ((units _group) select { _x in _allplayers }) == 0 });

    _leader setVariable [QGVAR(marker_data),[_position, _group_icon, _isAiSquad], true]

} forEach allGroups;
