#include "script_component.hpp"

class CfgPatches
{
    class Tun_BFT
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.5;
        requiredAddons[] = {"cba_main","Tun_Starmarkers"};
        author[] = {"Tuntematon"};
        authorUrl = "https://armafinland.fi/";
    };
};

class Extended_PostInit_EventHandlers {
    class Tun_BFT {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_PreInit_EventHandlers {
    class Tun_BFT {
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
            class Tun_bft
            {
                displayName = "Tun BFT"; // Category name visible in Edit Attributes window
                collapsed = 1; // When 1, the category is collapsed by default
                class Attributes
                {

                    class Tun_bft_disabled_unit
                    {
                        displayName = "Disable BFT marker";
                        tooltip = "Disable BFT marker for this unit";
                        property = "Tun_bft_disabled_unit";
                        control = "Checkbox";
                        expression = "_this setVariable ['Tun_bft_disabled_unit', _value, true];";
                        defaultValue = "false";
                        unique = 0;
                        condition = "objectBrain";
                    };

                    class Tun_bft_disabled_vehicle: Tun_bft_disabled_unit
                    {
                        property = "Tun_bft_disabled_vehicle";
                        expression = "_this setVariable ['Tun_bft_disabled_unit', _value, true];";
                        condition =  "objectHasInventoryCargo + objectVehicle";
                    };
                };
            };
        };
    };
};