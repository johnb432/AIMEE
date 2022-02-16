#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Returns if unit is connected to a UAV.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Is controlling UAV <BOOL>
 *
 * Example:
 * player call AIMEE_main_fnc_operatingUAV
 *
 * Public: No
 */

((UAVControl getConnectedUAV _this) select 1) isNotEqualTo "";
