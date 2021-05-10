#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Weapon whose magazine is to be changed <STRING>
 * 2: Magazine to be loaded <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_weapon", "_magazine"];

// Don't change mags for currently unselected weapons
if (currentWeapon _unit isNotEqualTo _weapon) exitWith {};

private _magazines = magazines _unit;
private _magDetailStringArray;
private _count;
private _magID;
private _magCR;
private _magIDMax = 0;
private _magCRMax = 0;
private _numRndsLeft;
private _numRndsFull;
private _numRndsLeftMax = 0;

// Find a suitable magazine to load into the gun
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

    // Search for a magazine that is max capacity
    if (_numRndsLeft isEqualTo _numRndsFull) exitWith {
        _magIDMax = _magID;
        _magCRMax = _magCR;
    };

    // Otherwise search for the fullest magazine
    if (_numRndsLeft > _numRndsLeftMax) then {
        _numRndsLeftMax = _numRndsLeft;
        _magIDMax = _magID;
        _magCRMax = _magCR;
    };
} forEach (magazinesDetail _unit);

_unit action ["loadMagazine", _unit, _unit, parseNumber (_magCRMax), parseNumber (_magIDMax), _weapon, currentMuzzle _unit];
