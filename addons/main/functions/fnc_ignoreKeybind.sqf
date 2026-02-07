#include "..\script_component.hpp"
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

params ["_type"];

!GVAR(settingHide) || {
    // Show Engine off/on interaction if ACE Keybinds for turning engine off and on are unbound
    if (_type == "engineControlACE") then {
        private _engineOff = ["ACE3 Vehicles", "ace_weaponselect_EngineOff"] call CBA_fnc_getKeybind;
        private _engineOn = ["ACE3 Vehicles", "ace_weaponselect_EngineOn"] call CBA_fnc_getKeybind;

        // If both keybinds don't exist, show
        if (isNil "_engineOff" && isNil "_engineOn") exitWith {
            true // return
        };

        if (!isNil "_engineOff") then {
            (_engineOff select 8) isEqualTo [] // return
        } else {
            (_engineOn select 8) isEqualTo [] // return
        };
    } else {
        // Vanilla keybinds
        (actionKeysNamesArray [_type, 1]) isEqualTo [] // return
    };
}
