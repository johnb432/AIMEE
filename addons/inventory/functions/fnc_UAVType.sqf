#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Returns the type of UAV that a backpack can set up.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Returns what type of UAV can be assembled from backpack <STRING>
 *
 * Example:
 * player call AIMEE_inventory_fnc_UAVType
 *
 * Public: No
 */

params ["_unit"];

private _backpack = backpackContainer _unit;

if (isNull _backpack) exitWith {
    "" // return
};

private _config = configOf _backpack >> "assembleInfo";

// Ignore static weapons
if (isNull _config || {isArray (_config >> "base")}) exitWith {
    "" // return
};

getText (_config >> "assembleTo") // return
