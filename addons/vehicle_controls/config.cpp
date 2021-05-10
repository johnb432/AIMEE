#include "script_component.hpp"

class CfgPatches {
				class ADDON {
								name = COMPONENT_NAME;
								units[] = {};
								weapons[] = {};
								requiredVersion = REQUIRED_VERSION;
								requiredAddons[] = {"AIME_main"};
								authors[] = {"upsilon", "johnb43"};
				};
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
#include "CfgVehicles.hpp"
