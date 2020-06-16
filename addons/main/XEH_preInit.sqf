#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
	QGVAR(settingHide),
	"CHECKBOX",
	"Hide actions if associated keybindings exist",
	COMPONENT_NAME,
	true
] call CBA_fnc_addSetting;

ADDON = true;