params [
	"_input_action"
];

if (_input_action == "engineControlACE") exitWith { //gets rid of the Engine off/on interaction if ACE Keybinds for turning engine off and on are bound.
	private _keybindOn = (["ACE3 Vehicles", "ace_weaponselect_EngineOn"] call CBA_fnc_getKeybind) select 5 select 0;
	private _keybindOff = (["ACE3 Vehicles", "ace_weaponselect_EngineOff"] call CBA_fnc_getKeybind) select 5 select 0;
	private _return = "aceEngineKeybinds";
 	if (_keybindOn == -1 || { _keybindOff == -1 }) then {
		_return = nil;
 	};
	_return
};

(actionKeysNamesArray [_input_action, 1]) select 0;