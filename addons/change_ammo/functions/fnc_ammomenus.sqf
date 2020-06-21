#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Target vehicle <OBJECT>
 * 1: Player who is in vehicle <OBJECT>
 * 2: Arguments passed on to loadMagazine if vehicle <ARRAY, STRING, STRING> for player it is
 *
 * Return Value:
 * All interaction submenus for all ammo types for a given class of vehicle <ARRAY>
 *
 * Example:
 *
 *
 * Public: No
 */

params [
	"_target",
	"_player",
	"_args"
];

private _is_vehicle = _target != _player;
private _turret = if (_is_vehicle) then {
	_player call CBA_fnc_turretPath
} else {
	[]
};
private _state = if (_is_vehicle) then {
	weaponState [_target, _turret]
} else {
	weaponState _target
};

private _magList = [];
private _weap = _state select 0;
private _owned = if (_is_vehicle) then {
	_target magazinesTurret _turret
}
else {
	magazines _target
};

private _search = if (_is_vehicle && {(_state select 1) == "HE" || {(_state select 1) == "AP"}}) then {
	true;
} else {
	false;
};

private _compatMags = [_weap, _search] call CBA_fnc_compatibleMagazines;

private _allowed = if ((_state select 0 != _state select 1) && {!_search}) then {
	[_state select 0, _state select 1] call FUNC(magazines);
} else {
	[];
};

//Bypassing broken configs: DO NOT CHANGE ORDER OF AMMO. THEY MUST BE AT THE SAME INDEX IN BOTH ARRAYS
private _wrongConfigs = 	[
		/*40mm*/							"rhs_mag_M4009", "rhs_mag_M661_green", "rhs_mag_M662_red", "rhs_mag_M713_red", "rhs_mag_M714_white", "rhs_mag_M715_green", "rhs_mag_M716_yellow",
													"ACE_40mm_flare_white", "ACE_40mm_flare_green", "ACE_40mm_flare_red", "ACE_40mm_flare_ir"];

private _correctConfigs = [
		/*40mm*/							"rhs_mag_m4009", "rhs_mag_m661_green", "rhs_mag_m662_red", "rhs_mag_m713_Red", "rhs_mag_m714_White", "rhs_mag_m715_Green", "rhs_mag_m716_yellow",
													"ACE_40mm_Flare_white", "ACE_40mm_Flare_green", "ACE_40mm_Flare_red", "ACE_40mm_Flare_ir"];

{
	if (_x in _allowed) then {
		_allowed set [_allowed find _x, _correctConfigs select _forEachIndex];
	};
} forEach _wrongConfigs;

//if UGL/underslung, _allowed will not be overwritten
if (_is_vehicle || {_state select 0 == _state select 1}) then {
  _allowed = _compatMags;
};

private _menus = [];
private _vehicle_exec = {
	params [
		"_target",
		"_player",
		"_args"
	];

	// For RHS vehicles: All IFVs have different muzzles than the weapon name. To reload RHS guns, you need to apply loadMagazine to the muzzle.
	private _Turret = _player call CBA_fnc_turretPath;
	private _State = weaponState [_target, _Turret];
	private _muzzle = _State select 1;

	if (_muzzle == "HE" || {_muzzle == "AP"}) then {
		_args set [1, _muzzle];
	};

	_target loadMagazine _args;
};
private _man_exec = {
	params [
		"_target",
		"_player",
		"_args"
	];
	GVAR(reloadStarted) = true;
	[_target, _args select 0, _args select 1] call FUNC(loadmag);
};

// make this O(not n^2) later maybe?
_owned = _owned call CBA_fnc_getArrayElements;
for [{ _i = 0 }, { _i < count _owned}, { _i = _i + 2 }] do {
	private _class = _owned select _i;
	private _num = _owned select (_i + 1);

	if (_class in _allowed && { _class != _state select 3 }) then {
		private _config = configFile >> "CfgMagazines" >> _class;
		private _text = getText (_config >> "displayName");
		private _submenu = [
			_text, //Action name
			if (_is_vehicle) then { //Name of action shown in menu
				_text
			} else {
				format ["%1 (%2 left)", _text, _num]
			},
			getText (_config >> "picture"), //Icon
			if (_is_vehicle) then { //Statement
				_vehicle_exec
			} else {
				_man_exec
			},
			{ //Condition
				GVAR(reloadFinished) && !ace_common_isReloading
			},
			nil,
			if (_is_vehicle) then {
				[_turret, _state select 0, _class]
			}
			else {
				[_state select 0, _class]
			},
			nil,
			nil,
			nil,
			nil
		] call ace_interact_menu_fnc_createAction;

		_menus pushBack [_submenu, [], _target];
	};
};
_menus;