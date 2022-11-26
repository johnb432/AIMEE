#include "script_component.hpp"

/*
 * Author: johnb43, upsilon
 * Take one item from a container. Requires 1 (no more, no less) of an item to be able to be picked up.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Container <OBJECT>
 *
 * Return Value:
 * If something was taken <BOOL>
 *
 * Example:
 * [player, cursorObject] call AIMEE_inventory_fnc_playerPickup
 *
 * Public: No
 */

params ["_unit", "_container"];

private _weapons = weaponCargo _container;
private _items = itemCargo _container;
private _magazines = magazinesAmmo _container;
private _backpacks = backpackCargo _container;

switch (true) do {
    // Weapon
    case (count _weapons == 1): {
        _unit action ["TakeWeapon", _container, _weapons select 0];

        true
    };
    // Item (this includes uniforms and vests: Don't pick those up if they have items inside them)
    case (count _items == 1 && {load ((everyContainer _container) param [0, []] param [1, objNull]) == 0}): {
        scopeName "main";

        _items params ["_item"];

        private _loadout = getUnitLoadout _unit;
        private _arsenalItems = GETUVAR("ace_arsenal_configItems",[]);

        // Check if the assignedItems slot for item is empty
        {
            if (_item in _x) exitWith {
                // If the item can't be added to the assignedItems, check if it fits in the inventory further below
                if (((_loadout select 9) select _forEachIndex) != "") exitWith {};

                _unit playAction "PutDown";

                [{
                    params ["_unit", "_item", "_container"];

                    // If item couldn't be removed, it means it was deleted before; Don't continue
                    if !([_container, _item] call CBA_fnc_removeItemCargo) exitWith {};

                    _unit linkItem _item;
                }, [_unit, _item, _container], 1] call CBA_fnc_waitAndExecute;

                true breakOut "main"
            };
        // Map, Terminal, Radio, Compass, Watch, NVG
        } forEach [_arsenalItems select 10, _arsenalItems select 14, _arsenalItems select 12, _arsenalItems select 11, _arsenalItems select 13, _arsenalItems select 8];

        // Check if weapons have space for item
        private _attachmentIndex = -1;

        {
            _attachmentIndex = _forEachIndex;

            if (_item in _x) exitWith {
                {
                    _x params [["_weapon", ""], ["_muzzle", ""], ["_flashlight", ""], ["_optics", ""], "", "", ["_bipod", ""]];

                    // Check if item is compatible and if slot is empty
                    if (_weapon canAdd _item && {([_optics, _flashlight, _muzzle, _bipod] select _attachmentIndex) == ""}) exitWith {
                        _unit playAction "PutDown";

                        [{
                            params ["_unit", "_item", "_container", "_weapon"];

                            // If item couldn't be removed, it means it was deleted before; Don't continue
                            if !([_container, _item] call CBA_fnc_removeItemCargo) exitWith {};

                            _unit addWeaponItem [_weapon, _item];
                        }, [_unit, _item, _container, _weapon], 1] call CBA_fnc_waitAndExecute;

                        true breakOut "main"
                    };
                // Primary, secondary, handgun weapons, binoculars
                } forEach [_loadout select 0, _loadout select 1, _loadout select 2, _loadout select 8];
            };
        // Optics, Flashlights, Muzzle attachments, Bipods
        } forEach [_arsenalItems select 1 select 0, _arsenalItems select 1 select 1, _arsenalItems select 1 select 2, _arsenalItems select 1 select 3];

        // Add to inventory if possible
        if (_unit canAdd _item) exitWith {
            _unit playAction "PutDown";

            [{
                params ["_unit", "_item", "_container"];

                // If item couldn't be removed, it means it was deleted before; Don't continue
                if !([_container, _item] call CBA_fnc_removeItemCargo) exitWith {};

                _unit addItem _item;
            }, [_unit, _item, _container], 1] call CBA_fnc_waitAndExecute;

            true
        };

        false
    };
    // Magazine
    case (count _magazines == 1): {
        scopeName "main";

        (_magazines select 0) params ["_magazine", "_ammo"];

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
                    params ["_unit", "_magazine", "_ammo", "_container", "_weapon", "_isSecondaryMagazine"];

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
                            _duration = getNumber (configfile >> "CfgMovesMaleSdr" >> "States" >> _gesture >> "speed");
                        };

                        if (_duration == 0) then {
                            _duration = getNumber (configfile >> "CfgGesturesMale" >> "States" >> _gesture >> "speed");
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
                }, [_unit, _magazine, _ammo, _container, _weapon, _index == 1], 1] call CBA_fnc_waitAndExecute;

                true breakOut "main"
            };
        // Primary, secondary, handgun weapons, binoculars
        } forEach [_loadout select 0, _loadout select 1, _loadout select 2, _loadout select 8];

        // Add to inventory if possible
        if (_unit canAdd _magazine) exitWith {
            _unit action ["TakeMagazine", _container, _magazine];

            true
        };

        false
    };
    // Backpack
    case (count _backpacks == 1): {
        _unit action ["PutBag"];
        _unit action ["AddBag", _container, _backpacks select 0];

        true
    };
    // If not one item
    default {false};
};
