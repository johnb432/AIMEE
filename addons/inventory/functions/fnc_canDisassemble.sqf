#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Returns if weapon can be disassembled by unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle (Static Weapon) <OBJECT>
 *
 * Return Value:
 * If weapon can be disassembled <BOOL>
 *
 * Example:
 * [player, cursorObject] call AIMEE_inventory_fnc_canDisassemble
 *
 * Public: No
 */

params ["_unit", "_vehicle"];

// Check if disabled via commands
if !(weaponDisassemblyEnabled _unit && weaponDisassemblyEnabled _vehicle) exitWith {false};

private _config = configOf _vehicle >> "assembleInfo";

// Check if not possible
if (isNull _config || {getArray (_config >> "dissasembleTo") isEqualTo []}) exitWith {false};

private _crew = crew _vehicle;

// If vehicle is empty, quit
if (_crew isEqualTo []) exitWith {true};

private _sideUnit = side group _unit;

(_crew select {!unitIsUAV _x}) findIf { // ignore UAV units
    // Units must all be unconscious, captive or friendly (side group is used in case unit is captive/unconscious) for actions to show up
    !captive _x && {lifeState _x in ["HEALTHY", "INJURED"]} && {[_sideUnit, side group _x] call BIS_fnc_sideIsEnemy}
} == -1
