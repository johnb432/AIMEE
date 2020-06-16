#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Weapon <STRING>
 * 1: Muzzle <STRING>
 *
 * Return Value:
 * Returns a list of magazine classes allowed for the muzzle <ARRAY>
 *
 * Example:
 *
 *
 * Public: No
 */

params [
	"_weapon",
	"_muzzle"
];

private _config = configFile >> "CfgWeapons" >> _weapon;

if (_weapon == _muzzle || { _muzzle == "this" }) then {
	_config = _config >> "magazines";
}
else {
	_config = _config >> _muzzle >> "magazines";
};
getArray _config;