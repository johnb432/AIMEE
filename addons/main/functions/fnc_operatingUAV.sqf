#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Returns if player is connected to a UAV <BOOL>
 *
 * Public: No
 */

params ["_player"];

(UAVControl getConnectedUAV _player) select 1 isNotEqualTo "";
