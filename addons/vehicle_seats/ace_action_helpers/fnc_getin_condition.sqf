#include "script_component.hpp"

params [
	"_target",
	"_player",
	"_args"
];

GVAR(settingGetInAction) && { vehicle _player == _player } && { locked _target <= 1 } && { !([side _player, side _target] call BIS_fnc_sideIsEnemy) }
&& {
	{
		if ([_player, _target, _x] call FUNC(can_switch)) exitWith { true };
		false;
	} forEach fullCrew [_target, "", true];
};