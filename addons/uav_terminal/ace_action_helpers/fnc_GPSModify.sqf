#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Player <OBJECT>
 * 2: Params <ARRAY>
 * 3: Interaction menu <ARRAY>
 *
 * Return Value:
 * Modified interaction menu <ARRAY>
 *
 * Public: No
 */

params ["_target", "_player", "_args", "_menu"];

private _gps = _player call FUNC(assignedGPS);
private _config = configFile >> "CfgWeapons" >> _gps;
private _text = getText (_config >> "displayName");

if (_gps isKindOf ["UavTerminal_base", configFile >> "CfgWeapons"]) then {
    _text = _text + " (GPS)";
};

_menu set [1, _text];
_menu set [2, getText (_config >> "picture")];
