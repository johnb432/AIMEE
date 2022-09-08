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

private _content = weaponCargo _target;
_content append (itemCargo _target);
_content append (magazineCargo _target);
_content append (backpackCargo _target);

if (count _content == 1) then {
    _menu set [1, getText (((_content select 0) call CBA_fnc_getItemConfig) >> "displayName")];
    _menu set [2, ICON_TAKE];
} else {
    _menu set [1, LQSTRING(str_action_gear)];
    _menu set [2, ICON_INVENTORY];
};
