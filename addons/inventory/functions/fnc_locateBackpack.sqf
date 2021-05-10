#include "script_component.hpp"
/*
 * Author: johnb43
 *
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Player backpack <OBJECT>
 *
 * Return Value:
 * Returns <ARRAY>
 * 0: If base is on ground or not <BOOLEAN>
 * 1: Base backpack <OBJECT>
 * 2: Weapon backpack <OBJECT>
 * 3: Weaponholder <OBJECT>
 *
 * Public: No
 */

params ["_player", "_backpack"];

if (isNull _backpack) exitWith {[false, objNull, objNull, objNull]};

private _config = configOf _backpack >> "assembleInfo";
if (isNull _config) exitWith {[false, objNull, objNull, objNull]};

// If tripod on back:
if (getNumber (_config >> "primary") isEqualTo 0) then {
    private _backpackType = typeOf _backpack;
    private _weaponHolder = objNull;
    private _weapon = objNull;

    // Find weapon part on ground and get its info
    {
        {
           if (((getArray (configOf _x >> "assembleInfo" >> "base")) findIf {_backpackType isEqualTo _x}) isNotEqualTo -1) exitWith {
               _weapon = _x;
           };
        } forEach (everyBackpack _x);

        if (!isNull _weapon) exitWith {
            _weaponHolder = _x;
        };
    } forEach nearestObjects [_player, ["GroundWeaponHolder"], 3];

    [false, _backpack, _weapon, _weaponHolder];
} else {
    // If weapon on back: Returns classnames of tripod backpacks that are compatible with a given weapon backpack
    private _bases = getArray (_config >> "base");

    if (_bases isEqualTo [] || {_bases select 0 isEqualTo ""}) exitWith {[false, objNull, objNull, objNull]};

    private _type = "";
    private _weaponHolder = objNull;
    private _base = objNull;

    {
        {
           _type = typeOf _x;
           if ((_bases findIf {_type isEqualTo _x}) isNotEqualTo -1) exitWith {
               _base = _x;
           };
        } forEach (everyBackpack _x);

        if (!isNull _base) exitWith {
            _weaponHolder = _x;
        };
    } forEach nearestObjects [_player, ["GroundWeaponHolder"], 3];

    [true, _base, _backpack, _weaponHolder];
};
