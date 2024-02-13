#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Toggles the landing gear.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, vehicle player] call AIMEE_vehicle_controls_fnc_toggleGear;
 *
 * Public: No
 */

params ["_unit", "_vehicle"];

switch (_vehicle call FUNC(gearStatus)) do {
    case GEAR_DOWN: {
        _unit action ["LandGearUp", _vehicle];
        [_vehicle, GEAR_RETRACTING] call FUNC(gearStatus);
    };
    case GEAR_UP: {
        _unit action ["LandGear", _vehicle];
        [_vehicle, GEAR_EXTENDING] call FUNC(gearStatus);
    };
    default {};
};
