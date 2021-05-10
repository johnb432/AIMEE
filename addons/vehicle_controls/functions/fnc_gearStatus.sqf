#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *	Gets or sets landing gear status; Sets a new value for gear status if _set is not nil, old value is returned.
	* For meanings of status values see the macros.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
	* 1: Set new value <BOOLEAN>
	*
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_vehicle", ["_set", nil]];

private _old = _vehicle getVariable [QGVAR(gearStatus), GEAR_UNKNOWN];

if (_old isEqualTo GEAR_UNKNOWN) then {
				private _phase = [_vehicle, "gear"] call FUNC(guessPhase);

			 if (_phase isEqualTo 0) exitWith {
								_old = GEAR_DOWN;
				};

				_old = [GEAR_UP, GEAR_UNKNOWN] select (_phase < 1);
};

if (!isNil "_set") then {
				_vehicle setVariable [QGVAR(gearStatus), _set];
};

_old;
