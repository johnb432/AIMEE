#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Vehicle <OBJECT>
 * 2: Seat <STRING>
 *
 * Return Value:
 * Returns if a person can switch to given seat <BOOL>
 *
 * Public: No
 */

// _seat is an array returned by fullCrew
params ["_unit", "_vehicle", "_seat"];
_seat params ["_occupant", "_role", "_cargoI", "_turretPath", "_isPerson"];

// Fails if current occupant can't be booted
if (!isNull _occupant && {
   	if (isPlayer _occupant || isNull objectParent _player) then {
        true
    } else {
   		   getText (configOf _occupant >> "simulation") == "UAVPilot";
   	};
}) exitWith {false};

// Various other restrictions
switch (_role) do {
   	case "driver": {
   		   getNumber (configOf _vehicle >> "hasDriver") isEqualTo 1;
   	};
   	case "gunner";
   	case "commander";
   	case "turret": {
      		getNumber ([_vehicle, _turretPath] call CBA_fnc_getTurret >> "hasGunner") isEqualTo 1;
   	};
   	case "cargo": {
   		   true;
   	};
   	default {
   		   false;
   	};
};
