#include "script_component.hpp"

private _condition = {
	params [
		"_target",
		"_player",
		"_args"
	];

	GVAR(settingUserActions) && { !isNull (configFile >> "CfgVehicles" >> typeOf _target >> "UserActions") };
};
private _ace_action = [
	QGVAR(userActions),
	"More",
	"\A3\ui_f\data\gui\cfg\cursors\add_gs.paa",
	{},
	_condition,
	FUNC(user_action_menus)
] call ace_interact_menu_fnc_createAction;

[
	"AllVehicles",
	1,
	["ACE_SelfActions"],
	_ace_action,
	true
] call ace_interact_menu_fnc_addActionToClass;