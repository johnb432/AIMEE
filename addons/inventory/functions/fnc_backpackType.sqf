#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Returns the types of backpack that a UAV can be disassembled into.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Returns what type of UAV can be disassembled into backpack <ARRAY>
 *
 * Example:
 * player call AIMEE_uav_terminal_fnc_backpackType
 *
 * Public: No
 */

if (isNull _this) exitWith {[]};

private _config = configOf _backpack >> "assembleInfo";

if (isNull _config) exitWith {[]};

getArray (_config >> "dissasembleTo")
