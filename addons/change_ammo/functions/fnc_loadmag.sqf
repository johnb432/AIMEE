#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Weapon whose magazine is to be changed <STRING>
 * 2: Magazine to be loaded in <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 *
 *
 * Public: No
 */

params [
	"_unit",
	"_weapon",
	"_mag",
	["_do_check", true, [false]]
];

private _state = weaponState _unit;

if (_state select 0 != _weapon) exitWith { nil };

private _muzzle = _state select 1;
private _output = "";
private _id = 0;
private _cr = 0;
private _idmax = 0;
private _crmax = 0;
private _numRndsLeftMax = 0;
private _numRndsLeft = 0;
private _numRndsFull = 0;
private _magdetail = magazinesDetail _unit;

{
	private _magname = getText (configfile >> "CfgMagazines" >> _mag >> "displayName");

	if (_magname in _x) then {
		_output = _x splitString "([ ]/:)";

	 	private _count = count _output;

		if (_count > 0) then {
			_id = parseNumber (_output select (_count - 2));
			_cr = parseNumber (_output select (_count - 1));
			_numRndsLeft = parseNumber (_output select (_count - 6));
			_numRndsFull = parseNumber (_output select (_count - 5));
		};

		if (_numRndsLeft == _numRndsFull && {!(_numRndsFull == 0)}) exitWith {
		 _numRndsLeftMax = _numRndsLeft;
		 _idmax = _id;
		 _crmax = _cr;
		 _forEachIndex = count _magdetail - 1; //skip to the end of the array
		};

		if (_numRndsLeft > _numRndsLeftMax) then {
		 _numRndsLeftMax = _numRndsLeft;
		 _idmax = _id;
		 _crmax = _cr;
		};
		_output = "";
 	};
} forEach _magdetail;

private _magCountInv = magazines _unit;
_magCountInv pushBack (currentMagazine _unit);
_magCountInv = _magCountInv call CBA_fnc_getArrayElements;
private _magCountTotal = 0;

for [{ _i = 1 }, { _i < count _magCountInv}, { _i = _i + 2 }] do {
	if !((_magCountInv select (_i - 1)) call BIS_fnc_isThrowable) then {
		_magCountTotal = _magCountTotal + (_magCountInv select _i);
	};
};

private _magAmountTotal = _magCountTotal;
private _muzzle = currentMuzzle _player;
private _wpnConfig = configFile >> "CfgWeapons" >> _weapon;
private _gesture = getText ([_wpnConfig >> _muzzle, _wpnConfig] select (_weapon isEqualTo _muzzle) >> "reloadAction");
private _isLauncher = _weapon isKindOf ["Launcher", configFile >> "CfgWeapons"];
private _config = ["CfgGesturesMale", "CfgMovesMaleSdr"] select _isLauncher;
private _duration = getNumber (configfile >> _config >> "States" >> _gesture >> "speed");
private _animNameMag = getText(configfile >> "CfgMagazines" >> _mag >> "reloadAction");

if (_animNameMag != "") then {
	_duration = getNumber(configfile >> "CfgGesturesMale" >> "States" >> _animNameMag >> "speed");
};

if (_duration != 0) then {
		_duration = if (_duration < 0) then { abs _duration } else { 1 / _duration };
} else {
		_duration = 3;
};

private _reloadingETA = time + _duration + 1;

_unit action ["loadMagazine", _unit, _unit, _crmax, _idmax, _weapon, _muzzle];

GVAR(reloadFinished) = false;

[{
		time > (_this select 4)
},{
		params ["_unit", "_mag", "_numRndsLeftMax", "_magAmountTotal"];

		private _magCountInv = magazines _unit;
		_magCountInv pushBack (currentMagazine _unit);
		_magCountInv = _magCountInv call CBA_fnc_getArrayElements;
		private _magCountTotal = 0;

		for [{ _i = 1 }, { _i < count _magCountInv}, { _i = _i + 2 }] do {
			if !((_magCountInv select (_i - 1)) call BIS_fnc_isThrowable) then {
				_magCountTotal = _magCountTotal + (_magCountInv select _i);
			};
		};

		if (!GVAR(reloadFinished) && {_magAmountTotal > _magCountTotal}) then {
			_unit addMagazine [_mag, _numRndsLeftMax];
		};
		GVAR(reloadFinished) = true;
},
[_unit, _mag, _numRndsLeftMax, _magAmountTotal, _reloadingETA]] call CBA_fnc_waitUntilAndExecute;
