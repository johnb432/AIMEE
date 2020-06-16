#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

/* [
	QUOT(SETTING(self_action)),
	"CHECKBOX",
	"Show personal inventory action",
	CATEGORY,
	true
] call CBA_Settings_fnc_init; */
[
	QGVAR(settingOpenAction),
	"CHECKBOX",
	"Show vehicle/backpack inventory action",
	COMPONENT_NAME,
	true
] call CBA_fnc_addSetting;

[
	QGVAR(settingBackpackAction),
	"CHECKBOX",
	"Show 3D icon on backpacks",
	COMPONENT_NAME,
	true
] call CBA_fnc_addSetting;

[
	QGVAR(settingHolderAction),
	"CHECKBOX",
	"Show ground inventory and pick up action",
	COMPONENT_NAME,
	true
] call CBA_fnc_addSetting;

[
	QGVAR(settingAssembleAction),
	"CHECKBOX",
	"Enable static weapon assemble/disassemble actions",
	COMPONENT_NAME,
	true
] call CBA_fnc_addSetting;

ADDON = true;