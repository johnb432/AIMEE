#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Adds misc interactions from vehicles to the interaction list.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * vehicle player call AIMEE_vehicle_controls_fnc_userActionMenus;
 *
 * Public: No
 */

params ["_target"];

private _config = configOf _target;
private _actions = "true" configClasses (_config >> "UserActions");

if (_actions isEqualTo []) exitWith {[]};

// this is used instead of target in vanilla user actions
private _run = {
    params ["_target", "", "_args"];

    private _savedThis = this;

    this = _target;
    call compileFinal (_args select 0);
    this = _savedThis;
};

private _condition = {
    params ["_target", "", "_args"];

    private _savedThis = this;

    this = _target;
    private _return = call compileFinal (_args select 1);
    this = _savedThis;

    _return;
};

private _menus = [];

{
    // Eject for Firewill plane ejection
    if (getText (_x >> "shortcut") != "Eject" || "FIR" in (typeOf _target)) then {
        _menus pushBack [[
            format [QGVAR(userAction_%1), getNumber (_x >> "userActionID")],
            getText (_x >> "displayName"),
            "",
            _run,
            _condition,
            nil,
            [getText (_x >> "statement"), getText (_x >> "condition")]
        ] call ace_interact_menu_fnc_createAction, [], _target];
    };
} forEach _actions;

_menus;
