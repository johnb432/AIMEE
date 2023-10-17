#include "..\script_component.hpp"

/*
 * Author: johnb43, upsilon
 * Take one item from a container. Requires 1 (no more, no less) of an item to be able to be picked up.
 * Weapons are handled by ACE.
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

private _items = itemCargo _container;
private _magazines = magazinesAmmo _container;
private _backpacks = backpackCargo _container;
(everyContainer _container) param [0, ["", objNull]] params ["_firstContainerClassname", "_firstContainer"];

switch (true) do {
    // Item
    case (count _items == 1): {
        [_unit, _container, _items select 0, _firstContainerClassname, _firstContainer] call FUNC(playerPickupItem)
    };
    // Magazine
    case (count _magazines == 1): {
        [_unit, _container, _magazines select 0] call FUNC(playerPickupMagazine)
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
