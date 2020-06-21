#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Weapon <STRING>
 * 2: Muzzle <STRING>
 * 3: New magazine <STRING>
 * 4: Old magazine <STRING>
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
	"_muzzle",
	"_newMagazine",
	"_oldMagazine"
];

GVAR(reloadFinished) = true;
