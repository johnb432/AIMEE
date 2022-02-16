#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Sets the name of the interaction.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <OBJECT>
 * 2: Params <ARRAY>
 * 3: Interaction menu <ARRAY>
 *
 * Return Value:
 * Modified interaction menu <ARRAY>
 *
 * Public: No
 */

(_this select 3) set [1,
    switch ((_this select 0) call FUNC(gearStatus)) do {
        case GEAR_ERROR: {
            LQSTRING(str_lib_info_retract_gear) + " ERROR";
        };
        case GEAR_DOWN: {
            LQSTRING(str_action_gear_up);
        };
        case GEAR_EXTENDING: {
            LQSTRING(str_lib_info_retract_gear) + " " + LQSTRING(STR_DISP_OPT_OPEN);
        };
        case GEAR_UP: {
            LQSTRING(str_action_gear_down);
        };
        case GEAR_RETRACTING: {
            LQSTRING(str_lib_info_retract_gear) + " " + LQSTRING(STR_DISP_OPT_CLOSE);
        };
        default {
            DEFAULT_TEXT;
        };
    }
];
