#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
   	QGVAR(termAction),
   	"CHECKBOX",
    [LLSTRING(EnableUAVTerminalMenu), LLSTRING(EnableUAVTerminalMenuToolTip)],
   	COMPONENT_NAME,
   	true
] call CBA_fnc_addSetting;

[
   	QGVAR(UAVAction),
   	"CHECKBOX",
    [LLSTRING(EnableUAVControl), LLSTRING(EnableUAVControlToolTip)],
   	COMPONENT_NAME,
   	true
] call CBA_fnc_addSetting;

[
   	QGVAR(GPSAction),
   	"CHECKBOX",
    [LLSTRING(EnableGPSMenu), LLSTRING(EnableGPSMenuToolTip)],
   	COMPONENT_NAME,
   	true
] call CBA_fnc_addSetting;

ADDON = true;
