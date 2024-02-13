#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Makes menus for changing seats.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * All interaction submenus for all seat changing for a given class of vehicle <ARRAY>
 *
 * Example:
 * [vehicle player, player] call AIMEE_vehicle_seats_fnc_changeMenus
 *
 * Public: No
 */

params ["_target", "_unit"];

private _outside = isNull objectParent _unit;
private _prefix = ["MoveTo", "GetIn"] select _outside;
private _vehicle = [objectParent _unit, _target] select _outside;
private _menus = [];

// Gets all seats of the various types below
(["driver", "commander", "gunner", "turret", "cargo"] apply {
    fullCrew [_vehicle, _x, true];
}) params ["_drivers", "_commanders", "_gunners", "_turrets", "_cargos"];

if (_drivers isNotEqualTo [] && {[_unit, _vehicle, _drivers select 0] call FUNC(canSwitch)}) then {
    _menus pushBack [[
        QGVAR(driverAction),
        [TEXT_DRIVER, TEXT_PILOT] select (_vehicle isKindOf "Air"),
        [ICON_DRIVER, ICON_PILOT] select (_vehicle isKindOf "Air"),
        {_player action (_this select 2)},
        {true},
        nil,
        [_prefix + "Driver", _vehicle]
    ] call ace_interact_menu_fnc_createAction, [], _vehicle];
};

if (_commanders isNotEqualTo [] && {[_unit, _vehicle, _commanders select 0] call FUNC(canSwitch)}) then {
   _menus pushBack ([_vehicle, _prefix, _commanders select 0, ICON_COMMANDER] call FUNC(turretMenus));
};

if (_gunners isNotEqualTo [] && {[_unit, _vehicle, _gunners select 0] call FUNC(canSwitch)}) then {
   _menus pushBack ([_vehicle, _prefix, _gunners select 0, ICON_GUNNER] call FUNC(turretMenus));
};

{
    if ([_unit, _vehicle, _x] call FUNC(canSwitch)) then {
        _menus pushBack ([_vehicle, _prefix, _x, ICON_TURRET] call FUNC(turretMenus));
    };
} forEach _turrets;

{
    if ([_unit, _vehicle, _x] call FUNC(canSwitch)) exitWith {
        _menus pushBack [[
            QGVAR(cargoAction),
            TEXT_CARGO,
            ICON_CARGO,
            {_player action (_this select 2)},
            {true},
            nil,
            [_prefix + "Cargo", _vehicle, _x select 2]
        ] call ace_interact_menu_fnc_createAction, [], _vehicle];
    };
} forEach _cargos;

_menus
