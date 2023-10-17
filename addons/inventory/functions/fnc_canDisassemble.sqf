#include "..\script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Returns if weapon can be disassembled.
 *
 * Arguments:
 * 0: Vehicle (Static Weapon) <OBJECT>
 *
 * Return Value:
 * If weapon can be disassembled <BOOL>
 *
 * Example:
 * cursorObject call AIMEE_inventory_fnc_canDisassemble
 *
 * Public: No
 */

private _config = configOf _this >> "assembleInfo";

!isNull _config && {getArray (_config >> "dissasembleTo") isNotEqualTo []}
