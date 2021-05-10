#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

[
				"AllVehicles",
				1,
				["ACE_SelfActions"],
    [
    				QGVAR(userActions),
								format [LQSTRING(str_disp_xbox_hint_igui_more_actions), ""],
    				ICON_MORE,
    				{},
    				{
    									params ["_target", "_player", "_args"];

    									GVAR(settingUserActions) && {!isNull (configOf _target >> "UserActions")};
    				},
    				FUNC(userActionMenus)
    ] call ace_interact_menu_fnc_createAction,
				true
] call ace_interact_menu_fnc_addActionToClass;
