#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

SETTING(settingAmmoClass,"CHECKBOX",true);
SETTING(settingVehicleAmmoClass,"CHECKBOX",true);

ADDON = true;
