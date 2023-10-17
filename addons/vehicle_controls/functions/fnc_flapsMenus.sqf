#include "..\script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Makes menus for flaps.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Returns menus <ARRAY>
 *
 * Example:
 * [vehicle player, 2] call AIMEE_vehicle_controls_fnc_flapsMenus
 *
 * Public: No
 */

private _menus = [];
private _icons = [ICON_FLAPS_0, ICON_FLAPS_1, ICON_FLAPS_2];
private _texts = ["Retracted", "Extended 1", "Extended 2"];
private _text = "";

for "_i" from 0 to FLAPS_MAX do {
    _text = _texts select _i;

    _menus pushBack [[
        format [QGVAR(flapsAction_%1), _text],
        _text,
        _icons select _i,
        {[_this select 0, _this select 2] call FUNC(flapsDown)},
        {true},
        nil,
        _i
    ] call ace_interact_menu_fnc_createAction, [], _this];
};

_menus
