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
 * ["something", player] call Tun_startmarkers_fnc_init_server
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"



[{!(GVAR(hold_script))}, {
	[] call FUNC(squadData);
	[] call FUNC(vehicleData);
}] call CBA_fnc_waitUntilAndExecute;