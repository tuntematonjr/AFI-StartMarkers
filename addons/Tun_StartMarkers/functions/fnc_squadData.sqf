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
 * [] call Tun_startmarkers_fnc_squadData
 * Public: [Yes/No]
 */
#include "script_component.hpp"

{
    _group = _x;
    _group_side = side _group;
    _group_icon = [_group] call FUNC(squadIcon);
    _position = getPos leader _group;
    _text = groupId _group;
    _color = [_group_side,  true] call BIS_fnc_sideColor;

    _group setVariable [QGVAR(marker_data),[_position, _group_icon], true]

} forEach allGroups;
