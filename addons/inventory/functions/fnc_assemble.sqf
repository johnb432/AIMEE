#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Assemble a static weapon. Tripod must be on back to mount using scripts.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * player call AIMEE_inventory_fnc_assemble
 *
 * Public: No
 */

(call FUNC(locateBackpack)) params ["_base", "_weapon", "_weaponHolder", "_baseOnGround"];

// If the base is on the ground, switch it with the weapon on the player's back
if (_baseOnGround) then {
    _weapon = backpackContainer _this;

    // Add base to player, which will automatically drop bag
    _this addBackpack (typeOf _base);

    // Delete weapon in weaponholder
    deleteVehicle _weaponHolder;

    // Look for switched backpacks in next frame and assemble then
    [{
        (_this select 0) action ["Assemble", _this select 1];
    }, [_this, _weapon]] call CBA_fnc_execNextFrame;
} else {
    // If tripod on back (weapon on ground)
    _this action ["Assemble", _weapon];
};
