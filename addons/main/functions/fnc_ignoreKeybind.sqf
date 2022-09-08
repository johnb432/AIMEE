#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Returns to show action or not.
 *
 * Arguments:
 * 0: Keystroke <STRING>
 *
 * Return Value:
 * Show action <BOOL>
 *
 * Example:
 * "headlights" call AIMEE_main_fnc_ignoreKeybind
 *
 * Public: No
 */

!(GVAR(settingHide) && {!isNil {
    // Gets rid of the Engine off/on interaction if ACE Keybinds for turning engine off and on are bound.
    if (_this isEqualTo "engineControlACE") then {
        if (((["ACE3 Vehicles", "ace_weaponselect_EngineOn"] call CBA_fnc_getKeybind) select 5 select 0) == -1 || {((["ACE3 Vehicles", "ace_weaponselect_EngineOff"] call CBA_fnc_getKeybind) select 5 select 0) == -1}) then {
            nil;
        } else {
            "aceEngineKeybinds";
        };
    } else {
        (actionKeysNamesArray [_this, 1]) select 0;
    };
}});
