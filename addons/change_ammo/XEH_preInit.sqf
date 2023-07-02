#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// CBA Settings
SETTING(settingAmmoClass,"CHECKBOX",true);
SETTING(settingVehicleAmmoClass,"CHECKBOX",true);

GVAR(numMagazines) = (localize "str_num_magazines") regexReplace ["%s", "%1"] regexReplace ["%d", "%2"];

ADDON = true;
