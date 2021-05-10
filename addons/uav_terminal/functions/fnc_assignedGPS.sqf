#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: isUAVTerminal <BOOL>
 *
 * Return Value:
 * Returns GPS/Terminal <OBJECT>
 *
 * Public: No
 */

params ["_unit", ["_uavTerminal", false, [false]]];

{
   	if (_x isKindOf ["UavTerminal_base", configFile >> "CfgWeapons"]) exitWith {_x};
   	if (!_uavTerminal && {_x isKindOf ["ItemGPS", configFile >> "CfgWeapons"]}) exitWith {_x};
   	nil;
} forEach (assignedItems _unit);
