#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Return class of GPS/Terminal.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Returns index of terminal in assignedItems <NUMBER>
 *
 * Example:
 * [player, true] call AIMEE_uav_terminal_fnc_assignedTerminal
 *
 * Public: No
 */

(assignedItems _this) findIf {_x isKindOf ["UavTerminal_base", configFile >> "CfgWeapons"]};
