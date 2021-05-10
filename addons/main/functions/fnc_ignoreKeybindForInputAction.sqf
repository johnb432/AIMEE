#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Keystroke <STRING>
 *
 * Return Value:
 * Returns to show action or not <BOOL>
 *
 * Public: No
 */

params ["_inputAction"];

!EGVAR(main,settingHide) || {isNil {[_inputAction] call FUNC(keybindName)}};
