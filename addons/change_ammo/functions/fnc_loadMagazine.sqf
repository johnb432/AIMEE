#include "..\script_component.hpp"

/*
 * Author: upsilon, johnb43, PabstMirror
 * Loads the least fullest magazine of a given type into the provided muzzle. For vehicle usage only.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target <OBJECT>
 * 2: Params <ARRAY>
 * - 0: Weapon <STRING>
 * - 1: Muzzle <STRING>
 * - 2: Magazine <STRING>
 * - 3: Turret <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player, vehicle player, [_weapon, _muzzle, _magazine, _turret]] call AIMEE_change_ammo_fnc_loadMagazine
 *
 * Public: No
 */

params ["_unit", "_target", "_args"];
_args params ["_weapon", "_muzzle", "_magazine", "_turret"];

// Don't change mags for currently unselected weapons
if (((weaponState [_target, _turret]) select 1) != _muzzle) exitWith {};

private _magazinesAllTurrets = [];

// Get magazines that are of the correct type; Exclude empty mags
{
    _x params ["_xMag", "_xTurret", "_xAmmo"];

    if ((_xMag == _magazine) && {_xTurret isEqualTo _turret} && {_xAmmo > 0}) then {
        _magazinesAllTurrets pushBack _x;
    };
} forEach (magazinesAllTurrets _target);

// Get count of rounds in magazines, then select maximum
private _magazinesCount = _magazinesAllTurrets apply {_x select 2};
private _mag = _magazinesAllTurrets select (_magazinesCount find (selectMax _magazinesCount));

_unit action ["loadMagazine", _target, _unit, _mag select 4, _mag select 3, _weapon, _muzzle];
