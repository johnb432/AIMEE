#include "script_component.hpp"
/*
 * Author: CBA, johnb43
 * https://github.com/CBATeam/CBA_A3/blob/master/addons/common/fnc_compatibleMagazines.sqf
 *
 *
 * Arguments:
 * 0: Weapon <STRING>
 * 1: Muzzle <STRING>
 *
 * Return Value:
 * Returns a list of magazine classes allowed for the muzzle <ARRAY>
 *
 * Public: No
 */

params ["_weapon", "_muzzle"];

_weapon = configFile >> "CfgWeapons" >> _weapon;

private _returnMags = getArray (_weapon >> _muzzle >> "magazines");

{
    {
        _returnMags append getArray _x;
    } forEach configProperties [configFile >> "CfgMagazineWells" >> _x, "isArray _x", false];
} forEach (getArray (_weapon >> _muzzle >> "magazineWell"));

_returnMags arrayIntersect _returnMags;
