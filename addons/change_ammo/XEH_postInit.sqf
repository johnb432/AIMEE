#include "script_component.hpp"

if (!hasInterface) exitWith {};

GVAR(changeAmmoNamespace) = createHashMap;
GVAR(loadoutChanged) = true;

["loadout", {
    GVAR(loadoutChanged) = true;
}, true] call CBA_fnc_addPlayerEventHandler;
