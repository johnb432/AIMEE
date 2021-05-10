#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(settingAmmoClass),
    "CHECKBOX",
    [LLSTRING(EnableAmmoMenu), LLSTRING(EnableAmmoMenuToolTip)],
    COMPONENT_NAME,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(settingVehicleAmmoClass),
    "CHECKBOX",
    [LLSTRING(EnableAmmoMenuVehicle), LLSTRING(EnableAmmoMenuVehicleToolTip)],
    COMPONENT_NAME,
    true
] call CBA_fnc_addSetting;

ADDON = true;
