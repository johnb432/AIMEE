#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
   	QGVAR(settingHide),
   	"CHECKBOX",
   	[LLSTRING(HideAction), LLSTRING(HideActionToolTip)],
   	COMPONENT_NAME,
   	true
] call CBA_fnc_addSetting;

ADDON = true;
