#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target", "_player"];

{
   	if ([_player, _target, _x] call FUNC(canSwitch)) exitWith {
      		_x params ["_occupant", "_role", "_cargoIndex", "_turretPath", "_isPerson"];

      		switch (_role) do {
         			case "driver": {
         				   _player action ["GetInDriver", _target];
         			};
         			case "gunner";
         			case "commander";
         			case "turret": {
         				   _player action ["GetInTurret", _target, _turretPath];
         			};
         			case "cargo": {
         				   _player action ["GetInCargo", _target];
         			};
         			default {};
      		};
   	};
} forEach fullCrew [_target, "", true];
