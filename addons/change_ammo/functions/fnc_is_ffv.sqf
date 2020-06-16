#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * Returns true if the unit is able to raise weapon and shoot from the vehicle <BOOL>
 *
 * Example:
 *
 *
 * Public: No
 */

params [
	"_unit",
	"_vehicle"
];

private _ableToShoot = false;

scopeName "fnc";
{
	private _occupant = _x select 0;
	private _path = _x select 3;
	private _ffv = _x select 4;

	if (_occupant == _unit && { _ffv } && { count _path > 0 }) then {
		private _turret = [_vehicle, _path] call CBA_fnc_getTurret;

		if (isNull (_turret >> "personTurretAction") || { isTurnedOut _unit }) then {
			_ableToShoot = true;
			breakTo "fnc";
		};
	};
} forEach fullCrew _vehicle;
_ableToShoot;