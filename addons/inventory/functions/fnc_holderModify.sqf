#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Sets the icon and name of the interaction.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Unit <OBJECT>
 * 2: Params <ARRAY>
 * 3: Interaction menu <ARRAY>
 *
 * Return Value:
 * Modified interaction menu <ARRAY>
 *
 * Public: No
 */

params ["_target", "", "", "_menu"];

private _content = ["CfgWeapons"] + weaponCargo _target + ["CfgMagazines"] + magazineCargo _target + ["CfgVehicles"] + backpackCargo _target;

if (count _content isEqualTo 4) then {
    private _index = _content findIf {_x find "Cfg" isNotEqualTo 0};

    _menu set [1, getText (configFile >> _content select (_index - 1) >> _content select _index >> "displayName")];
    _menu set [2, ICON_TAKE];
} else {
    _menu set [1, LQSTRING(str_action_gear)];
    _menu set [2, ICON_INVENTORY];
};
