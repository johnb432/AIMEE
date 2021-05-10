#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *	Assumes all aircraft in Arma 3 have 3-position flaps.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Number of flap changes <INTEGER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_vehicle", "_numNotches"];

for "_i" from 1 to FLAPS_MAX do {
				_vehicle action ["FlapsUp", _vehicle];
};

for "_i" from 1 to _numNotches do {
				_vehicle action ["FlapsDown", _vehicle];
};
