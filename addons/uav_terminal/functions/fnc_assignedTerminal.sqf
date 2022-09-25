#include "script_component.hpp"

/*
 * Author: johnb43
 * Returns index of terminal in assignedItems (command).
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Returns index of terminal in assignedItems <NUMBER>
 *
 * Example:
 * player call AIMEE_uav_terminal_fnc_assignedTerminal
 *
 * Public: No
 */

private _cfgWeapons = configFile >> "CfgWeapons";

(assignedItems _this) findIf {_x isKindOf ["UavTerminal_base", _cfgWeapons]}
