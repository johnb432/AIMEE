#include "script_component.hpp"

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

private _menus = GVAR(changeAmmoNamespace) getVariable format [QGVAR(loadoutMenu%1), _muzzle];

// If person and the player's loadout hasn't changed, don't bother making new menu
if (!GVAR(loadoutChanged) && {!isNil "_menus"}) exitWith {
    _menus;
};

GVAR(loadoutChanged) = false;

private _weaponConfig = _weapon;

// Get information for muzzle
if (_muzzle isNotEqualTo _weapon) then {
    _weaponConfig = configFile >> "CfgWeapons" >> _weapon >> _muzzle;
};

// Returns case correct magazines
private _allAvailableMags = (magazines [_this, false]) call CBA_fnc_getArrayElements;
private _allowed = _weaponConfig call CBA_fnc_compatibleMagazines;
private _menus = [];
private _class = "";
private _config = "";
private _cfgMagazines = configFile >> "CfgMagazines";

for "_i" from 0 to (count _allAvailableMags - 2) step 2 do {
    _class = _allAvailableMags select _i;

    // Find magazines that are available (magazines are case sensitive!) and see if the the magazine isn't the same as the current magazine
    if (_class in _allowed && {_class isNotEqualTo _magazine}) then {
        _config = _cfgMagazines >> _class;

        _menus pushBack [[
            format [QGVAR(magazine_%1), _class], // Action name
            format ["%1 (%2 %3)", getText (_config >> "displayName"), _allAvailableMags select (_i + 1), LLSTRING(AmmoMenuLeft)], // Name of action shown in menu,
            getText (_config >> "picture"), // Icon
            {[_player, _player, _this select 2] call FUNC(loadMagazine)},// Statement
            {true}, // Condition
            nil,
            [_weapon, _muzzle, _class] // Action parameters
        ] call ace_interact_menu_fnc_createAction, [], _target];
    };
};

GVAR(changeAmmoNamespace) setVariable [format [QGVAR(loadoutMenu%1), _muzzle], _menus];

_menus;
