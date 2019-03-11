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
