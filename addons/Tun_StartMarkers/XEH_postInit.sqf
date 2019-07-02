#include "script_component.hpp"

//Make sure all important variables are defined
[{ !isNil QGVAR(CommandElementID) && !isNil QGVAR(disable) && !isNil QGVAR(display) && !isNil "Tun_BFT_enabled" },{


    _untrimmed = GVAR(CommandElementID) splitString ",";
    GVAR(HQelement) = [];
    {
        GVAR(HQelement) pushBackUnique ([_x] call CBA_fnc_trim);
    } forEach _untrimmed;

    //Do not run this if runing BFT
    if (Tun_BFT_enabled) exitWith { };


    if (GVAR(disable)) exitwith {};

    if (isServer) then {
    	[] call FUNC(init_server);
    };


    //Only client stuff
    if (hasInterface) then {
    	[{ !isNull player && (!isNull findDisplay GVAR(display))}, {
    		[] call FUNC(init_client);
    		player addEventHandler ["killed",{ [false] call FUNC(diary_AllMarkerStatus); }];
    	}] call CBA_fnc_waitUntilAndExecute;

        [{time > 0}, {

            if (GVAR(vehicle_marker_status)) then {
                [false] call FUNC(diary_VehicleMarkerStatus);
            };
            [{
            	GVAR(display) = 12;
                [true] call FUNC(diary_VehicleMarkerStatus);
            }, [], 2] call CBA_fnc_waitAndExecute;
        }] call CBA_fnc_waitUntilAndExecute;

        [{time > 60*(["Afi_safeStart_duration", GVAR(prep_time) ]call BIS_fnc_getParamValue) }, { [false] call FUNC(diary_AllMarkerStatus) }] call CBA_fnc_waitUntilAndExecute;
    };

}] call CBA_fnc_waitUntilAndExecute;
