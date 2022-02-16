#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Returns if a unit can turn in or out.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 * 2: Type <STRING>
 *
 * Return Value:
 * Can turn in or out <BOOL>
 *
 * Example:
 * [player, vehicle player, "TurnIn"] call AIMEE_vehicle_seats_fnc_canTurnInOrOut
 *
 * Public: No
 */

//AIMEE_vehicle_seats_fnc_canTurnInOrOut = {
params ["_unit", "_vehicle", "_type"];

_type = toLower _type;

if !(_type in ["turnin", "turnout"]) exitWith {
    false;
};

private _condition = isTurnedOut _unit;

if (_type isEqualTo "turnout") then {
    _condition = !_condition;
};

if (!_condition) exitWith {
    false;
};

private _fullCrew = fullCrew _vehicle;
private _index = _fullCrew findIf {(_x select 0) isEqualTo _unit};

// If unit is in a FFV turret, check if can turn in/out
if (_index isNotEqualTo -1 && {(_fullCrew select _index) select 4}) then {
    _condition = getText ([_vehicle, _vehicle unitTurret _unit] call CBA_fnc_getTurret >> "personTurretAction") isNotEqualTo "";
};

_condition && {_unit call ace_common_fnc_hasHatch};

//};
