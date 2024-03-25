#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Makes all interaction menus for all ammo types for a unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Modified interaction menu <ARRAY>
 *
 * Example:
 * player call AIMEE_change_ammo_fnc_magazinesUnitMenus
 *
 * Public: No
 */

(weaponState _this) params ["_weapon", "_muzzle", "", "_magazine"];

// Returns case correct magazines
private _magazines = (magazines [_this, false]) call CBA_fnc_getArrayElements;

if (_magazines isEqualTo []) exitWith {[]};

private _compatibleMagazines = compatibleMagazines [_weapon, _muzzle] - [_magazine];
private _class = "";
private _config = configNull;
private _cfgMagazines = configFile >> "CfgMagazines";
private _menus = [];

for "_i" from 0 to (count _magazines) - 2 step 2 do {
    _class = _magazines select _i;

    // Find compatible magazines
    if (_class in _compatibleMagazines) then {
        _config = _cfgMagazines >> _class;

        _menus pushBack [
            [
                format [QGVAR(magazine_%1), _class], // Action name
                format [GVAR(numMagazines), getText (_config >> "displayName"), _magazines select (_i + 1)], // Name of action shown in menu
                getText (_config >> "picture"), // Icon
                {_player reload (_this select 2)}, // Statement
                {true}, // Condition
                nil,
                [_muzzle, _class] // Action parameters
            ] call ace_interact_menu_fnc_createAction,
            [],
            _this
        ];
    };
};

_menus
