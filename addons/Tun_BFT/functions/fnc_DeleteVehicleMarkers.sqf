/*
 * Author: [Tuntematon]
 * [Description]
 * Remove vehicle markers
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * ["something", player] call Tun_bft_fnc_DeleteVehicleMarkers
 *
 * Public: [No]
 */
#include "script_component.hpp"

if (count GVAR(VEHICLE_Markers) > 0) then {
    {
        (findDisplay GVAR(display)) displayCtrl 51 ctrlRemoveEventHandler ["Draw", _x];
    } forEach GVAR(VEHICLE_Markers);
    GVAR(VEHICLE_Markers) = [];
};