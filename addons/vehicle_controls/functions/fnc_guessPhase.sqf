#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Does a bit of guess work to determine the "overall" progress of animations.
	* Assumes the majority of animation phase values during the animation are identical and related to its progress.
	* This could be extremely error-prone but will stay until a better solution appears.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Name <STRING>
 *
 * Return Value:
 * Returns estimate where the phase it at <INTEGER>
 *
 * Public: No
 */

params ["_vehicle", "_name"];

private _last = 0;
private _count = 0;
private _highest = 0;
private _highestV = 0;
private _phases = [_vehicle, _name] call FUNC(animPhases);

if (_phases isEqualTo []) exitWith {-1};

_phases sort true;

{
				if (_last isNotEqualTo _x) then {
								_count = 0;
				};

				_last = _x;
				_count = _count + 1;

				if (_count > _highest) then {
								_highest = _count;
								_highestV = _x;
				};
} forEach _phases;

_highestV;
