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

private _magList = [];
private _magWells = getArray (configFile >> "CfgWeapons" >> _weapon >> _muzzle >> "magazineWell");
private _configMagWellCount = 0;
// First it iterates over given magazineWells, as those contain all the ammo vehicles and weapons can take.
// Then it looks for the actual rounds in CfgMagazineWells, where the info is stored.
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

private _muzzleMagList = getArray(configFile >> "CfgWeapons" >> _weapon >> _muzzle >> "magazines");
_magList append _muzzleMagList,
_magList arrayIntersect _magList;
