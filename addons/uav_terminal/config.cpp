#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "AIMEE_main",
            "ace_interaction"
        };
        author = "johnb43";
        authors[] = {
            "upsilon",
            "johnb43"
        };
        url = "https://github.com/johnb432/AIMEE";
        skipWhenMissingDependencies = 1;
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
