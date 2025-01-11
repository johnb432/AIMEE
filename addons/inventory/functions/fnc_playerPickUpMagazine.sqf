#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Picks a single magazine from a container and places it in a unit's inventory.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Container <OBJECT>
 * 2: Magazine info <ARRAY>
 *
 * Return Value:
 * Returns if the magazine was picked up or not <BOOL>
 *
 * Example:
 * [player, cursorObject, "30Rnd_762x39_AK12_Mag_F"] call AIMEE_inventory_fnc_playerPickupMagazine
 *
 * Public: No
 */

scopeName "main";

params ["_unit", "_container", "_magazine"];
_magazine params ["_magazine", "_ammo"];

private _loadout = getUnitLoadout _unit;
private _muzzles = [];
private _index = -1;

{
    _x params [["_weapon", ""], "", "", "", ["_primaryMagazine", []], ["_secondaryMagazine", []]];

    _muzzles = _weapon call CBA_fnc_getMuzzles;
    _index = (_muzzles apply {compatibleMagazines [_weapon, _x]}) findIf {_magazine in _x};

    // Find in which muzzle the magazine fits
    if (_weapon canAdd _magazine && {([_primaryMagazine, _secondaryMagazine] select _index) param [0, ""] == ""}) exitWith {
        _unit playAction "PutDown";

        [{
            params ["_unit", "_magazine", "_ammo", "_container", "_weapon", "_muzzles", "_isSecondaryMagazine"];

            // If magazine couldn't be removed, it means it was deleted before; Don't continue
            if !([_container, _magazine, 1, _ammo] call CBA_fnc_removeMagazineCargo) exitWith {};

            private _weaponConfig = configFile >> "CfgWeapons" >> _weapon;

            // If secondary magazine was chosen, get secondary muzzle
            if (_isSecondaryMagazine) then {
                _weaponConfig = _weaponConfig >> _muzzles select 1;
            };

            // From ACE
            private _gesture = getText (_weaponConfig >> "reloadAction");
            private _duration = 0;

            // If an item doesn't have a reload animation, add it instantly
            if (_gesture != "") then {
                if (_weapon isKindOf ["Launcher", configFile >> "CfgWeapons"]) then {
                    _duration = getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> _gesture >> "speed");
                };

                if (_duration == 0) then {
                    _duration = getNumber (configFile >> "CfgGesturesMale" >> "States" >> _gesture >> "speed");
                };

                _duration = if (_duration != 0) then {
                    if (_duration < 0) then {
                        abs _duration
                    } else {
                        1 / _duration
                    }
                } else {
                    6
                };

                _unit playActionNow _gesture;
            };

            [{
                params ["_unit", "_magazine", "_ammo", "_weapon"];

                _unit addWeaponItem [_weapon, [_magazine, _ammo]];
            }, [_unit, _magazine, _ammo, _weapon], _duration] call CBA_fnc_waitAndExecute;
        }, [_unit, _magazine, _ammo, _container, _weapon, _muzzles, _index == 1], 1] call CBA_fnc_waitAndExecute;

        true breakOut "main"
    };
} forEach [_loadout select 0, _loadout select 1, _loadout select 2, _loadout select 8]; // Primary, secondary, handgun weapons, binoculars

// Add to inventory if possible
if (_unit canAdd _magazine) exitWith {
    _unit action ["TakeMagazine", _container, _magazine];

    true
};

false
