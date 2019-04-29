#include "script_component.hpp"

if !(GVAR(enabled)) exitWith { };

if (hasInterface) then {
	[] call FUNC(init);
};


//update display idc
[{time > 0}, {

	[] call FUNC(DeleteVehicleMarkers);

    [{
    	GVAR(display) = 12;
    }, [], 2] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_waitUntilAndExecute;
