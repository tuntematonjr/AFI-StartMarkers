#include "script_component.hpp"

_untrimmed = GVAR(CommandElementID) splitString ",";
GVAR(HQelement) = [];
{
    GVAR(HQelement) pushBackUnique ([_x] call CBA_fnc_trim);
} forEach _untrimmed;


//Do not run this if runing BFT
if (Afi_BFT_enabled) exitWith { };

ISNILS(GVAR(disable),false);
if (GVAR(disable)) exitwith {};

if (isServer) then {
	[] call FUNC(init_server);
};

if (hasInterface) then {
	[{ !isNull player }, {
		[] call FUNC(init_client);
		player addEventHandler ["killed",{ [false] call FUNC(diary_AllMarkerStatus); }];
	}] call CBA_fnc_waitUntilAndExecute;
};



[{time > 0}, {

    if (GVAR(vehicle_marker_status)) then {
        [false] call FUNC(diary_VehicleMarkerStatus);
    };
    [{
    	GVAR(display) = 12;
        [true] call FUNC(diary_VehicleMarkerStatus);
    }, [], 2] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_waitUntilAndExecute;


[{time > 60*(["afi_safeStart_duration", GVAR(prep_time) ]call BIS_fnc_getParamValue) + 30}, { [false] call FUNC(diary_AllMarkerStatus) }] call CBA_fnc_waitUntilAndExecute;

