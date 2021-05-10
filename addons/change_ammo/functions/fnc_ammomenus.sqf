#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <OBJECT>
 * 2: Arguments <ARRAY>
 *
 * Return Value:
 * All interaction submenus for all ammo types for a given class of vehicle <ARRAY>
 *
 * Public: No
 */

params ["_target", "_player", "_args"];

private _isVehicle = _target isNotEqualTo _player;
private _turret = [[], _player call CBA_fnc_turretPath] select _isVehicle;
([weaponState _target, weaponState [_target, _turret]] select _isVehicle) params ["_weapon", "_muzzle", "_fireMode", "_magazine", "_ammoCount"];

// Do not allow menu creation for vanilla autocannons that use different firemodes to switch ammunition types instead of magazines.
if (_weapon in ["autocannon_40mm_CTWS", "autocannon_30mm_CTWS", "autocannon_30mm", "ACE_cannon_20mm_Rh202"]) exitWith {};

private _allAvailableMags = ([magazines _target, _target magazinesTurret _turret] select _isVehicle) call CBA_fnc_getArrayElements;

// If UGL/underslung, _allowed will not be overwritten
private _allowed =
if (_isVehicle || {_weapon isEqualTo _muzzle}) then {
    [_weapon, _isVehicle && {_muzzle isNotEqualTo _weapon}] call CBA_fnc_compatibleMagazines;
} else {
    [_weapon, _muzzle] call FUNC(findCompatMag);
};

private _menus = [];
private _vehicleExec = {
    params ["_target", "_player", "_args"];

    _target loadMagazine _args;
};
private _manExec = {
   	params ["_target", "_player", "_args"];

   	[_target, _args select 0, _args select 1] call FUNC(loadMag);
};

private _class = nil;
private _config = nil;
private _text = "";
private _subMenu = [];

// make this O(not n^2) later maybe?
for "_y" from 0 to (count _allAvailableMags - 2) step 2 do {
    _class = _allAvailableMags select _y;

    // Find magazines that are available (magazines are case sensitive and not always defined correctly, hence the usage of ==) and see if the the magazine isn't the same as the current magazine
    if ((_allowed findIf {_x == _class}) isNotEqualTo -1 && {_class isNotEqualTo _magazine}) then {
        _config = configFile >> "CfgMagazines" >> _class;
        _text = getText (_config >> "displayName");

        _menus pushBack [[
            _text, //Action name
            if (_isVehicle) then { //Name of action shown in menu
                _text
            } else {
                format ["%1 (%2 %3)", _text, _allAvailableMags select (_y + 1), LLSTRING(AmmoMenuLeft)]
            },
            getText (_config >> "picture"), //Icon
            if (_isVehicle) then { //Statement
                _vehicleExec
            } else {
                _manExec
            },
            {true}, //Condition
            nil,
            if (_isVehicle) then { //Action parameters
                // To reload guns, you need to apply loadMagazine to the muzzle.
                [_turret, _muzzle, _class]
            } else {
                [_weapon, _class]
            }
        ] call ace_interact_menu_fnc_createAction, [], _target];
    };
};

_menus;
