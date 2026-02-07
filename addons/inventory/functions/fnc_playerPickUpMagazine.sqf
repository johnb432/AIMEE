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
 * [player, cursorObject, ["30Rnd_762x39_AK12_Mag_F", 30]] call AIMEE_inventory_fnc_playerPickupMagazine
 *
 * Public: No
 */

scopeName "main";

params ["_unit", "_container", "_magazine"];
_magazine params ["_magazine", "_ammo"];

private _loadout = getUnitLoadout _unit;
private _muzzles = [];
private _magazineMuzzles = [];

{
    _x params [["_weapon", ""], "", "", "", ["_primaryMagazine", []], ["_secondaryMagazine", []]];

    // Find in which muzzle the magazine fits
    if !(_weapon canAdd _magazine) then {
        continue;
    };

    _muzzles = _weapon call CBA_fnc_getMuzzles;
    _magazineMuzzles = (_muzzles apply {_magazine in compatibleMagazines [_weapon, _x]});

    // Check all muzzles, in case primary muzzle is full, but secondary muzzle can take magazine
    if !(true in _magazineMuzzles) then {
        continue;
    };

    private _muzzleIndex = -1;

    {
        if (([_primaryMagazine, _secondaryMagazine] select _forEachIndex) param [0, ""] == "") exitWith {
            _muzzleIndex = _forEachIndex;
        };
    } forEach _magazineMuzzles;

    _unit playAction "PutDown";

    [{
        params ["_unit", "_magazine", "_ammo", "_container", "_weapon", "_muzzles", "_muzzleIndex", "_weaponIndex"];

        if (!alive _unit) exitWith {};

        ((getUnitLoadout _unit) select ([_weaponIndex, 8] select (_weaponIndex == 3))) params [["_newWeapon", ""], "", "", "", ["_primaryMagazine", []], ["_secondaryMagazine", []]];

        // Check if unit's gear hasn't updated; Don't continue
        if (_newWeapon != _weapon || {([_primaryMagazine, _secondaryMagazine] select _muzzleIndex) param [0, ""] != ""}) exitWith {};

        // If magazine couldn't be removed, it means it was deleted before; Don't continue
        if !([_container, _magazine, 1, _ammo] call CBA_fnc_removeMagazineCargo) exitWith {};

        private _weaponConfig = configFile >> "CfgWeapons" >> _weapon;

        // If secondary magazine was chosen, get secondary muzzle
        if (_muzzleIndex != 0) then {
            _weaponConfig = _weaponConfig >> _muzzles select _muzzleIndex;
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

            // Play sound
            private _sound = getArray (configFile >> "CfgWeapons" >> _weapon >> "reloadMagazineSound");

            if (_sound isEqualTo []) exitWith {};

            // Get position where to play the sound (position of the weapon)
            private _position = _unit modelToWorldVisualWorld (_unit selectionPosition "RightHand");

            _sound params ["_filename", ["_volume", 1], ["_soundPitch", 1], ["_distance", 0]];

            if (_filename == "") exitWith {};

            // Add file extension .wss as default
            if !(toLowerANSI (_filename select [count _filename - 4]) in [".wav", ".ogg", ".wss"]) then {
                _filename = format ["%1.wss", _filename];
            };

            playSound3D [_filename, objNull, insideBuilding _unit >= 0.5, _position, _volume, _soundPitch, _distance];
        };

        [{
            params ["_unit", "_magazine", "_ammo", "_weapon"];

            _unit addWeaponItem [_weapon, [_magazine, _ammo]];
        }, [_unit, _magazine, _ammo, _weapon], _duration] call CBA_fnc_waitAndExecute;
    }, [_unit, _magazine, _ammo, _container, _weapon, _muzzles, _muzzleIndex, _forEachIndex], 1] call CBA_fnc_waitAndExecute;

    true breakOut "main" // return
} forEach [_loadout select 0, _loadout select 1, _loadout select 2, _loadout select 8]; // Primary, secondary, handgun weapons, binoculars

// Add to inventory if possible
if (_unit canAdd _magazine) exitWith {
    _unit action ["TakeMagazine", _container, _magazine];

    true // return
};

false // return
