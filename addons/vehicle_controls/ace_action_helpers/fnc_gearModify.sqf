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

private _text = DEFAULT_TEXT;

switch (_target call FUNC(gearStatus)) do {
    case GEAR_ERROR: {
        _text = LQSTRING(str_lib_info_retract_gear) + " ERROR";
    };

    case GEAR_DOWN: {
        _text = LQSTRING(str_action_gear_up);
    };

    case GEAR_EXTENDING: {
        _text = LQSTRING(str_lib_info_retract_gear) + " " + LQSTRING(STR_DISP_OPT_OPEN);
    };

    case GEAR_UP: {
        _text = LQSTRING(str_action_gear_down);
    };

    case GEAR_RETRACTING: {
        _text = LQSTRING(str_lib_info_retract_gear) + " " + LQSTRING(STR_DISP_OPT_CLOSE);
    };

    default {};
};

_menu set [1, _text];
