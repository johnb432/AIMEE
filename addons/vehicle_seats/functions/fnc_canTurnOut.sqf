#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * Returns if a person can turn out <BOOL>
 *
 * Public: No
 */

params ["_unit", "_vehicle"];

private _config = configOf _vehicle;
private _fullCrew = fullCrew _vehicle;
private _index = _fullCrew findIf {_x select 0 isEqualTo _unit};

if (_index isEqualTo -1) exitWith {
    false;
};

(_fullCrew select _index) params ["_occupant", "_role", "_cargoIndex", "_path"];

if (_role isEqualTo "driver") exitWith {
    getNumber (_config >> "forceHideDriver") isEqualTo 0 && {getNumber (_config >> "hideProxyInCombat") isEqualTo 1};
};

if (_path isNotEqualTo []) exitWith {
    private _turret = [_config, _path] call CBA_fnc_getTurret;

    getNumber (_turret >> "forceHideGunner") isEqualTo 0 && {(getText (_turret >> "gunnerAction")) find "out" isNotEqualTo -1};
};

false;
