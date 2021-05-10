#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: ID <STRING>
 * 1: Component <STRING>
 *
 * Return Value:
 * Returns if a panel is open
 *
 * Public: No
 */

params ["_id", "_component"];

_component in (infoPanel _id);
