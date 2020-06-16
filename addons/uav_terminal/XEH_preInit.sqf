#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
	QGVAR(term_action),
	"CHECKBOX",
	"Add UAV terminal to equipments menu",
	COMPONENT_NAME,
	true
] call CBA_fnc_addSetting;

[
	QGVAR(uav_action),
	"CHECKBOX",
	"Take/release control using self-interaction",
	COMPONENT_NAME,
	true
] call CBA_fnc_addSetting;

[
	QGVAR(gps_action),
	"CHECKBOX",
	"Add GPS to equipments menu",
	COMPONENT_NAME,
	true
] call CBA_fnc_addSetting;

ADDON = true;