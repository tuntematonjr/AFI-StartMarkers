#include "script_component.hpp"

//Make sure all important variables are defined
[{ !isNil QGVAR(enabled) && !isNil QGVAR(add_allunits) && !isNil QGVAR(update_interval) && !isNil QGVAR(show_unmanned) && !isNil QGVAR(show_vehicle_groupid) && !isNil QGVAR(show_ai) },{

	if (!(GVAR(enabled) )|| (isServer && isDedicated)) exitWith { };

	[] call FUNC(init);


	//update display idc
	[{time > 0}, {

		[] call FUNC(DeleteVehicleMarkers);

	    [{
	    	GVAR(display) = 12;
	    }, [], 2] call CBA_fnc_waitAndExecute;
	}] call CBA_fnc_waitUntilAndExecute;

}] call CBA_fnc_waitUntilAndExecute;