#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: <OBJECT>
 * 1: Player <OBJECT>
 * 2:
 *
 * Return Value:
 * None
 *
 * Example:
 *
 *
 * Public: No
 */

private _run = {
	params [
		"_target",
		"_player",
		"_args"
	];

	private _group = group _player;

	[_player] joinSilent grpNull;
	[_player] joinSilent _group;
};
private _condition = {
	params [
		"_target",
		"_player",
		"_args"
	];

	GVAR(settingDropLeaderAction) && { leader group _player == _player } && { count units group _player > 1 };
};
private _ace_action = [
	QGVAR(dropLeaderAction),
	"Step down as leader",
	"\A3\ui_f\data\gui\cfg\ranks\private_gs.paa",
	_run,
	_condition
] call ace_interact_menu_fnc_createAction;

[
	"CAManBase",
	1,
	["ACE_SelfActions", "ACE_TeamManagement"],
	_ace_action,
	true
] call ace_interact_menu_fnc_addActionToClass;