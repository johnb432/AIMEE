#include "script_component.hpp"

params [
	"_target",
	"_player",
	"_args"
];

private _vehicle = vehicle _player;

GVAR(settingGetOutAction) && { _player != _vehicle } && { "GetOut" call EFUNC(main,ignore_keybind_for_input_action) } && { _vehicle call FUNC(can_getout) };