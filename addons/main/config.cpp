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
        authors[] = {"upsilon", "johnb43"};
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
