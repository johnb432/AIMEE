#include "script_component.hpp"

if (!hasInterface) exitWith {};

GVAR(changeAmmoNamespace) = call CBA_fnc_createNamespace;
GVAR(loadoutChanged) = true;

["loadout", {
    GVAR(loadoutChanged) = true;
}, true] call CBA_fnc_addPlayerEventHandler;
