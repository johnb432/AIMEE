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
if (_targetIsPlayer && {(currentMuzzle _target) isNotEqualTo _muzzle}) exitWith {/*systemChat "exit1"*/};

// Don't change mags for currently unselected weapons; This is for vehicles
if (!_targetIsPlayer && {((weaponState [_target, _turret]) select 1) isNotEqualTo _muzzle}) exitWith {/*systemChat "exit2"*/};

/*
2.08

//toFixed 0;

private _magazinesAmmoFull = (magazinesAmmoFull [_target, false]) select {(_x select 0) isEqualTo _magazine};
private _maxIndex = 0;
private _max = [999999, 0] select _targetIsPlayer;

// If in a vehicle, find the magazine with the lowest amount of ammunition; If infantry, find the highest amount
private _condition = [{_x select 1 < _max}, {_x select 1 > _max}] select _targetIsPlayer;

{
    if (call _condition) then {
        _maxIndex = _forEachIndex;
        _max = _x select 1;
    };
} forEach _magazinesAmmoFull;

_max = _magazinesAmmoFull select _maxIndex;

_unit action ["loadMagazine", _target, _unit, _max select 6, _max select 5, _weapon, _muzzle];
*/

/*
// Get magazines that are of the correct type; Exclude empty mags
private _magazinesAmmoFull = (magazinesAmmoFull [_target, false]) select {(_x select 0) isEqualTo _magazine};

// Get count of rounds in magazines, then select maximum if infantry, minimum if vehicle
private _magazinesCount = _magazinesAmmoFull apply {_x select 1};
private _mag = _magazinesAmmoFull select (if (_targetIsPlayer) then {selectMax _magazinesCount} else {selectMin _magazinesCount});

_unit action ["loadMagazine", _target, _unit, _mag select 6, _mag select 5, _weapon, _muzzle];
*/

private _magazines = magazines _target;
private _magDetailStringArray = "";
private _count = 0;
private _magID = "";
private _magCR = "";
private _magIDMax = "";
private _magCRMax = "";
private _numRndsLeft = 0;
private _numRndsFull = 0;
private _numRndsLeftMax = [999999, 0] select _targetIsPlayer;

// If in a vehicle, find the magazine with the lowest amount of ammunition; If infantry, find the highest amount
private _condition = [{_numRndsLeft < _numRndsLeftMax}, {_numRndsLeft > _numRndsLeftMax}] select _targetIsPlayer;

{
    if ((_magazines select _forEachIndex) isNotEqualTo _magazine) then {
        continue;
    };

    _magDetailStringArray = _x splitString "([ ]/:)";
    _count = count _magDetailStringArray;

    _magID = _magDetailStringArray select (_count - 2);
    _magCR = _magDetailStringArray select (_count - 1);
    _numRndsLeft = parseNumber (_magDetailStringArray select (_count - 6));
    _numRndsFull = parseNumber (_magDetailStringArray select (_count - 5));

    // Search for a magazine that is max capacity if target is player
    if (_targetIsPlayer && {_numRndsLeft isEqualTo _numRndsFull}) exitWith {
        _magIDMax = _magID;
        _magCRMax = _magCR;
    };

    // Otherwise search for the fullest magazine (least fullest for vehicles)
    if (call _condition) then {
        _numRndsLeftMax = _numRndsLeft;
        _magIDMax = _magID;
        _magCRMax = _magCR;
    };
} forEach magazinesDetail _target;

//systemChat str ["loadMagazine", _target, _unit, parseNumber _magCRMax, parseNumber _magIDMax, _weapon, _muzzle];

_unit action ["loadMagazine", _target, _unit, parseNumber _magCRMax, parseNumber _magIDMax, _weapon, _muzzle];
