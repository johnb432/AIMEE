#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Makes menus for changing seats in turrets.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Prefix <STRING>
 * 2: Seat <ARRAY>
 * 3: Icon <STRING>
 *
 * Return Value:
 * All interaction submenus for all seat changing for a given class of vehicle <ARRAY>
 *
 * Example:
 * [vehicle player, "GetIn", [player, "driver", nil, [-1]], "A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa"] call AIMEE_vehicle_seats_fnc_turretMenus
 *
 * Public: No
 */

params ["_vehicle", "_prefix", "_seat", "_icon"];

private _turretPath = _seat select 3;
private _turretConfig = [_vehicle, _turretPath] call CBA_fnc_getTurret;

if (getNumber (_turretConfig >> "isCopilot") != 0) then {
    _icon = ICON_PILOT;
};

if (_turretPath in (_vehicle call ace_common_fnc_getTurretsFFV)) then {
    _icon = ICON_FFV;
};

[[
    format [QGVAR(turretAction_%1), _turretPath],
    getText (_turretConfig >> "gunnerName"),
    _icon,
    {_player action (_this select 2)},
    {true},
    nil,
    [_prefix + "Turret", _vehicle, _turretPath]
] call ace_interact_menu_fnc_createAction, [], _vehicle];
