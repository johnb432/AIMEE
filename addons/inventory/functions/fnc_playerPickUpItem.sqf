#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Picks a single item from a container and places it in a unit's inventory.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Container <OBJECT>
 * 2: Item <STRING>
 * 3: Container classname <STRING>
 * 4: Container <OBJECT>
 *
 * Return Value:
 * Returns if the item was picked up or not  <BOOL>
 *
 * Example:
 * [player, cursorObject, "FirstAidKit"] call AIMEE_inventory_fnc_playerPickupItem
 *
 * Public: No
 */

scopeName "main";

params ["_unit", "_container", "_item", "_firstContainerClassname", "_firstContainer"];

private _description = (_item call ace_common_fnc_getItemType) select 1;

// Equip face wear, head gear, uniform and vest if possible
// Head gear
if (headgear _unit == "" && {_description == "headgear"}) exitWith {
    _unit playAction "PutDown";

    [{
        params ["_unit", "_item", "_container"];

        // If item couldn't be removed, it means it was deleted before; Don't continue
        if !([_container, _item] call CBA_fnc_removeItemCargo) exitWith {};

        // Add head gear
        _unit addHeadgear _item;
    }, [_unit, _item, _container], 1] call CBA_fnc_waitAndExecute;

    true
};
// Face wear
if (goggles _unit == "" && {_description == "goggles"}) exitWith {
    _unit playAction "PutDown";

    [{
        params ["_unit", "_item", "_container"];

        // If item couldn't be removed, it means it was deleted before; Don't continue
        if !([_container, _item] call CBA_fnc_removeItemCargo) exitWith {};

        // Add goggles
        _unit addGoggles _item;
    }, [_unit, _item, _container], 1] call CBA_fnc_waitAndExecute;

    true
};

private _containerIndex = ["uniform", "vest"] findIf {_description == _x};

// Uniform & vest
if (_containerIndex != -1) exitWith {
    if (([uniform _unit, vest _unit] select _containerIndex) == "") then {
        _unit playAction "PutDown";

        [{
            params ["_unit", "_firstContainerClassname", "_container", "_containerIndex", "_weaponItemsCargo", "_magazinesAmmoCargo", "_itemCargo"];
            _itemCargo params ["_items", "_itemsCount"];

            // If item couldn't be removed, it means it was deleted before; Don't continue
            if !([_container, _firstContainerClassname] call CBA_fnc_removeItemCargo) exitWith {};

            // Add item
            _container = switch (_containerIndex) do {
                case 0: {
                    _unit forceAddUniform _firstContainerClassname;

                    uniformContainer _unit
                };
                case 1: {
                    _unit addVest _firstContainerClassname;

                    vestContainer _unit
                };
            };

            // Remove any linked items
            clearWeaponCargoGlobal _container;
            clearMagazineCargoGlobal _container;
            clearItemCargoGlobal _container;
            clearBackpackCargoGlobal _container;

            // Add previous container content
            {
                _container addWeaponWithAttachmentsCargoGlobal [_x, 1];
            } forEach _weaponItemsCargo;

            {
                _container addMagazineAmmoCargo [_x select 0, 1, _x select 1];
            } forEach _magazinesAmmoCargo;

            {
                _container addItemCargoGlobal [_x, _itemsCount select _forEachIndex];
            } forEach _items;
        }, [_unit, _firstContainerClassname, _container, _containerIndex, weaponsItemsCargo _firstContainer, magazinesAmmoCargo _firstContainer, getItemCargo _firstContainer], 1] call CBA_fnc_waitAndExecute;

        true
    } else {
        // Add to inventory if possible
        if (_unit canAdd _firstContainerClassname && {load _firstContainer == 0}) exitWith {
            _unit playAction "PutDown";

            [{
                params ["_unit", "_firstContainerClassname", "_container"];

                // If item couldn't be removed, it means it was deleted before; Don't continue
                if !([_container, _firstContainerClassname] call CBA_fnc_removeItemCargo) exitWith {};

                _unit addItem _firstContainerClassname;
            }, [_unit, _firstContainerClassname, _container], 1] call CBA_fnc_waitAndExecute;

            true
        };

        false
    };
};

// Add item to inventory if possible
if (load _firstContainer == 0) exitWith {
    private _loadout = getUnitLoadout _unit;

    if (_description == "gps") then {
        _description = "uav_terminal"
    };

    if (_description == "hmd") then {
        _description = "nvgoggles"
    };

    // Check if the assignedItems slot for item is empty
    {
        if (_x == _description) exitWith {
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
    } forEach ["map", "uav_terminal", "radio", "compass", "watch", "nvgoggles"];

    // Check if weapons have space for item
    {
        if (_x == _description) exitWith {
            private _attachmentIndex = _forEachIndex;

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
            } forEach [_loadout select 0, _loadout select 1, _loadout select 2, _loadout select 8]; // Primary, secondary, handgun weapons, binoculars
        };
    } forEach ["optics", "flashlight", "muzzle", "under"];

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

// If not possible, open container
false
