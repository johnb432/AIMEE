#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Returns if unit has compatible UAV terminal.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Returns if terminal is present <BOOL>
 *
 * Example:
 * player call AIMEE_uav_terminal_fnc_assignedTerminal
 *
 * Public: No
 */

private _cfgWeapons = configFile >> "CfgWeapons";
private _terminal = _this getSlotItemName 612;

_terminal isKindOf ["UavTerminal_base", _cfgWeapons] && {[_cfgWeapons >> _terminal >> "ItemInfo" >> "side", "NUMBER", -1] call CBA_fnc_getConfigEntry == (side _this) call BIS_fnc_sideID}
