#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
   	QGVAR(settingGetInAction),
   	"CHECKBOX",
    [LLSTRING(EnableMountMenu), LLSTRING(EnableMountMenuToolTip)],
   	COMPONENT_NAME,
   	true
] call CBA_fnc_addSetting;

[
   	QGVAR(settingChangeAction),
   	"CHECKBOX",
    [LLSTRING(EnableSeatChangeMenu), LLSTRING(EnableSeatChangeMenuToolTip)],
   	COMPONENT_NAME,
   	true
] call CBA_fnc_addSetting;

[
   	QGVAR(settingGetOutAction),
   	"CHECKBOX",
    [LLSTRING(EnableDismountMenu), LLSTRING(EnableDismountMenuToolTip)],
   	COMPONENT_NAME,
   	true
] call CBA_fnc_addSetting;

[
   	QGVAR(settingForceEject),
   	"CHECKBOX",
    [LLSTRING(EnableForceEjectMenu), LLSTRING(EnableForceEjectMenuToolTip)],
   	COMPONENT_NAME,
   	false
] call CBA_fnc_addSetting;

[
   	QGVAR(settingTurnOutAction),
   	"CHECKBOX",
    [LLSTRING(EnableTurnInOutMenu), LLSTRING(EnableTurnInOutMenuToolTip)],
   	COMPONENT_NAME,
   	true
] call CBA_fnc_addSetting;

ADDON = true;
