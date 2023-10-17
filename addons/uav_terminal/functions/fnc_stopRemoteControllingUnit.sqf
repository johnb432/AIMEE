#include "..\script_component.hpp"

/*
 * Author: johnb43
 * Stop remote controlling a unit.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call AIMEE_uav_terminal_fnc_stopRemoteControllingUnit
 *
 * Public: No
 */

// Stop remote controlling unit
bis_fnc_moduleRemoteControl_unit setVariable ["bis_fnc_moduleRemoteControl_owner", nil, true];

objNull remoteControl bis_fnc_moduleRemoteControl_unit;
bis_fnc_moduleRemoteControl_unit = nil;

// Open curator interface, with a delay
[{
    openCuratorInterface;
}, [], 2] call CBA_fnc_execAfterNFrames;
