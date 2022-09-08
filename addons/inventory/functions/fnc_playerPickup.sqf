#include "script_component.hpp"

/*
 * Author: upsilon
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
    case (count _weapons == 1): {
        _unit action ["TakeWeapon", _container, _weapons select 0];

        true;
    };

    case (count _items == 1): {
        _items params ["_item"];

        if !(_unit canAdd _item) exitWith {false};

        _unit playAction "PutDown";

        // Add 1s to simulate action length
        [{
            params ["_unit", "_item", "_container"];

            _unit addItem _item;

            if (isClass (configFile >> "CfgPatches" >> "ace_arsenal")) then {
                private _arsenalItems = uiNamespace getVariable ["ace_arsenal_configItems", []];

                // Check if the slot is empty
                {
                    if (_item in _x) exitWith {
                        // If slot empty, assign item to it
                        if ((((getUnitLoadout _unit) select 9) select _forEachIndex) isEqualTo "") then {
                            _unit assignItem _item;
                        };
                    };
                // Map, Terminal, Radio, Compass, Watch, NVG
                } forEach [_arsenalItems select 10, _arsenalItems select 14, _arsenalItems select 12, _arsenalItems select 11, _arsenalItems select 13, _arsenalItems select 8];
            };

            clearItemCargoGlobal _container;
        }, [_unit, _item, _container], 1] call CBA_fnc_waitAndExecute;

        true;
    };

    case (count _magazines == 1): {
        (_magazines select 0) params ["_magazine"];

        if !(_unit canAdd _magazine) exitWith {false};

        _unit action ["TakeMagazine", _container, _magazine];

        true;
    };

    case (count _backpacks == 1): {
        _unit action ["PutBag"];
        _unit action ["AddBag", _container, _backpacks select 0];

        true;
    };

    default {false};
};
