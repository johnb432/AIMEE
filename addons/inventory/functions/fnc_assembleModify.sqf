#include "..\script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Sets the name of the interaction.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Unit <OBJECT>
 * 2: Params <ARRAY>
 * 3: Interaction menu <ARRAY>
 *
 * Return Value:
 * Modified interaction menu <ARRAY>
 *
 * Public: No
 */

params ["", "_unit", "", "_menu"];

(_unit call FUNC(locateBackpack)) params ["_base", "_weapon"];

if (isNull _base || {isNull _weapon}) exitWith {};

_menu set [1, format [LQSTRING(STR_ACTION_ASSEMBLE), getText (configFile >> "CfgVehicles" >> getText (configOf _weapon >> "assembleInfo" >> "assembleTo") >> "displayName")]];
