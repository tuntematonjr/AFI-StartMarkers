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
 * ["something", player] call afi_startmarkers_fnc_imanexample
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"



params ["_value", "_target", "_variable"];

switch (_variable) do {
	case "squad": {
		leader _target setVariable [QGVAR(enable_marker), _value, true];
	};

	case VALUE: {
		/* STATEMENT */
	};

	case VALUE: {
		/* STATEMENT */
	};

	default
	{
		/* STATEMENT */
	};
};


leader _target getVariable QGVAR(enable_marker)

isNil { leader _target getVariable "afi_startmarkers_vehilce_side"}

if (_value && isNil {leader _this getVariable 'afi_startmarkers_enable_marker'}) then { leader _this setVariable ['afi_startmarkers_enable_marker', _value, true]; };

