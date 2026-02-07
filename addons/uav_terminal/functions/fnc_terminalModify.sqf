#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Sets the icon and name of the interaction.
 *
 * Arguments:
 * 0: Object (not used) <OBJECT>
 * 1: Unit <OBJECT>
 * 2: Params (not used) <ARRAY>
 * 3: Interaction menu <ARRAY>
 *
 * Return Value:
 * None <ARRAY>
 *
 * Public: No
 */

params ["", "_unit", "", "_menu"];

if !(_unit call FUNC(assignedTerminal)) exitWith {};

private _config = configFile >> "CfgWeapons" >> _unit getSlotItemName 612;

_menu set [1, getText (_config >> "displayName")];
_menu set [2, getText (_config >> "picture")];
