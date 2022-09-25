#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Loads the least fullest magazine of a given type into the provided muzzle. For vehicle usage only.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target <OBJECT>
 * 2: Params <ARRAY>
 *  2.0: Weapon <STRING>
 *  2.1: Muzzle <STRING>
 *  2.2: Magazine <STRING>
 *  2.3: Turret <ARRAY>
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

// Get magazines that are of the correct type; Exclude empty mags
private _magazinesAmmoFull = (magazinesAmmoFull [_target, false]) select {(_x select 0) == _magazine};

// Get count of rounds in magazines, then select minimum
private _magazinesCount = _magazinesAmmoFull apply {_x select 1};
private _mag = _magazinesAmmoFull select (_magazinesCount find (selectMin _magazinesCount));

_unit action ["loadMagazine", _target, _unit, _mag select 6, _mag select 5, _weapon, _muzzle];
