#include "script_component.hpp"

ADDON = false;

[
    QGVAR(settingDropLeaderAction),
    "CHECKBOX",
    [LLSTRING(EnableStepDown), LLSTRING(EnableStepDownToolTip)],
    COMPONENT_NAME,
    true
] call CBA_fnc_addSetting;

ADDON = true;
