#include "script_component.hpp"
#undef PREP
#define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction


if (hasInterface) then {
    PREP(SquadMarkers);
    PREP(init);
    PREP(VehicleData);
    PREP(VehicleMarkers);
    PREP(DeleteVehicleMarkers);

    GVAR(VEHICLE_Markers) = [];
    GVAR(INF_Markers) = [];
    GVAR(display) = 53;
    GVAR(vehicle_marker_text_status) = true;
};


["AllVehicles", "GetIn", {
    params ["_vehicle", "_role", "_unit", "_turret"];
    if !(isNil {_vehicle getVariable "Tun_startmarkers_vehilce_side"} || GVAR(add_allunits)) exitWith {};

    _vehicle setVariable ["Tun_startmarkers_vehilce_side", side _unit, true];
}] call CBA_fnc_addClassEventHandler;

[
    QGVAR(enabled), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Blue Force Tracking", "Enable BFT"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun - Startposition markers & BFT","BFT"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(add_allunits), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Add all units", "Add all squads and vehicles. Even if created after mission start. If vehicle side is not defined. First unit who get in vehicle will specify it. This will delete squad marker if in vehicle so it dont clutter map too much."], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun - Startposition markers & BFT","BFT"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(update_interval), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["BFT update interval (seconds)", "Time between updates"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun - Startposition markers & BFT","BFT"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 60, 5, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(show_unmanned), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Show if vehicle is Unmanned", "Adds vehicle name if it is Unmanned"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun - Startposition markers & BFT","BFT"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(show_vehicle_groupid), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Show vehicle crew groupid", "Adds vehicle name its crew group id"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun - Startposition markers & BFT","BFT"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(show_ai), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Add tag if vehicle crew or squad is AI", "Add tag for squad where is only AI units and vehicles which crew is only AI. Overides group id for ai units in vehicles"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["Tun - Startposition markers & BFT","BFT"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

