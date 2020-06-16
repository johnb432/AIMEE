#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Weapon <STRING>
 * 2: Magazine <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 *
 *
 * Public: No
 */

params [
	"_unit",
	"_weapon",
	"_mag",
	["_do_check", true, [false]]
];

private _state = weaponState _unit;

if (_state select 0 != _weapon) exitWith { nil };
if (
	_do_check
	&& { { if (_x == _mag) exitWith { false }; true } forEach magazines player }
) exitWith { nil };
GVAR(handleReloaded) = _state select 3 != "";
GVAR(oldMagazine) = _state select 3;
GVAR(oldMagazineCount) = _state select 4; //how much is in the magazine itself, not the total magazine count
_unit addWeaponItem [_weapon, [_mag, 0]];
reload _unit;