#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * All interaction submenus for all seat changing for a given class of vehicle <ARRAY>
 *
 * Public: No
 */

params ["_target", "_player"];

private _outside = isNull objectParent _player;
private _prefix = ["MoveTo", "GetIn"] select _outside;
private _vehicle = [objectParent _player, _target] select _outside;
private _subMenus = [];

// Gets all seats of the various types below
(["driver", "commander", "gunner", "turret", "cargo"] apply {
	   fullCrew [_vehicle, _x, true];
}) params ["_drivers", "_commanders", "_gunners", "_turrets", "_cargos"];

private _subMenuForTurret = {
   	params ["_seat", "_icon"];

   	private _turretPath = _seat select 3;

   	[[
      		format [QGVAR(turretAction%1), _turretPath],
      		getText ([_vehicle, _turretPath] call CBA_fnc_getTurret >> "gunnerName"),
      		_icon,
      		{_player action (_this select 2)},
      		{true},
      		nil,
      		[_prefix + "Turret", _vehicle, _turretPath]
   	] call ace_interact_menu_fnc_createAction, [], _vehicle];
};

if (_drivers isNotEqualTo [] && {[_player, _vehicle, _drivers select 0] call FUNC(canSwitch)}) then {
   	_subMenus pushBack [[
      		QGVAR(driverAction),
      		[TEXT_DRIVER, TEXT_PILOT] select (_vehicle isKindOf "Air"),
      		[ICON_DRIVER, ICON_PILOT] select (_vehicle isKindOf "Air"),
      		{_player action (_this select 2)},
      		{true},
      		nil,
      		[_prefix + "Driver", _vehicle]
   	] call ace_interact_menu_fnc_createAction, [], _vehicle];
};

if (_commanders isNotEqualTo [] && {[_player, _vehicle, _commanders select 0] call FUNC(canSwitch)}) then {
	   _subMenus pushBack ([_commanders select 0, ICON_COMMANDER] call _subMenuForTurret);
};

if (_gunners isNotEqualTo [] && {[_player, _vehicle, _gunners select 0] call FUNC(canSwitch)}) then {
	   _subMenus pushBack ([_gunners select 0, ICON_GUNNER] call _subMenuForTurret);
};

{
   	if ([_player, _vehicle, _x] call FUNC(canSwitch)) then {
   					_subMenus pushBack ([_x, ICON_GUNNER] call _subMenuForTurret);
   	};
} forEach _turrets;

{
   	if ([_player, _vehicle, _x] call FUNC(canSwitch)) exitWith {
      		_subMenus pushBack [[
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

_subMenus;
