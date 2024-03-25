#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "ace_interaction"
        };
        author = "johnb43, upsilon";
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
#include "CfgVersioning.hpp"
