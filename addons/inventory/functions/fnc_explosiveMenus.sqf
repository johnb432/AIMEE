#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Makes all interaction menus for all explosive types for a unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Interaction menu <ARRAY>
 *
 * Example:
 * player call AIMEE_inventory_fnc_explosiveMenus
 *
 * Public: No
 */

params ["_unit"];

// Returns case correct magazines
private _magazines = (magazines [_unit, false]) call CBA_fnc_getArrayElements;

if (_magazines isEqualTo []) exitWith {
    [] // return
};

private _explosives = uiNamespace getVariable ["ace_arsenal_putCache", createHashMap];
private _class = "";
private _config = configNull;
private _cfgMagazines = configFile >> "CfgMagazines";
private _menus = [];

for "_i" from 0 to (count _magazines) - 2 step 2 do {
    _class = _magazines select _i;

    // Find compatible magazines
    if !(_class in _explosives) then {
        continue;
    };

    _config = _cfgMagazines >> _class;

    _menus pushBack [
        [
            format [QGVAR(explosive_%1), _class], // Action name
            format [LQSTRING(str_action_putbomb), getText (_config >> "displayName"), _magazines select (_i + 1)], // Name of action shown in menu
            getText (_config >> "picture"), // Icon
            {
                _player playAction "PutDown";

                [{
                    params ["_unit", "_mineData"];

                    if (!alive _unit) exitWith {};

                    // If magazine couldn't be removed, it means it was deleted before; Don't continue
                    if !([_unit, _mineData select 0] call CBA_fnc_removeMagazine) exitWith {};

                    private _mine = createVehicle [_mineData select 1, _unit, [], 0];
                    _mine setDir (getDir _unit);
                    _mine setPosWorld getPosWorld _mine; // Mine direction needs to be synchronised

                    _unit addOwnedMine _mine;
                    (side group _unit) revealMine _mine;
                }, [_player, _this select 2], 1] call CBA_fnc_waitAndExecute;
            }, // Statement
            {true}, // Condition
            nil,
            [_class, getText (_config >> "ammo")] // Action parameters
        ] call ace_interact_menu_fnc_createAction,
        [],
        _unit
    ];
};

_menus // return
