#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_vehicle"];

switch ([_unit, _vehicle] call FUNC(canEject)) do {
   	case EJECT_TYPE_JET: {
   		   [_vehicle] call BIS_fnc_PlaneEjection;
   	};

   	case EJECT_TYPE_CAR: {
   		   _unit action ["Eject", _vehicle];
   	};

   	case EJECT_TYPE_FORCE: {
      		private _engineOn = _unit isEqualTo driver _vehicle && {isEngineOn _vehicle};

      		moveOut _unit;

      		if (_engineOn) then {
      			   _vehicle engineOn true;
      		};
   	};
   	default {};
};
