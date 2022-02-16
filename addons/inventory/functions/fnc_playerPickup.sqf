#include "script_component.hpp"

/*
 * Author: upsilon
 * Take one item from a container.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Container <OBJECT>
 *
 * Return Value:
 * If something was taken <BOOL>
 *
 * Example:
 * [player, cursorObject] call AIMEE_inventory_fnc_playerPickup
 *
 * Public: No
 */

params ["_unit", "_container"];

private _takeWeapon = {
    _unit action ["TakeWeapon", _container, _this select 0];
    true;
};

private _takeMagazine = {
    (_this select 0) params ["_magazine", "_number"];

    if !(_unit canAdd _magazine) exitWith {false};

    _unit playAction "PutDown";
    _unit addMagazine [_magazine, _number];
    clearMagazineCargoGlobal _container;
    true;
};

private _takeBackpack = {
    _unit action ["PutBag"];
    _unit action ["AddBag", _container, _this select 0];
    true;
};

{
    _x params ["_function", "_args"];

    if (count _args isEqualTo 1 && {_args call _function}) exitWith {true};
    false;
} forEach [
    [_takeWeapon, weaponCargo _container],
    [_takeMagazine, magazinesAmmo _container],
    [_takeBackpack, backpackCargo _container]
];
