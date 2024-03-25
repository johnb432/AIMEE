#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Returns what backpacks are where.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Returns <ARRAY>
 * 0: Base backpack <OBJECT>
 * 1: Weapon backpack <OBJECT>
 * 2: Weaponholder <OBJECT>
 * 3: If base is on ground or not <BOOL>
 *
 * Example:
 * player call AIMEE_inventory_fnc_locateBackpack
 *
 * Public: No
 */

private _backpack = backpackContainer _this;

if (isNull _backpack) exitWith {[objNull, objNull, objNull, false]};

private _config = configOf _backpack >> "assembleInfo";

if (isNull _config) exitWith {[objNull, objNull, objNull, false]};

// If tripod on back
if (getNumber (_config >> "primary") == 0) then {
    private _backpackType = typeOf _backpack;
    private _weaponHolder = objNull;
    private _weapon = objNull;

    // Find weapon part on ground and get its info
    {
        {
           if (((getArray (configOf _x >> "assembleInfo" >> "base")) findIf {_backpackType == _x}) != -1) exitWith {
               _weapon = _x;
           };
        } forEach (everyBackpack _x);

        if (!isNull _weapon) exitWith {
            _weaponHolder = _x;
        };
    } forEach (nearestObjects [_this, ["GroundWeaponHolder"], 3]);

    [_backpack, _weapon, _weaponHolder, false]
} else {
    // If weapon on back: Returns classnames of tripod backpacks that are compatible with a given weapon backpack
    private _bases = getArray (_config >> "base");

    if ((_bases param [0, ""]) == "") exitWith {[objNull, objNull, objNull, false]};

    private _type = "";
    private _weaponHolder = objNull;
    private _base = objNull;

    {
        {
           _type = typeOf _x;

           if ((_bases findIf {_type == _x}) != -1) exitWith {
               _base = _x;
           };
        } forEach (everyBackpack _x);

        if (!isNull _base) exitWith {
            _weaponHolder = _x;
        };
    } forEach (nearestObjects [_this, ["GroundWeaponHolder"], 3]);

    [_base, _backpack, _weaponHolder, true]
};
