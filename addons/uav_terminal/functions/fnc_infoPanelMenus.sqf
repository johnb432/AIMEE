#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Unit <OBJECT>
 * 2: Component <STRING>
 *
 * Return Value:
 * Returns menu <ARRAY>
 *
 * Public: No
 */

params ["_target", "_player", "_component"];

["left", "right"] apply {
   	[[
        format [QGVAR(infoPanelAction%1), _x],
      		DEFAULT_TEXT,
      		"",
        {
           	params ["_target", "_player", "_args"];
           	_args params ["_id", "_component"];

           	{
              		if ([_x, _component] call FUNC(panelOpened)) then {
              			   setInfoPanel [_x, "EmptyDisplayComponent"];
              		} else {
                    if (_id isEqualTo _x) then {
                        setInfoPanel [_id, _component];
                    };
                };
           	} forEach ["left", "right"];
        },
      		{true},
      		nil,
      		[_x, _component],
      		nil,
      		nil,
      		nil,
        {
           	params ["_target", "_player", "_args", "_menu"];
           	_args params ["_id", "_component"];

           	private _opened = _args call FUNC(panelOpened);

           	_menu set [1, [[TEXT_RIGHT, TEXT_LEFT] select (_id isEqualTo "left"), [TEXT_CLOSE_RIGHT, TEXT_CLOSE_LEFT] select (_id isEqualTo "left")] select _opened];
           	_menu set [2, [ICON_OFF, ICON_ON] select _opened];
        }
   	] call ace_interact_menu_fnc_createAction, [], _target];
};
