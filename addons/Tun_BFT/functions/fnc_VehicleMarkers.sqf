/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * []  call tun_bft_VehicleMarkers
 *
 * Public: [No]
 */
#include "script_component.hpp"



private _vehiclesToCreateMarkers = [];

//Delete old markers
[] call FUNC(DeleteVehicleMarkers);


//Collect vehicles
{
    private _vehicle = _x;
    private _side = _vehicle getVariable ["Tun_startmarkers_vehilce_side", sideLogic];

    ///check that side is defined
    if ( _side != sideLogic && { !(_vehicle getVariable [QGVAR(Tun_bft_disabled_unit), false]) }) then {

        ///Show allied vehicles if needed
        if (Tun_startmarkers_showFriendlyMarkers && {playerSide != civilian}) then {
            if ([_side, playerSide] call BIS_fnc_sideIsFriendly) then {
               _vehiclesToCreateMarkers pushBack _vehicle;
            };
        } else {
            if (playerSide == _side && { !(_vehicle getVariable [QGVAR(Tun_bft_disabled_unit), false]) } ) then {
                _vehiclesToCreateMarkers pushBack _vehicle;
            };
        };
    };
} forEach vehicles;



{
    private _vehicle = _x;
    private _position = getPos _vehicle;
    private _direction = getDir _vehicle;
    private _classname = typeOf _vehicle;
    private _text = str " ";

    private _side = _vehicle getVariable "Tun_startmarkers_vehilce_side";
    private _color = [_side, false] call BIS_fnc_sideColor;

    if (GVAR(vehicle_marker_text_status)) then {
        _crewtype = if (GVAR(show_unmanned) && { !(_vehicle isKindOf "thing") } ) then { " (Unmanned)" } else { " " };

        if ( count crew _vehicle > 0 && { GVAR(show_vehicle_groupid) }) then {
            _crewtype = format [" (%1)", groupId (group (crew _vehicle select 0))];
        };

        if ( count crew _vehicle > 0 && {count (crew _vehicle select {_x in allPlayers}) == 0} && { GVAR(show_ai) } ) then {
            _crewtype = " (AI)";
        };

        _text = str format ["%1%2", (_vehicle getVariable ["displayName", getText (configFile >> "CfgVehicles" >>  typeOf _vehicle >> "displayName")]), _crewtype];
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
