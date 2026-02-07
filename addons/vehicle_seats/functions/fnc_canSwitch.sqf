#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Returns if a unit can switch to given seat.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 * 2: Seat <ARRAY>
 *  2.0: Occupant <OBJECT>
 *  2.1: Role <STRING>
 *  2.2: Cargo Index <NUMBER>
 *  2.3: Turret <ARRAY>
 *
 * Return Value:
 * Can switch <BOOL>
 *
 * Example:
 * [player, vehicle player, [player, "driver", nil, [-1]]] call AIMEE_vehicle_seats_fnc_canSwitch
 *
 * Public: No
 */

// _seat is an array returned by fullCrew
params ["_unit", "_vehicle", "_seat"];
_seat params ["_occupant", "_role", "_cargoIndex", "_turretPath"];

// Fails if current occupant can't be booted
if (alive _occupant && {isPlayer _occupant || {unitIsUAV _occupant} || {isNull objectParent _unit}}) exitWith {
    false // return
};

// Various other restrictions
switch (_role) do {
    case "driver": {
        !(lockedDriver _vehicle) && {getNumber (configOf _vehicle >> "hasDriver") == 1} // return
    };
    case "gunner";
    case "commander";
    case "turret": {
        !(_vehicle lockedTurret _turretPath) && {getNumber ([_vehicle, _turretPath] call CBA_fnc_getTurret >> "hasGunner") == 1} // return
    };
    case "cargo": {
        !(_vehicle lockedCargo _cargoIndex) // return
    };
    default {
        false // return
    };
};
