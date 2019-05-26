#include "script_component.hpp"
#undef PREP
#define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction


//[] call COMPILE_FILE(merkit_preinit);
//FUNC(killJIP) = compile preprocessFileLineNumbers "functions\fnc_killJIP.sqf";

PREP(createSquadMarkers);
PREP(createSquadMarkersJIP);
PREP(createVehicleMarkers);
PREP(createVehicleMarkersJIP);
PREP(init_client);
PREP(init_server);
PREP(squadData);
PREP(squadIcon);
PREP(diaryEntry);
PREP(vehicleData);
PREP(diary_AllMarkerStatus);
PREP(diary_VehicleMarkerTextStatus);
PREP(diary_GroupMarkerStatus);
PREP(diary_VehicleMarkerStatus);



//Set variables base values

GVAR(showFriendlyMarkers) = true;
GVAR(INF_Markers) = [];
GVAR(VEHICLE_Markers) = [];
GVAR(display) = 53;
GVAR(vehicledata_done) = false;
GVAR(hold_script) = false;
GVAR(marker_alpha) = 1;

GVAR(group_marker_status) = true;
GVAR(vehicle_marker_status) = true;
GVAR(vehicle_marker_text_status) = true;


[
    QGVAR(CommandElementID), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Command element identification", "Command element identification. If multiple styles, seperate using commas (ie. all groups what have '10' in their group id is HQ element"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun-Start Pos Markers", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "10", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(showFriendlyMarkers), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Show allied sides", "Show allied groups. ie. if blufor is allied to resistance, all resistance markers are shown too"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun-Start Pos Markers", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(disable), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Disable Start Position Markers", "Disable creating starting position markers"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun-Start Pos Markers", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(prep_time), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Preparation time (minutes)", "After this time is passed. All markers are auto hidden. Can be still shown using briefing screen buttons. Tun safestart time is prioritized!"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun-Start Pos Markers", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 60, 15, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(diary_info_text), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Create info diary record", "Create diary record that make people notice this addon"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun-Start Pos Markers", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(diary_language_text), // Unique setting name. Matches resulting variable name <STRING>
    "LIST", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Create info diary record", "Create diary record that make people notice this addon"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "Tun-Start Pos Markers", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [["fin", "eng", "swe"], ["finnish", "english", "sweden"], 1], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;
