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
 * ["something", player] call afi_startmarkers_fnc_BFT
 *
 * Public: [No]
 */
#include "script_component.hpp"



[{
	if ("ItemGPS" in assignedItems player || "ACE_microDAGR" in items player) then {
		[_handle] call CBA_fnc_removePerFrameHandler;
		GVAR(marker_alpha) = 1;
		[] call FUNC(createSquadMarkers);
		[] call FUNC(createVehicleMarkers);

		//update marker data
		[] call FUNC(createVehicleMarkers);
		[] call FUNC(createVehicleMarkers);
	} else {
		GVAR(marker_alpha) = 0.5;
	};


}, GVAR(BFT_update_interval)] call CBA_fnc_addPerFrameHandler;




