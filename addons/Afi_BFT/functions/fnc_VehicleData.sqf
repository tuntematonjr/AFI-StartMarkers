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
 * ["something", player] call afi_bft_fnc_VehicleData
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"


params ["_vehicle"];

if ((_vehicle getVariable ["AFI_vehicle_gear",""] == "") && _vehicle getVariable ["afi_startmarkers_vehilce_side",sideLogic] == sideLogic && _vehicle getVariable [QGVAR(afi_bft_disabled_unit), false] && count (crew _vehicle) == 0) exitWith { };

_position = getpos _vehicle;
_direction = getDir _vehicle;

if !(_vehicle getVariable ["AFI_vehicle_gear",""] == "") then {
	///check that is importat type
	if (_vehicle isKindof "LandVehicle" || _vehicle isKindOf "Static" || _vehicle isKindOf "thing" || _vehicle isKindof "Air" || _vehicle isKindOf "Ship" ) then {
	    _sideSTR = _vehicle getVariable "AFI_vehicle_gear";
	    switch (toLower _sideSTR) do {
	        case "west": {
	        	_vehicle setVariable ["afi_startmarkers_vehilce_side", west];
	        };

	        case "east": {
	        	_vehicle setVariable ["afi_startmarkers_vehilce_side", east];
	        };

	        case "guer": {
	        	_vehicle setVariable ["afi_startmarkers_vehilce_side", resistance];
	        };

	        case "civ": {
	        	_vehicle setVariable ["afi_startmarkers_vehilce_side", civilian];
	        };

	        default {

	        };
	    };
	};
};


//Add vehicles mid mission without mission atributes.
if (_vehicle getVariable ["afi_startmarkers_vehilce_side",sideLogic] == sideLogic && count (crew _vehicle) > 0) then {
	if (_vehicle isKindof "LandVehicle" || _vehicle isKindOf "Static" || _vehicle isKindOf "thing" || _vehicle isKindof "Air" || _vehicle isKindOf "Ship" ) then {
		_vehicle setVariable ["afi_startmarkers_vehilce_side", side (crew _vehicle select 0)];
	};
};