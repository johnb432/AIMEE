#include "script_component.hpp"

params [
	"_target",
	"_player",
	"_args"
];

GVAR(settingTurnOutAction) && { _player != vehicle _player } && { !isTurnedOut _player } && { "TurnOut" call EFUNC(main,ignore_keybind_for_input_action) } && { [_player, vehicle _player] call FUNC(can_turnout) };