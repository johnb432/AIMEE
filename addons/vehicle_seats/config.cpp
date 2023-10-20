#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "AIMEE_main",
            "ace_quickmount"
        };
        author = "johnb43";
        authors[] = {
            "upsilon",
            "johnb43"
        };
        url = "https://github.com/johnb432/AIMEE";
        VERSION_CONFIG;
    };
};

#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
