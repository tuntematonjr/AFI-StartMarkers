#include "script_component.hpp"
#define    KAIKKIOSAPUOLET    [West,East,Independent,Civilian]

Tun_Aloitusmerkit_Versio = " 3.5.0";
/*
    Tekijä: Tuntematon
    19.12.2017

    Kuvaus:
        Tekee tehtävään aloitusmerkit ryhmille ja ajoneuvoille.

    Muuttujia:
        Jos et halua että tämä scripti ajetaan tehtävässä. Laita inittiin seuraava.
        AFI_Aloitusmerkit = false;

        Laita tämä RJ tai ajoneuvon slottiin jos et tahdo että sen kohdalle tehdään merkki.
        this setVariable ["AFI_Aloitusmerkit_Ryhmamerkki",false];

        Jos haluat vaihtaa ajoneuvo nimeä. Laita tämä sen inittiin.
        this setVariable["displayName", "BATMOBIILI!"];

        Jos et halua että liittolaisten alotuspaikat näkyvät. Laita inittiin seuraava.
        AFI_Aloitusmerkit_Liittolaiset = False;

        Jos haluat vaihtaa tehtävässä tekstit rallienganniksi. Laita seuraava muuttuja trueksi.
        AFI_Aloitusmerkit_Englanniksi = true;

        Jos tehtävässä siirretään yksiköiden paikkaa alussa. Voit käskeä servuria odottamaan laitamalla.
        AFI_Aloitusmerkit_Serveri_Odota = True;
        Ja kun haluat että servuri jatkaa scriptin ajamista. (Servuri ottaa ryhmien ja ajoneuvojen paikat talteen. Tämän jälkeen jos vielä siirrät paikkaa. Ei merkit ole oikein.)
        AFI_Aloitusmerkit_Serveri_Odota = False;

        Jos tehtävässä on johtoryhmiä jotka ei vastaa afi standardi nimeämistä. Lisää tämä init.sqf ja tämän arrayn sisälle halutut tunnukset jotka määrittä että ryhmä on johtoryhmä.
        AFI_Aloitusmerkit_Johtoryhmatunnus = ["Sierra"];

*/


//katsotaan tarviiko scriptaa ajaa.
ISNILS(AFI_Aloitusmerkit,true);
if !(AFI_Aloitusmerkit) exitwith {};
uiSleep 1;

if (isMultiplayer && !isServer) then {
    if (isNull player) then {
        waitUntil{(!isNull player)};
        uiSleep 1;
    };
    if (time == 0) then {waitUntil {(!isNull findDisplay 53)}};
};





//Servu tallentaa kaikki ryhmien ja ajoneuvojen sijainnit. Ja jakaa ne pelaajille Pelin alettua.
if (isServer) then {

    ISNILS(TUN_SERVU_VALMIS,false);
    if (TUN_SERVU_VALMIS) exitwith {}; //Varmistetaan ettei ajeta uudestaan.
    TUN_SERVU_VALMIS = true;

    ISNILS(AFI_Aloitusmerkit_Serveri_Odota,false);
    if (isNil "TUN_Servuri_Odota") then { waitUntil {!(AFI_Aloitusmerkit_Serveri_Odota)} } else { waitUntil {!(TUN_Servuri_Odota)} };

    //Serveri tallentaa tarpeelliset tiedot JIPeille.
    [] call TUN_fnc_RyhmaMerkkien_Data;
    [] call TUN_fnc_AjoneuvoMerkkien_Data;

    waitUntil {TUN_Ajoneuvo_Merkit_Servuri == "JobsDone" && TUN_JV_Merkit_Valmis == "JobsDone"};
    publicVariable "TUN_SERVU_VALMIS";
};

if (!hasInterface) exitWith {}; //Servuri jatkaa matkaa muille maille.










waitUntil {!isNull player && hasInterface && missionNamespace getVariable "TUN_SERVU_VALMIS"};
if (typeOf player == "VirtualSpectator_F" || typeOf player == "ace_spectator_virtual") exitwith {}; //Ei aja spectasloteille.

{
    ISNILS(TUN_Ajettuscripta,false);
    ISNILS(AFI_Aloitusmerkit_Liittolaiset,true);

    if (TUN_Ajettuscripta) exitwith {player commandChat "Tehtävässä ajetaan aloituspaikan merkkaus scripta useampaan kerntaa."};
    TUN_Ajettuscripta = true;


    //Jos peli ei ole alkanut. Ottaa pelaaja itse datan taltee. Eikä tarvitse pyytää sitä erikseen servurilta.
    if (time == 0) then {
        [] call TUN_fnc_RyhmaMerkkien_Data;
        [] call TUN_fnc_AjoneuvoMerkkien_Data;
    };





    //////////
    //Ryhmät//
    //////////

    AFI_Aloitusmerkit_Johtoryhmatunnus append ["10"];
    {
        private ["_liittolainen", "_Inf_merkki", "_HQ_Merkki", "_MerkinVari"];
        _liittolainen = false;
         _Side = _x;
        if (AFI_Aloitusmerkit_Liittolaiset) then {
            _liittolainen = [side player, _Side] call BIS_fnc_sideIsFriendly; //Tarkistetaan onko liittolainen
        };

        if (side player == _Side || (_liittolainen && !(_Side == civilian))) then {
            switch (_Side) do {
                case West: {
                    _Inf_merkki = "b_inf";
                    _HQ_Merkki = "b_hq";
                    _MerkinVari = "ColorWEST";
                    if !(time == 0) then  {AFI_Aloitusmerkit_JV_West = missionNamespace getVariable "AFI_Aloitusmerkit_JV_West"}; //Jos peli alkanut. Otetaan data Servurilta.
                    [AFI_Aloitusmerkit_JV_West, _Inf_merkki, _HQ_Merkki, _MerkinVari, AFI_Aloitusmerkit_Johtoryhmatunnus] call TUN_fnc_RyhmaMerkkien_Teko;
                };
                case East: {
                    _Inf_merkki = "o_inf";
                    _HQ_Merkki = "o_hq";
                    _MerkinVari = "ColorEAST";
                    if !(time == 0) then  {AFI_Aloitusmerkit_JV_East = missionNamespace getVariable "AFI_Aloitusmerkit_JV_East"}; //Jos peli alkanut. Otetaan data Servurilta.
                    [AFI_Aloitusmerkit_JV_East, _Inf_merkki, _HQ_Merkki, _MerkinVari, AFI_Aloitusmerkit_Johtoryhmatunnus] call TUN_fnc_RyhmaMerkkien_Teko;
                };

                case Independent: {
                    _Inf_merkki = "n_inf";
                    _HQ_Merkki = "n_hq";
                    _MerkinVari = "ColorGUER";
                    if !(time == 0) then  {AFI_Aloitusmerkit_JV_Guer = missionNamespace getVariable "AFI_Aloitusmerkit_JV_Guer"}; //Jos peli alkanut. Otetaan data Servurilta.
                    [AFI_Aloitusmerkit_JV_Guer, _Inf_merkki, _HQ_Merkki, _MerkinVari, AFI_Aloitusmerkit_Johtoryhmatunnus] call TUN_fnc_RyhmaMerkkien_Teko;
                };

                default {
                    _Inf_merkki = "n_inf";
                    _HQ_Merkki = "n_hq";
                    _MerkinVari = "ColorCIV";
                    if !(time == 0) then  {AFI_Aloitusmerkit_JV_Civ = missionNamespace getVariable "AFI_Aloitusmerkit_JV_Civ"}; //Jos peli alkanut. Otetaan data Servurilta.
                    [AFI_Aloitusmerkit_JV_Civ, _Inf_merkki, _HQ_Merkki, _MerkinVari, AFI_Aloitusmerkit_Johtoryhmatunnus] call TUN_fnc_RyhmaMerkkien_Teko;
                };
            };
        };
    } forEach KAIKKIOSAPUOLET;







    //Laitoksen sijainti,Laitoksen suunta, Laitoksen clasname, Laitoksen puoli
    //Kerätään Ajoneuvojen data yhteen muuttujaan.
    {
        private ["_Side", "_Parametrit"];
        _Side = _x;

        _liittolainen = false;
        if (AFI_Aloitusmerkit_Liittolaiset) then {
            _liittolainen = [side player, _Side] call BIS_fnc_sideIsFriendly; //Tarkistetaan onko liittolainen
        };

        if (side player == _Side || (_liittolainen && !(_Side == civilian))) then {

            switch (_Side) do
            {
                case west: {
                    if !(time == 0) then  {AFI_Aloitusmerkit_Ajoneuvot_West = missionNamespace getVariable "AFI_Aloitusmerkit_Ajoneuvot_West"}; //Jos peli alkanut. Otetaan data Servurilta.
                    _Parametrit = AFI_Aloitusmerkit_Ajoneuvot_West;

                };
                case east: {
                    if !(time == 0) then  {AFI_Aloitusmerkit_Ajoneuvot_East = missionNamespace getVariable "AFI_Aloitusmerkit_Ajoneuvot_East"}; //Jos peli alkanut. Otetaan data Servurilta.
                    _Parametrit = AFI_Aloitusmerkit_Ajoneuvot_East;
                };
                case independent: {
                    if !(time == 0) then  {AFI_Aloitusmerkit_Ajoneuvot_Guer = missionNamespace getVariable "AFI_Aloitusmerkit_Ajoneuvot_Guer"}; //Jos peli alkanut. Otetaan data Servurilta.
                    _Parametrit = AFI_Aloitusmerkit_Ajoneuvot_Guer;
                };
                default {
                    if !(time == 0) then  {AFI_Aloitusmerkit_Ajoneuvot_Civ = missionNamespace getVariable "AFI_Aloitusmerkit_Ajoneuvot_Civ"}; //Jos peli alkanut. Otetaan data Servurilta.
                    _Parametrit = AFI_Aloitusmerkit_Ajoneuvot_Civ;
                };
            };


            {
                private ["_Sijainti", "_Suunta", "_Ajoneuvo", "_Clasname", "_Side", "_VehkeenTeksti", "_VehkeenRGBvari"];
                _Sijainti = _x select 0;
                _Suunta = _x select 1;
                _Ajoneuvo = _x select 2;

                _Clasname = typeOf _Ajoneuvo;
                _Side = _Ajoneuvo getVariable "AFI_vehicle_gear";
                _VehkeenTeksti = str(_Ajoneuvo getVariable ["displayName", getText (configFile/"CfgVehicles"/typeOf _Ajoneuvo/"displayName")]);

                _VehkeenRGBvari = switch (_Side) do {
                    case "west": {[0,0.3,0.6,1]};
                    case "east": {[0.5,0,0,1]};
                    case "guer": {[0,0.5,0,1]};
                    default {[0.4,0,0.5,1]}
                };

                TUN_Ajoneuvo_Parametrit pushBack [_Sijainti, _Suunta, _Clasname, _VehkeenTeksti, _VehkeenRGBvari]; //Laitoksen sijainti. Laitoksen suunta. Laitoksen clasname. Laitoksen Nimi. Laitoksen Väri

            } forEach _Parametrit;
        };
    } forEach KAIKKIOSAPUOLET;

    [] call  TUN_fnc_Ajoneuvo_Merkit; // Tehdään ajoneuvomerkit.







    //tehdään briiffiin täbi jossa voi säätää merkkien näkyvyyttä.
    ISNILS(AFI_Aloitusmerkit_Englanniksi,false);
    if (AFI_Aloitusmerkit_Englanniksi) then {
        player createDiarySubject ["Start Markers","Start Markers"];

        player createDiaryRecord ["Start Markers",["Start Markers ON/OFF", "

        <br/><br/><font size=20><execute expression='[1] call TUN_fnc_Kaikkien_Merkkien_Tila;'>All Markers On</execute>

        <br/><br/><execute expression='[0] call TUN_fnc_Kaikkien_Merkkien_Tila'>All Markers Off</execute>

        <br/><br/><execute expression='[1] call TUN_fnc_AjoneuvoMerkkien_Tila;'>Vehicle Markers On</execute>

        <br/><br/><execute expression='[0] call TUN_fnc_AjoneuvoMerkkien_Tila;'>Vehicle Markers Off</execute>

        <br/><br/><execute expression='[1] call TUN_fnc_RyhmaMerkkien_Tila;'>Group Markers On</execute>

        <br/><br/><execute expression='[0] call TUN_fnc_RyhmaMerkkien_Tila;'>Group Markers Off</execute>

        <br/><br/><execute expression='[1] call TUN_fnc_AjoneuvoMerkkien_Tekstin_Tila;'>Vehicle Marker Texts On</execute>

        <br/><br/><execute expression='[0] call TUN_fnc_AjoneuvoMerkkien_Tekstin_Tila;'>Vehicle Marker Texts Off</execute

        <br/><br/><font color='#4F4F4F' size='8'>Made by Tuntematon @ ArmaFinland.fi</font>
        <br/><font color='#4F4F4F' size='9'>Powered By TuntematonEngine"+ Tun_Aloitusmerkit_Versio +"</font>"]];

        player createDiaryRecord ["Diary",["Starting position markers","The mission uses a script that marks the starting locations of all units. You can choose which markers are visible by modifying" +(createDiaryLink ["Start Markers", player, " ''Start Markers'' "])+ "from the left.<br/>The markers are hidden after the safe start is over. You can bring them up again through the " +(createDiaryLink ["Start Markers", player, " ''Start Markers'' "])+ " menu."]];

    } else {

        player createDiarySubject ["Aloitusmerkit","Aloitusmerkit"];

        player createDiaryRecord ["Aloitusmerkit",["Merkit ON/OFF", "<br/><br/><font size=20><execute expression='[1] call TUN_fnc_Kaikkien_Merkkien_Tila;'>Kaikki Merkit Päälle</execute>

        <br/><br/><execute expression='[0] call TUN_fnc_Kaikkien_Merkkien_Tila'>Kaikki Merkit Pois</execute>

        <br/><br/><execute expression='[1] call TUN_fnc_AjoneuvoMerkkien_Tila;'>Ajoneuvomerkit Päälle</execute>

        <br/><br/><execute expression='[0] call TUN_fnc_AjoneuvoMerkkien_Tila;'>Ajoneuvomerkit Pois</execute>

        <br/><br/><execute expression='[1] call TUN_fnc_RyhmaMerkkien_Tila;'>Ryhmämerkit Päälle</execute>

        <br/><br/><execute expression='[0] call TUN_fnc_RyhmaMerkkien_Tila;'>Ryhmämerkit Pois</execute>

        <br/><br/><execute expression='[1] call TUN_fnc_AjoneuvoMerkkien_Tekstin_Tila;'>Ajoneuvomerkkien Tekstit Päälle</execute>

        <br/><br/><execute expression='[0] call TUN_fnc_AjoneuvoMerkkien_Tekstin_Tila;'>Ajoneuvomerkkien Tekstit Pois</execute></font>

        <br/><br/><font color='#4F4F4F' size='9'>Tehnyt Tuntematon @ ArmaFinland.fi</font>
        <br/><font color='#4F4F4F' size='9'>Powered By TuntematonEngine "+ Tun_Aloitusmerkit_Versio +"</font>"]];

        player createDiaryRecord ["Diary",["Aloitusmerkit Scripti","Tehtävässä on käytössä aloituspaikat merkkaava scripti. Voit muokata mitkä merkit näkyy valitsemalla" +(createDiaryLink ["Aloitusmerkit", player, " ''AloitusMerkit'' "])+ "vasemmalta.<br/>Merkit piiloitetaan safestartin jälkeen. Ne saa uudelleen näkyviin " +(createDiaryLink ["Aloitusmerkit", player, " ''AloitusMerkit'' "])+ " valikosta."]];
    };


    [{time > 0}, {
        if (TUN_Ajoneuvo_Merkit_Paalla) then {[0] call TUN_fnc_AjoneuvoMerkkien_Tila};
        [{
            TUN_Display = 12;
            if !(TUN_Ajoneuvo_Merkit_Paalla) then {[1] call TUN_fnc_AjoneuvoMerkkien_Tila};
        }, [], 2] call CBA_fnc_waitAndExecute;
    }] call CBA_fnc_waitUntilAndExecute; //vaihtaa kartan idc oikeaksti pelin alettua jotta ajoneuvo merkit näkyy.


    //piiloittaa merkit safestartin jälkeen. Jokainen voi laittaa ne kuitenkin päälle jos niin haluaa itse uudestaan.
    [{time > 60*("afi_safeStart_duration" call BIS_fnc_getParamValue) + 30}, {[0] call TUN_fnc_Kaikkien_Merkkien_Tila;}] call CBA_fnc_waitUntilAndExecute;

} call CBA_fnc_directCall;

player addEventHandler ["killed",{[0] call TUN_fnc_Kaikkien_Merkkien_Tila}];
