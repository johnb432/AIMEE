#include "script_component.hpp"

params [
	"_target",
	"_player",
	"_args"
];

GVAR(settingTurnOutAction) && { isTurnedOut _player } && { "TurnOut" call EFUNC(main,ignore_keybind_for_input_action) };