#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
	*
 *
 * Return Value:
 * Returns estimate where the VTOL vectoring is at currently.
 *
 * Public: No
 */

params ["_vehicle"];

private _phases = [_vehicle, "engine"] call FUNC(animPhases);

if (_phases isEqualTo []) exitWith {
    nil;
};

_phases select 0;
