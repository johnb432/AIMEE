#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_common",
            "cba_xeh",
            "ace_interact_menu",
            "ace_interaction"
        };
        author = "johnb43, upsilon";
        authors[] = {
            "upsilon",
            "johnb43"
        };
        url = "https://github.com/johnb432/AIMEE";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVersioning.hpp"
