#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Loads the fullest (for infantry) or least fullest (for vehicles) magazine of a given type into the provided muzzle.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target <OBJECT>
 * 2: Params <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, player, [currentWeapon player, currentMuzzle player, currentMagazine player]] call AIMEE_change_ammo_fnc_loadMagazine
 *
 * Public: No
 */

params ["_unit", "_target", "_args"];
_args params ["_weapon", "_muzzle", "_magazine", "_turret"];

private _targetIsPlayer = isNil "_turret";

// Don't change mags for currently unselected weapons; This is for infantry
if (_targetIsPlayer && {(currentMuzzle _target) isNotEqualTo _muzzle}) exitWith {};

// Don't change mags for currently unselected weapons; This is for vehicles
if (!_targetIsPlayer && {((weaponState [_target, _turret]) select 1) isNotEqualTo _muzzle}) exitWith {};

// Get magazines that are of the correct type; Exclude empty mags
private _magazinesAmmoFull = (magazinesAmmoFull [_target, false]) select {(_x select 0) isEqualTo _magazine};

// Get count of rounds in magazines, then select maximum if infantry, minimum if vehicle
private _magazinesCount = _magazinesAmmoFull apply {_x select 1};
private _mag = _magazinesAmmoFull select (_magazinesCount find (if (_targetIsPlayer) then {selectMax _magazinesCount} else {selectMin _magazinesCount}));

_unit action ["loadMagazine", _target, _unit, _mag select 6, _mag select 5, _weapon, _muzzle];
