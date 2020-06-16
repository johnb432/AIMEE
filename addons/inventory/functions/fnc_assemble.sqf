#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Weapon
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
	"_player",
	"_weapon"
];

private _base = [_player, _weapon call FUNC(bases)] call FUNC(nearest_base);

GVAR(base) = _base;
if (isNil "_base") then {
	_base = _player;
};
_player action ["Assemble", _base];