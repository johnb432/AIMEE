#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Unit <OBJECT>
	* 1: Vehicle <OBJECT>
	*
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_player", "_vehicle"];

switch (_vehicle call FUNC(gearStatus)) do {
				case GEAR_DOWN: {
								_player action ["LandGearUp", _vehicle];
								[_vehicle, GEAR_RETRACTING] call FUNC(gearStatus);
				};

				case GEAR_UP: {
								_player action ["LandGear", _vehicle];
								[_vehicle, GEAR_EXTENDING] call FUNC(gearStatus);
				};
    
				default {};
};
