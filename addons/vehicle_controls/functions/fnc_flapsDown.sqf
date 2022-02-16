#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Assumes all aircraft in Arma 3 have 3-position flaps.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Number of flap changes <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player, 2] call AIMEE_vehicle_controls_fnc_flapsDown
 *
 * Public: No
 */

params ["_vehicle"];

for "_i" from 1 to FLAPS_MAX do {
    _vehicle action ["FlapsUp", _vehicle];
};

for "_i" from 1 to (_this select 1) do {
    _vehicle action ["FlapsDown", _vehicle];
};
