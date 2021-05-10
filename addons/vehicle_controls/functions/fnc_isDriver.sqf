#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Unit <OBJECT>
	* 1: Vehicle <OBJECT>
	*
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_vehicle"];

if (_unit isEqualTo driver _vehicle) exitWith {
				true;
};

if (getConnectedUAV _unit isEqualTo _vehicle) exitWith {
				(UAVControl _vehicle) select 1 isEqualTo "DRIVER";
};

if (currentPilot _target isEqualTo _unit) exitWith {
				true;
};

false;
