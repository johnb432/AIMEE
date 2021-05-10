#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
				QGVAR(settingGearAction),
				"CHECKBOX",
				"Enable landing gear toggle",
				COMPONENT_NAME,
				true
] call CBA_fnc_addSetting;

[
				QGVAR(settingCollisionAction),
				"CHECKBOX",
				"Enable collision light toggle",
				COMPONENT_NAME,
				true
] call CBA_fnc_addSetting;

[
				QGVAR(settingLightsAction),
				"CHECKBOX",
				"Enable head light toggle",
				COMPONENT_NAME,
				true
] call CBA_fnc_addSetting;

[
				QGVAR(settingHoverAction),
				"CHECKBOX",
				"Enable auto-hover toggle",
				COMPONENT_NAME,
				true
] call CBA_fnc_addSetting;

[
				QGVAR(settingManualAction),
				"CHECKBOX",
				"Enable manual fire toggle",
				COMPONENT_NAME,
				true
] call CBA_fnc_addSetting;

[
				QGVAR(settingEngineAction),
				"CHECKBOX",
				"Enable engine on/off toggle",
				COMPONENT_NAME,
				true
] call CBA_fnc_addSetting;

[
				QGVAR(settingFlapsAction),
				"CHECKBOX",
				"Enable flaps control",
				COMPONENT_NAME,
				true
] call CBA_fnc_addSetting;

[
				QGVAR(settingUserActions),
				"CHECKBOX",
				["Show custom component toggles", "Such as helicopter doors, ramps etc."],
				COMPONENT_NAME,
				true
] call CBA_fnc_addSetting;

[
				QGVAR(settingArtyComputerAction),
				"CHECKBOX",
				"Add artillery computer to interaction menu",
				COMPONENT_NAME,
				true
] call CBA_fnc_addSetting;

[
				QGVAR(settingLockControlsAction),
				"CHECKBOX",
				"Enable locking controls for helicopters",
				COMPONENT_NAME,
				true
] call CBA_fnc_addSetting;

[
				QGVAR(settingTakeControlsAction),
				"CHECKBOX",
				"Enable taking controls for helicopters",
				COMPONENT_NAME,
				true
] call CBA_fnc_addSetting;

ADDON = true;
