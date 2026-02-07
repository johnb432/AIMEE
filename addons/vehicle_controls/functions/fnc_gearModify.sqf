#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Sets the name of the interaction.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player (not used) <OBJECT>
 * 2: Params (not used) <ARRAY>
 * 3: Interaction menu <ARRAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target", "", "", "_menu"];

_menu set [1,
    switch (_target call FUNC(gearStatus)) do {
        case GEAR_ERROR: {
            LQSTRING(str_lib_info_retract_gear) + " " + toUpper LQSTRING(str_mis_state_error)
        };
        case GEAR_DOWN: {
            LQSTRING(str_action_gear_up)
        };
        case GEAR_EXTENDING: {
            LQSTRING(str_lib_info_retract_gear) + " " + LQSTRING(STR_DISP_OPT_OPEN)
        };
        case GEAR_UP: {
            LQSTRING(str_action_gear_down)
        };
        case GEAR_RETRACTING: {
            LQSTRING(str_lib_info_retract_gear) + " " + LQSTRING(STR_DISP_OPT_CLOSE)
        };
        default {
            DEFAULT_TEXT
        };
    }
];
