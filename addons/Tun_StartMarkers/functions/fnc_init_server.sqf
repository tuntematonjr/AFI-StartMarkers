/*
 * Author: [Tuntematon]
 * [Description]
 * Init
 * Arguments:
 * None
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_startmarkers_fnc_init_server
 *
 * Public: [No]
 */
#include "script_component.hpp"



[{!(GVAR(hold_script))}, {
	[] call FUNC(squadData);
	[] call FUNC(vehicleData);
}] call CBA_fnc_waitUntilAndExecute;