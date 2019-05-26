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
 * ["something", player] call Tun_bft_fnc_DeleteVehicleMarkers
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"

if (count GVAR(VEHICLE_Markers) > 0) then {
    {
        (findDisplay GVAR(display)) displayCtrl 51 ctrlRemoveEventHandler ["Draw", _x];
    } forEach GVAR(VEHICLE_Markers);
    GVAR(VEHICLE_Markers) = [];
};