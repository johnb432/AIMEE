#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *	Adds misc interactions from vehicles to the interaction list.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target", "_player", "_args"];

private _config = configOf _target;

private _run = {
				params ["_target", "_player", "_args"];

				private _savedthis = this;

				this = _target;
				call compileFinal (_args select 0);
				this = _savedthis;
};

private _condition = {
				params ["_target", "_player", "_args"];

				private _savedthis = this;

				this = _target;

				private _return = call compileFinal (_args select 1);

				this = _savedthis;
				_return;
};

private _menus = [];

{
				if (getText (_x >> "shortcut") != "Eject" || {getText (_x >> "shortcut") == "Eject" && "FIR" in (typeOf _target)}) then {
								_menus pushBack [[
												str getNumber (_x >> "userActionID"),
												getText (_x >> "displayName"),
												"",
												_run,
												_condition,
												nil,
												[getText (_x >> "statement"), getText (_x >> "condition")]
								] call ace_interact_menu_fnc_createAction, [], _target];
				};
} forEach ("true" configClasses (_config >> "UserActions"));

_menus;
