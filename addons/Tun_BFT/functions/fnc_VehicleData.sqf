/*
 * Author: [Tuntematon]
 * [Description]
 * Save vehicle data
 * Arguments:
 * 0: Target vehicle/object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["vehicle"] call Tun_bft_fnc_VehicleData
 *
 * Public: [No]
 */
#include "script_component.hpp"


params ["_vehicle"];

if ((_vehicle getVariable ["afi_vehicle_gear",""] == "") && _vehicle getVariable ["Tun_startmarkers_vehilce_side",sideLogic] == sideLogic && _vehicle getVariable [QGVAR(Tun_bft_disabled_unit), false] && count (crew _vehicle) == 0) exitWith { };

_position = getpos _vehicle;
_direction = getDir _vehicle;

if !(_vehicle getVariable ["Tun_vehicle_gear",""] == "") then {
	///check that is importat type
	if (_vehicle isKindof "LandVehicle" || _vehicle isKindOf "Static" || _vehicle isKindOf "thing" || _vehicle isKindof "Air" || _vehicle isKindOf "Ship" ) then {
	    _sideSTR = _vehicle getVariable "Tun_vehicle_gear";
	    switch (toLower _sideSTR) do {
	        case "west": {
	        	_vehicle setVariable ["Tun_startmarkers_vehilce_side", west];
	        };

	        case "east": {
	        	_vehicle setVariable ["Tun_startmarkers_vehilce_side", east];
	        };

	        case "guer": {
	        	_vehicle setVariable ["Tun_startmarkers_vehilce_side", resistance];
	        };

	        case "civ": {
	        	_vehicle setVariable ["Tun_startmarkers_vehilce_side", civilian];
	        };

	        default {

	        };
	    };
	};
};


//Add vehicles mid mission without mission atributes.
if (_vehicle getVariable ["Tun_startmarkers_vehilce_side",sideLogic] == sideLogic && count (crew _vehicle) > 0) then {
	if (_vehicle isKindof "LandVehicle" || _vehicle isKindOf "Static" || _vehicle isKindOf "thing" || _vehicle isKindof "Air" || _vehicle isKindOf "Ship" ) then {
		_vehicle setVariable ["Tun_startmarkers_vehilce_side", side (crew _vehicle select 0)];
	};
};