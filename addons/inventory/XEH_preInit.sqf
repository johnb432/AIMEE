#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(settingOpenAction),
    "CHECKBOX",
    [LLSTRING(OpenActionMenu), LLSTRING(OpenActionMenuToolTip)],
    COMPONENT_NAME,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(settingOpenActionRange),
    "SLIDER",
    [LLSTRING(OpenBackPackRange), LLSTRING(OpenBackPackRangeToolTip)],
    COMPONENT_NAME,
    [0.5, 10, 4.5, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(settingBackpackAction),
    "CHECKBOX",
    [LLSTRING(Show3D), LLSTRING(Show3DToolTip)],
    COMPONENT_NAME,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(settingHolderAction),
    "CHECKBOX",
    [LLSTRING(ShowGroundInventory), LLSTRING(ShowGroundInventoryToolTip)],
    COMPONENT_NAME,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(settingAssembleAction),
    "CHECKBOX",
    [LLSTRING(ShowAssembly), LLSTRING(ShowAssemblyToolTip)],
    COMPONENT_NAME,
    true
] call CBA_fnc_addSetting;

ADDON = true;
