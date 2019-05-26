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
 * ["something", player] call afi_startmarkers_fnc_diaryEntry
 *
 * Public: [No]
 */
#include "script_component.hpp"
private ["_version", "_main_header", "_buttons_header", "_all_markers_on", "_all_markers_off", "_group_markers_on", "_group_markers_off", "_vehicle_markers_on", "_vehicle_markers_off", "_vehicle_markers_text_on", "_vehicle_markers_text_off", "_madeBY", "_info_header", "_info1", "_info2", "_info3"];

switch (GVAR(diary_language_text)) do {
	case "fin": {
		#include "diaryLocalisation\fin.sqf"
	};

	case "swe": {
		#include "diaryLocalisation\swe.sqf"
	};

	default {
		#include "diaryLocalisation\eng.sqf"
	};
};

_version = format ["%1.%2.%3", MAJOR,MINOR,PATCHLVL];


player createDiarySubject [_main_header,_main_header];

player createDiaryRecord [_main_header,[_buttons_header, "

<br/><br/><font size=20><execute expression=' [true] call " + QFUNC(diary_AllMarkerStatus) + "'>" + _all_markers_on + "</execute>

<br/><br/><execute expression=' [false] call " + QFUNC(diary_AllMarkerStatus) + "'>" + _all_markers_off + "</execute>

<br/><br/><execute expression=' [true] call " + QFUNC(diary_GroupMarkerStatus) + "'>" + _group_markers_on + "</execute>

<br/><br/><execute expression=' [false] call " + QFUNC(diary_GroupMarkerStatus) + "'>" + _group_markers_off + "</execute>

<br/><br/><execute expression=' [true]  call " + QFUNC(diary_VehicleMarkerStatus) + "'>" + _vehicle_markers_on + "</execute>

<br/><br/><execute expression=' [false] call " + QFUNC(diary_VehicleMarkerStatus) + "'>" + _vehicle_markers_off + "</execute>

<br/><br/><execute expression=' [true] call " + QFUNC(diary_VehicleMarkerTextStatus) + "'>" + _vehicle_markers_text_on + "</execute>

<br/><br/><execute expression=' [false] call " + QFUNC(diary_VehicleMarkerTextStatus) + "'>" + _vehicle_markers_text_off + "</execute

<br/><br/><font color='#4F4F4F' size='8'>" + " " + _madeBY +" Tuntematon @ ArmaFinland.fi</font>
<br/><font color='#4F4F4F' size='9'>Powered By TuntematonEngine "+ _version +"</font>"]];

if (GVAR(diary_info_text)) then {
	player createDiaryRecord ["Diary",[_info_header, _info1 +(createDiaryLink [_main_header, player, " ''" + _main_header + "'' "])+ _info2 +(createDiaryLink [_main_header, player, " ''" + _main_header + "'' "])+ " " +_info3]];
};
