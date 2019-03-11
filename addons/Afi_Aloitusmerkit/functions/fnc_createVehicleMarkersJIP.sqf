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
 * [] call afi_startmarkers_fnc_createVehicleMarkers
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"


private _vehiclesToCreateMarkers = [];

//Delete old markers
if (count GVAR(VEHICLE_Markers) > 0) then {
    {
        (findDisplay GVAR(display)) displayCtrl 51 ctrlRemoveEventHandler ["Draw", _x];
    } forEach GVAR(VEHICLE_Markers);
    GVAR(VEHICLE_Markers) = [];
};



//Collect vehicles
{
    private _vehicle = _x;

    ///check that side is defined
    if ( count (_vehicle getVariable [QGVAR(marker_data),[]]) > 0) then {
        private _side = _vehicle getVariable QGVAR(vehilce_side);

        ///Show allied vehicles if needed
        if (GVAR(showFriendlyMarkers) && {playerSide != civilian} && _side != civilian) then {
            if ([_side, playerSide] call BIS_fnc_sideIsFriendly) then {
               _vehiclesToCreateMarkers pushBack _vehicle;
            };
        } else {
            if (playerSide == _side) then {
                _vehiclesToCreateMarkers pushBack _vehicle;
            };
        };
    };
} forEach vehicles;



{
    private _vehicle = _x;
    private _data = _vehicle getVariable QGVAR(marker_data);
    private _position = _data select 0;
    private _direction = _data select 1;
    private _classname = typeOf _vehicle;
    private _text = str" ";
    private _side = _vehicle getVariable QGVAR(vehilce_side);
    private _color = [_side, false] call BIS_fnc_sideColor;

    if (GVAR(vehicle_marker_text_status)) then {
        _text = str (_vehicle getVariable ["displayName", getText (configFile >> "CfgVehicles" >>  typeOf _vehicle >> "displayName")]);
    };

        _IDC = ((findDisplay GVAR(display)) displayCtrl 51) ctrlAddEventHandler ["Draw", format ['
                (_this select 0) drawIcon [
                getText (configFile >> "CfgVehicles" >> %1 >> "Icon"),
                %2,
                %3,
                30,
                30,
                %4,
                %5,
                2
                ];',
                str _classname,
                _color,
                _position,
                _direction,
                _text
                ]
            ];
     GVAR(VEHICLE_Markers) pushBack _IDC;

} forEach _vehiclesToCreateMarkers;
