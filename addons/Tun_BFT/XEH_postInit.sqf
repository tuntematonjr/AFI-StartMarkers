#include "script_component.hpp"

diag_log "Bfore Exit from TUN BFT";
[{ !isNil QGVAR(enabled) },{

	if (!(GVAR(enabled) )|| (isServer && isDedicated)) exitWith { diag_log "Exit from TUN BFT"};

	diag_log "After exit TUN BFT";
	[] call FUNC(init);


	//update display idc
	[{time > 0}, {

		[] call FUNC(DeleteVehicleMarkers);

	    [{
	    	GVAR(display) = 12;
	    }, [], 2] call CBA_fnc_waitAndExecute;
	}] call CBA_fnc_waitUntilAndExecute;

}] call CBA_fnc_waitUntilAndExecute;