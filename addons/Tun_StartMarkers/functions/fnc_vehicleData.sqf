/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_startmarkers_fnc_vehicleData
 * Public: [Yes]
 */
#include "script_component.hpp"


{
	private _vehicle = _x;

	if ((_vehicle getVariable ["afi_vehicle_gear",""] == "") && _vehicle getVariable [QGVAR(vehilce_side),sideLogic] == sideLogic && _vehicle getVariable QGVAR(enable_marker)) exitWith { };

	_position = getpos _vehicle;
	_direction = getDir _vehicle;
	_vehicle setVariable [QGVAR(marker_data), [_position,_direction], true];

	if !(_vehicle getVariable ["Tun_vehicle_gear",""] == "") then {
		///check that is importat type
		if (_vehicle isKindof "LandVehicle" || _vehicle isKindOf "Static" || _vehicle isKindOf "thing" || _vehicle isKindof "Air" || _vehicle isKindOf "Ship" ) then {
		    _sideSTR = _vehicle getVariable "Tun_vehicle_gear";
		    switch (toLower _sideSTR) do {
		        case "west": {
		        	_vehicle setVariable [QGVAR(vehilce_side), west, true];
		        };

		        case "east": {
		        	_vehicle setVariable [QGVAR(vehilce_side), east, true];
		        };

		        case "guer": {
		        	_vehicle setVariable [QGVAR(vehilce_side), resistance, true];
		        };

		        case "civ": {
		        	_vehicle setVariable [QGVAR(vehilce_side), civilian, true];
		        };

		        default {

		        };
		    };
		};
	};
} forEach vehicles;


missionNamespace setVariable [QGVAR(vehicledata_done), true, true];