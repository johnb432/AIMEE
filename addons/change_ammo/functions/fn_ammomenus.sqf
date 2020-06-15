#include "..\macros.hpp"

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

// For RHS Vehicles: First it iterates over given magazineWells, as those contain all the ammo RHS vehicles can take.
// Then it looks for the actual rounds in CfgMagazineWells, where the info is stored.
private _magList = [];

if (_is_vehicle) then {
	private _weap = _state select 0;
	private _magWells = [];
	private _findMagConfig = false;

	//Russian Guns & autocannons + UK3CB Factions 30mm autocannon
	if (("rhs_weap_2a" in _weap && {_weap != "rhs_weap_2a26"}) || {_weap == "UK3CB_Factions_Cannon_veh_1"}) then {
		_magWells = getArray (configFile >> "CfgWeapons" >> _weap >> "magazineWell");
		_findMagConfig = true;
	};

	//American Bradley
	if ("RHS_weap_M242BC" in _weap) then {
		_magWells = getArray (configFile >> "CfgWeapons" >> _weap >> "HE" >> "magazineWell");
		_findMagConfig = true;
	};

	if (_findMagConfig) then {
		private _configMagWellCount = 0;
		{
		  _configCfgMagWells = _x;
		  private _iterate = count (configfile >> "CfgMagazineWells" >> _configCfgMagWells);

		  while {_configMagWellCount < _iterate} do {
		    _configCfgMagWellsType = str ((configfile >> "CfgMagazineWells" >> _configCfgMagWells) select _configMagWellCount);
		    _type = _configCfgMagWellsType select [33 + count _configCfgMagWells, count _configCfgMagWellsType];

		    _ammo = getArray(configfile >> "CfgMagazineWells" >> _configCfgMagWells >> _type);
		    _magList append _ammo;
		    _configMagWellCount = _configMagWellCount + 1;
		  };
		  _configMagWellCount = 0;
		} forEach _magWells;
	};
};

private _owned = if (_is_vehicle) then {
	_target magazinesTurret _turret
}
else {
	magazines _target
};

private _allowed = [_state select 0, _state select 1] call FNC(magazines);

if ((_state select 0) == "rhs_weap_TOW_Launcher_static") then { // goes around a typo in RHS config: rhs_mag_TOW2A (incorrect) vs rhs_mag_TOW2a (correct)
	_allowed = ["rhs_mag_TOW","rhs_mag_TOWB","rhs_mag_ITOW","rhs_mag_TOW2","rhs_mag_TOW2a","rhs_mag_TOW2b","rhs_mag_TOW2b_aero","rhs_mag_TOW2bb"];
};

if ((_state select 0) == "rhs_weap_SPG9") then { // goes around wrong capitalisation for mag names
	_allowed = ["rhs_mag_pg9v","rhs_mag_pg9n","rhs_mag_pg9vnt","rhs_mag_og9vm","rhs_mag_og9v"];
};

if (count _magList > 0) then {
	_allowed = _magList;
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

	[_target, _args select 0, _args select 1] call FNC(loadmag);
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
			_text,
			if (_is_vehicle) then {
				_text
			} else {
				format ["%1 (%2 left)", _text, _num]
			},
			getText (_config >> "picture"),
			if (_is_vehicle) then {
				_vehicle_exec
			} else {
				_man_exec
			},
			{
				true
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