#include "script_component.hpp"
/*
 * Author: upsilon
 * Take one item from _box. _unit is assumed to be player or at least a local unit
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Container <OBJECT>
 *
 * Return Value:
 * If something was taken <BOOL>
 *
 * Public: No
 */

params ["_unit", "_box"];

private _takeWeapon = {
   	_unit action ["TakeWeapon", _box, _this select 0];
   	true;
};

private _takeMagazine = {
   	(_this select 0) params ["_magazine", "_number"];

   	if (!(_unit canAdd _magazine)) exitWith {false};

   	_unit playAction "PutDown";
   	_unit addMagazine [_magazine, _number];
   	clearMagazineCargoGlobal _box;
   	true;
};

private _takeBackpack = {
   	_unit action ["PutBag"];
   	_unit action ["AddBag", _box, _this select 0];
   	true;
};

{
   	_x params ["_function", "_args"];

   	if (count _args isEqualTo 1 && {_args call _function}) exitWith {true};
   	false;
} forEach [
   	[_takeWeapon, weaponCargo _box],
   	[_takeMagazine, magazinesAmmo _box],
   	[_takeBackpack, backpackCargo _box]
];
