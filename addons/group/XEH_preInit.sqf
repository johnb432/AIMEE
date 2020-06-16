#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
	QGVAR(settingDropLeaderAction),
	"CHECKBOX",
	"Allow players to step down as leader",
	COMPONENT_NAME,
	true
] call CBA_fnc_addSetting;

ADDON = true;