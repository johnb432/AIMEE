#include "..\script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Sets the icon and name of the interaction.
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

private _uavType = _unit call FUNC(UAVtype);

if (_uavType == "") exitWith {};

private _uavConfig = configFile >> "CfgVehicles" >> _uavType;

if (isNull _uavConfig) exitWith {};

_menu set [1, format [LQSTRING(STR_ACTION_ASSEMBLE), getText (_uavConfig >> "displayName")]];
_menu set [2, getText (_uavConfig >> "icon")];
