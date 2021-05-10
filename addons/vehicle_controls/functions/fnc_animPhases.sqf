#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Name <STRING>
 *
 * Return Value:
 * Returns a list of animation phases whose names contain _name <ARRAY>
 *
 * Public: No
 */

params ["_vehicle", "_name"];

private _phases = [];
private _phase = -1;

{
				if (_x find _name isNotEqualTo -1) then {
								_phase = _vehicle animationPhase _x;

								if (_phase >= 0) then {
												_phases pushBack _phase;
								};
				};
} forEach animationNames _vehicle;

_phases;
