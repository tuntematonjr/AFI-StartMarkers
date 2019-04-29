#include "script_component.hpp"

class CfgPatches
{
    class Afi_Aloitusmerkit
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.5;
        requiredAddons[] = {"cba_main"};
        author[] = {"Tuntematon"};
        authorUrl = "https://armafinland.fi/";
        //,"ace_interact_menu"
    };
};

class Extended_PostInit_EventHandlers {
    class Afi_Aloitusmerkit {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_PreInit_EventHandlers {
    class Afi_Aloitusmerkit {
        init = QUOTE( call COMPILE_FILE(XEH_preInit) );
    };
};


class Cfg3DEN
{
    // Configuration of all objects
    class Object
    {
        // Categories collapsible in "Edit Attributes" window
        class AttributeCategories
        {
            // Category class, can be anything
            class afi_startmarkers
            {
                displayName = "AFI Start position markers"; // Category name visible in Edit Attributes window
                collapsed = 1; // When 1, the category is collapsed by default
                class Attributes
                {

                    class afi_startmarkers_enable_marker_inf
                    {
                        displayName = "Enable startpos marker and BFT for this unit";
                        tooltip = "Create startpos marker and BFT for this unit";
                        property = "afi_startmarkers_enable_marker_inf";
                        control = "Checkbox";
                        expression = "_this setVariable ['afi_startmarkers_enable_marker', _value, true];";
                        defaultValue = "true";
                        unique = 0;
                        condition = "objectBrain";
                    };

                    class afi_startmarkers_enable_marker_vehicle: afi_startmarkers_enable_marker_inf
                    {
                        property = "afi_startmarkers_enable_marker_vehicle";
                        expression = "_this setVariable ['afi_startmarkers_enable_marker', _value, true];";
                        condition =  "objectHasInventoryCargo + objectVehicle";
                    };

                    class afi_startmarkers_startPosName: afi_startmarkers_enable_marker_inf
                    {
                        displayName = "Custon vehicle text";
                        tooltip = "You can change the default startpos marker name shown at brieffing to a different one. Names shorter than 2 characters wont be set.";
                        property = "afi_startmarkers_startPosName";
                        control = "EditShort";
                        expression = "if (count _value > 1) then{_this setVariable['displayName', str _value,true]};";
                        defaultValue = "''";
                        condition = "objectHasInventoryCargo + objectVehicle";
                    };
                    class afi_startmarkers_vehicle_side_west: afi_startmarkers_enable_marker_inf
                    {
                        displayName = "Show this to West";
                        tooltip = "Chose side to show this vehicle. Only pick one side per object.";
                        property = "afi_startmarkers_vehicle_side_west";
                        control = "Checkbox";
                        expression = "if (_value) then {_this setVariable ['afi_startmarkers_vehilce_side', west,true]};";
                        defaultValue = "false";
                        condition = "objectHasInventoryCargo + objectVehicle";
                    };
                    class afi_startmarkers_vehicle_side_east: afi_startmarkers_vehicle_side_west
                    {
                        displayName = "Show this to East";
                        property = "afi_startmarkers_vehicle_side_east";
                        expression = "if (_value) then {_this setVariable ['afi_startmarkers_vehilce_side', east,true]};";

                    };
                    class afi_startmarkers_vehicle_side_ind: afi_startmarkers_vehicle_side_west
                    {
                        displayName = "Show this to Independent";
                        property = "afi_startmarkers_vehicle_side_ind";
                        expression = "if (_value) then {_this setVariable ['afi_startmarkers_vehilce_side', resistance,true]};";


                    };
                    class afi_startmarkers_vehicle_side_civ: afi_startmarkers_vehicle_side_west
                    {
                        displayName = "Show this to Civilian";
                        property = "afi_startmarkers_vehicle_side_civ";
                        expression = "if (_value) then { _this setVariable ['afi_startmarkers_vehilce_side', civilian, true] };";

                    };
                };
            };
        };
    };
};

