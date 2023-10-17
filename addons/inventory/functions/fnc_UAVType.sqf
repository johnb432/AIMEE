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
 * player call AIMEE_uav_terminal_fnc_UAVType
 *
 * Public: No
 */

private _backpack = backpackContainer _this;

if (isNull _backpack) exitWith {""};

private _config = configOf _backpack >> "assembleInfo";

// Ignore static weapons
if (isNull _config || {isArray (_config >> "base")}) exitWith {""};

getText (_config >> "assembleTo")
