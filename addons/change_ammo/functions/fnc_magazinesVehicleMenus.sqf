#include "..\script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Makes all interaction menus for all ammo types for a given class of vehicle.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * Modified interaction menu <ARRAY>
 *
 * Example:
 * [player, vehicle player] call AIMEE_change_ammo_fnc_magazinesVehicleMenus
 *
 * Public: No
 */

params ["_unit", "_target"];

private _turret = _target unitTurret _unit;
(weaponState [_target, _turret]) params ["_weapon", "_muzzle", "", "_magazine"];

// Do not allow menu creation for vanilla autocannons that use different firemodes to switch ammunition types instead of magazines
if (_weapon in ["autocannon_40mm_CTWS", "autocannon_30mm_CTWS", "autocannon_30mm", "ACE_cannon_20mm_Rh202"]) exitWith {[]};

// Returns case correct magazines
private _allAvailableMags = (_target magazinesTurret [_turret, false]) call CBA_fnc_getArrayElements;
private _compatibleMags = compatibleMagazines [_weapon, _muzzle] - [_magazine];
private _menus = [];
private _class = "";
private _config = "";
private _cfgMagazines = configFile >> "CfgMagazines";

for "_i" from 0 to (count _allAvailableMags) - 2 step 2 do {
    _class = _allAvailableMags select _i;

    // Find compatible magazines
    if (_class in _compatibleMags) then {
        _config = _cfgMagazines >> _class;

        _menus pushBack [[
            format [QGVAR(magazineVehicle_%1), _class], // Action name
            getText (_config >> "displayName"), // Name of action shown in menu
            getText (_config >> "picture"), // Icon
            {[_player, _target, _this select 2] call FUNC(loadMagazine)}, // Statement
            {true}, // Condition
            nil,
            [_weapon, _muzzle, _class, _turret] // Action parameters
        ] call ace_interact_menu_fnc_createAction, [], _target];
    };
};

_menus
