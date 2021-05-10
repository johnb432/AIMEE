#include "script_component.hpp"
/*
 * Author: upsilon
 * Assumes all vtols in arma 3 have 6-position vectoring
 *
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
	* 1: Number of changes in vectoring <INTEGER>
	*
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_vehicle", "_n_notches"];

private _current = round (VECTORING_MAX * (_vehicle call FUNC(guessVectoring)));

// Missing stuff
