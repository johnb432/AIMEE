#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Keystroke <STRING>
 *
 * Return Value:
 * Returns actions assigned to key <ARRAY>
 *
 * Public: No
 */

params ["_inputAction"];

if (_inputAction == "engineControlACE") exitWith { //gets rid of the Engine off/on interaction if ACE Keybinds for turning engine off and on are bound.
   	private _keybindOn = (["ACE3 Vehicles", "ace_weaponselect_EngineOn"] call CBA_fnc_getKeybind) select 5 select 0;
   	private _keybindOff = (["ACE3 Vehicles", "ace_weaponselect_EngineOff"] call CBA_fnc_getKeybind) select 5 select 0;
   	private _return = "aceEngineKeybinds";

   	if (_keybindOn isEqualTo -1 || {_keybindOff isEqualTo -1}) then {
  		   _return = nil;
   	};

   	_return;
};

(actionKeysNamesArray [_inputAction, 1]) select 0;
