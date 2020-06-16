#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
	QGVAR(settingAmmoClass),
	"CHECKBOX",
	"Enable ammo switch menu",
	COMPONENT_NAME,
	true
] call CBA_fnc_addSetting;

[
	QGVAR(settingVehicleAmmoClass),
	"CHECKBOX",
	"Enable vehicle gunner ammo switch menu",
	COMPONENT_NAME,
	true
] call CBA_fnc_addSetting;

ADDON = true;