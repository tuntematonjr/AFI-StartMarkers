﻿/*
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
 * ["something", player] call Tun_startmarkers_fnc_vehicleData
 * Public: [Yes/No]
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