#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Target unit <OBJECT>
 *
 * Return Value:
 * Position of where the ACE interaction has to go <ARRAY>
 *
 * Public: No
 */

params ["_target"];

private _spine = _target selectionPosition "spine3";
(((_target selectionPosition "rightshoulder" vectorDiff _spine) vectorCrossProduct (_target selectionPosition "leftshoulder" vectorDiff _spine)) vectorMultiply 4) vectorAdd _spine;
