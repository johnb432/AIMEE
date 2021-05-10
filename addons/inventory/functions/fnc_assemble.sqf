#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Weapon to be assembled <OBJECT> (Backpack)
 *
 * Return Value:
 * None
 *
 * Tripod must be on back to mount using scripts.
 *
 * Public: No
 */

params ["_player", "_backpack"];

// If tripod on back (weapon on ground):
([_player, _backpack] call FUNC(locateBackpack)) params ["_baseOnGround", "_base", "_weapon", "_weaponHolder"];

// If the base is on the ground, switch it with the weapon on the player's back
if (_baseOnGround) exitWith {
    // Add base to player, which will automatically drop bag
    _player addBackpack (typeOf _base);

    // Delete weapon in weaponholder
    deleteVehicle _weaponHolder;

    [{
        ([_this, backpackContainer _this] call FUNC(locateBackpack)) params ["_baseOnGround", "_base", "_weapon", "_weaponHolder"];

        _this action ["Assemble", _weapon];
    }, _player] call CBA_fnc_execNextFrame;
};

_player action ["Assemble", _weapon];
