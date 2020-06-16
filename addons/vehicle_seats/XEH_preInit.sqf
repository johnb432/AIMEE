#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
	QGVAR(settingGetInAction),
	"CHECKBOX",
	"Enable vehicle mount actions",
	COMPONENT_NAME,
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(settingChangeAction),
	"CHECKBOX",
	"Enable seat change actions",
	COMPONENT_NAME,
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(settingGetOutAction),
	"CHECKBOX",
	"Enable vehicle dismount/eject actions",
	COMPONENT_NAME,
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(settingForceEject),
	"CHECKBOX",
	"Allow helicopter crew to force eject",
	COMPONENT_NAME,
	false
] call CBA_Settings_fnc_init;

[
	QGVAR(settingTurnOutAction),
	"CHECKBOX",
	"Add turn in/out to self-interaction menu",
	COMPONENT_NAME,
	true
] call CBA_Settings_fnc_init;

ADDON = true;