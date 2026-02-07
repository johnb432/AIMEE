#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Returns if a unit can turn in or out.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 * 2: Type <NUMBER>
 *
 * Return Value:
 * Can turn in or out <BOOL>
 *
 * Example:
 * [player, vehicle player, TURN_IN] call AIMEE_vehicle_seats_fnc_canTurnInOrOut
 *
 * Public: No
 */

params ["_unit", "_vehicle", "_type"];

private _condition = isTurnedOut _unit;

if (_type == TURN_OUT) then {
    _condition = !_condition;
};

if (!_condition) exitWith {
    false // return
};

private _fullCrew = fullCrew _vehicle;
private _index = _fullCrew findIf {(_x select 0) == _unit};

// If unit is in a FFV turret, check if can turn in/out
if (_index != -1 && {(_fullCrew select _index) select 4}) then {
    _condition = getText ([_vehicle, _vehicle unitTurret _unit] call CBA_fnc_getTurret >> "personTurretAction") != "";
};

_condition && {_unit call ace_common_fnc_hasHatch} // return
