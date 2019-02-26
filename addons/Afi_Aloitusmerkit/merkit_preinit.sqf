//19.12.2017

if (isServer) then {
    TUN_JV_Merkit_Valmis = "";
    TUN_Ajoneuvo_Merkit_Servuri = "";
};


if (hasInterface) then {

    TUN_Display = 53; //briiffiruudun display
    TUN_Ryhma_Merkit_Paalla = True;
    TUN_Ajoneuvo_Merkit_Paalla = True;
    TUN_Ajoneuvo_Teksti_Paalla = false;
    TUN_JV_Merkit = [];
    TUN_Ajoneuvomerkkien_ID = [];
    TUN_Ajoneuvo_Parametrit = [];
    AFI_Aloitusmerkit_Johtoryhmatunnus = [];

    TUN_fnc_Ajoneuvo_Merkit = { // Tehdään Ajoneuvo merkit
        {
    _x call {
            params ["_VehkeenPaikka","_VehkeenSuunta","_VehkeenClasname","_VehkeenTeksti","_VehkeenRGBvari"];

                if !(TUN_Ajoneuvo_Teksti_Paalla) then { _VehkeenTeksti = str" "};
                            _MerkinIDC = findDisplay TUN_Display displayCtrl 51 ctrlAddEventHandler
                            ["Draw",format ["_this select 0 drawIcon
                                [
                                    getText (configFile/'CfgVehicles'/%3/'Icon'),
                                    %4,
                                    %1,
                                    30,
                                    30,
                                    %2,
                                    %5,
                                    2
                                ]",
                                _VehkeenPaikka,
                                _VehkeenSuunta,
                                str _VehkeenClasname,
                                _VehkeenRGBvari,
                                _VehkeenTeksti
                        ]
                    ];
                TUN_Ajoneuvomerkkien_ID pushBack _MerkinIDC;
            };
        } forEach TUN_Ajoneuvo_Parametrit;
    };

    TUN_fnc_Kaikkien_Merkkien_Tila = {//kutsuu merkkien poisto functiot
        params ["_tila"];
        switch (_tila) do {
            case 1: {
                if !(TUN_Ajoneuvo_Merkit_Paalla) then {[1] call TUN_fnc_AjoneuvoMerkkien_Tila};
                if !(TUN_Ryhma_Merkit_Paalla) then {[1] call TUN_fnc_RyhmaMerkkien_Tila};
            };
            default {
                if (TUN_Ajoneuvo_Merkit_Paalla) then {[0] call TUN_fnc_AjoneuvoMerkkien_Tila};
                if (TUN_Ryhma_Merkit_Paalla) then {[0] call TUN_fnc_RyhmaMerkkien_Tila};
            };
        };
    };

    TUN_fnc_RyhmaMerkkien_Tila = {
        params ["_tila"];
        switch (_tila) do {
            case 1: {
                if (TUN_Ryhma_Merkit_Paalla) exitwith {};

                {_x setMarkerAlphaLocal 1;} forEach TUN_JV_Merkit;
                TUN_Ryhma_Merkit_Paalla = true;
            };

            default {
                if (!(TUN_Ryhma_Merkit_Paalla)) exitwith {};

                {_x setMarkerAlphaLocal 0;} forEach TUN_JV_Merkit;

                TUN_Ryhma_Merkit_Paalla = false; //Merkkaa että merkit on pois päältä
            };
        };
    };

    TUN_fnc_AjoneuvoMerkkien_Tila = {
        params ["_tila"];

        switch (_tila) do {
            case 1: {
                if (TUN_Ajoneuvo_Merkit_Paalla) exitwith {};

                [] call TUN_fnc_Ajoneuvo_Merkit;
                TUN_Ajoneuvo_Merkit_Paalla = true;
            };

            default {
                if (!(TUN_Ajoneuvo_Merkit_Paalla)) exitwith {};
                {findDisplay TUN_Display displayCtrl 51 ctrlRemoveEventHandler ["Draw", _x];} forEach TUN_Ajoneuvomerkkien_ID;

                TUN_Ajoneuvo_Merkit_Paalla = false;
                TUN_Ajoneuvomerkkien_ID = [];
            };
        };
    };

    TUN_fnc_AjoneuvoMerkkien_Tekstin_Tila = {
        params ["_tila"];

        switch (_tila) do {
            case 1: {
                if (TUN_Ajoneuvo_Teksti_Paalla) exitwith {};
                TUN_Ajoneuvo_Teksti_Paalla = True;

                if (!(TUN_Ajoneuvo_Merkit_Paalla)) exitwith {};

                {findDisplay TUN_Display displayCtrl 51 ctrlRemoveEventHandler ["Draw", _x];} forEach TUN_Ajoneuvomerkkien_ID;

                [] call TUN_fnc_Ajoneuvo_Merkit;
            };

            default {
                if (!(TUN_Ajoneuvo_Teksti_Paalla)) exitwith {};
                TUN_Ajoneuvo_Teksti_Paalla = false;

                if (!(TUN_Ajoneuvo_Merkit_Paalla)) exitwith {};

                {findDisplay TUN_Display displayCtrl 51 ctrlRemoveEventHandler ["Draw", _x];} forEach TUN_Ajoneuvomerkkien_ID;

                [] call TUN_fnc_Ajoneuvo_Merkit;
            };
        };
    };

    TUN_fnc_RyhmaMerkkien_Teko = {
        private ["_Inf_merkki", "_HQ_Merkki", "_MerkinVari"];
        params ["_Parametrit", "_Inf_merkki", "_HQ_Merkki", "_MerkinVari", "_Johtoryhmatunnus"];

        {
            private ["_RyhmanTyyppi", "_merk","_GroupID","_RyhmanSijainti"];
            _GroupID = _x select 0;
            _RyhmanSijainti = _x select 1;

            //Tarkistetaan onko ryhmä johtoryhmä vai normi.
            if ({toLower _GroupID find toLower _x > -1} count _Johtoryhmatunnus > 0) then {_RyhmanTyyppi = _HQ_Merkki} else {_RyhmanTyyppi = _Inf_merkki};

            TUN_JV_Merkit pushBack format ["Tun_Aloitusmerkit_%1", _GroupID]; //JV Merkit talteen

            _merk = createMarkerLocal [format ["Tun_Aloitusmerkit_%1", _GroupID], _RyhmanSijainti];
            _merk setMarkerShapeLocal "ICON";
            _merk setMarkerTypeLocal _RyhmanTyyppi;
            _merk setMarkerSizeLocal [0.7,0.7];
            _merk setMarkerColorLocal _MerkinVari;
            _merk setMarkerTextLocal (_GroupID select [2]);
        } forEach _Parametrit;
    };
};

//////////////////////////////////////////////
//Pelaajille ja Servurille yhteiset functiot//
//////////////////////////////////////////////


    AFI_Aloitusmerkit_JV_West = [];
    AFI_Aloitusmerkit_JV_East = [];
    AFI_Aloitusmerkit_JV_Guer = [];
    AFI_Aloitusmerkit_JV_Civ = [];

    AFI_Aloitusmerkit_Ajoneuvot_West = [];
    AFI_Aloitusmerkit_Ajoneuvot_East = [];
    AFI_Aloitusmerkit_Ajoneuvot_Guer = [];
    AFI_Aloitusmerkit_Ajoneuvot_Civ = [];


TUN_fnc_RyhmaMerkkien_Data = {
    {
        private ["_Ryhmanjohtaja", "_osapuoli", "_RyhmanTyyppi", "_Parametrit"];
        _Ryhmanjohtaja = leader (_x);

        if (_Ryhmanjohtaja getVariable ["AFI_Aloitusmerkit_Ryhmamerkki", true]) then {

            switch (side _Ryhmanjohtaja) do {
                case west: {
                    AFI_Aloitusmerkit_JV_West pushBackUnique [format ["%1", group _Ryhmanjohtaja], getpos _Ryhmanjohtaja]; //Group ID, Ryhmän sijainti
                };
                case east: {
                    AFI_Aloitusmerkit_JV_East pushBackUnique [format ["%1", group _Ryhmanjohtaja], getpos _Ryhmanjohtaja]; //Group ID, Ryhmän sijainti
                };
                case independent: {
                    AFI_Aloitusmerkit_JV_Guer pushBackUnique [format ["%1", group _Ryhmanjohtaja], getpos _Ryhmanjohtaja]; //Group ID, Ryhmän sijainti
                };
                default {
                    AFI_Aloitusmerkit_JV_Civ pushBackUnique [format ["%1", group _Ryhmanjohtaja], getpos _Ryhmanjohtaja]; //Group ID, Ryhmän sijainti
                };
            };
        };
    } forEach allGroups;

    if (isServer) then {
        publicVariable "AFI_Aloitusmerkit_JV_West";
        publicVariable "AFI_Aloitusmerkit_JV_East";
        publicVariable "AFI_Aloitusmerkit_JV_Guer";
        publicVariable "AFI_Aloitusmerkit_JV_Civ";
        TUN_JV_Merkit_Valmis = "JobsDone";
    };
};


TUN_fnc_AjoneuvoMerkkien_Data = {
    {
        private ["_AjoneuvonPuoli"];
        _AjoneuvonPuoli =  toLower (_x getVariable "AFI_vehicle_gear");

        if (_x getVariable ["AFI_Aloitusmerkit_Ryhmamerkki", true] && !(isNil "_AjoneuvonPuoli")) then {

            if (_x isKindof "LandVehicle" || _x isKindof "Air" || _x isKindOf "Ship" || _x isKindOf "Static" || _x isKindOf "thing") then {

                switch (_AjoneuvonPuoli) do {
                    case "west": {
                        AFI_Aloitusmerkit_Ajoneuvot_West pushBackUnique [getPos _x, getDir _x, _x]; //Laitoksen sijainti,Laitoksen suunta, Laiotos
                    };
                    case "east": {
                        AFI_Aloitusmerkit_Ajoneuvot_East pushBackUnique [getPos _x, getDir _x, _x]; //Laitoksen sijainti,Laitoksen suunta, Laiotos
                    };
                    case "guer": {
                        AFI_Aloitusmerkit_Ajoneuvot_Guer pushBackUnique [getPos _x, getDir _x, _x]; //Laitoksen sijainti,Laitoksen suunta, Laiotos
                    };
                    default {
                        AFI_Aloitusmerkit_Ajoneuvot_Civ pushBackUnique [getPos _x, getDir _x, _x]; //Laitoksen sijainti,Laitoksen suunta, Laiotos
                    };
                };
            };
        };
    } forEach vehicles;

    if (isServer) then {
        publicVariable "AFI_Aloitusmerkit_Ajoneuvot_West";
        publicVariable "AFI_Aloitusmerkit_Ajoneuvot_East";
        publicVariable "AFI_Aloitusmerkit_Ajoneuvot_Guer";
        publicVariable "AFI_Aloitusmerkit_Ajoneuvot_Civ";
        TUN_Ajoneuvo_Merkit_Servuri = "JobsDone";
    };
};