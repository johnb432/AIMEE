#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Unit <OBJECT>
 * 2: Arguments <ARRAY>
 *
 * Return Value:
 * Returns menus <ARRAY>
 *
 * Public: No
 */

params ["_target", "_player", "_args"];

private _menus = [];
private _icons = [ICON_FLAPS_0, ICON_FLAPS_1, ICON_FLAPS_2];
private _texts = ["Retracted", "Extended 1", "Extended 2"];

for "_i" from 0 to FLAPS_MAX do {
    _menus pushBack [[
        format [QGVAR(flapsAction%1), _turretPath],
        _texts select _i,
        _icons select _i,
        {[_this select 0, _this select 2] call FUNC(flapsDown)},
        {true},
        nil,
        _i
    ] call ace_interact_menu_fnc_createAction, [], _target];
};

_menus;
