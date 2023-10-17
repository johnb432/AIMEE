#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Add disassemble actions to all UAVs
["AllVehicles", "init", {
    params ["_object"];

    if (unitIsUAV _object && {!(_object isKindOf "CAManBase")}) then {
        private _action = [
            QGVAR(disassembleActionUAV),
            LQSTRING(STR_A3_disassemble),
            ICON_REPAIR,
            {PACTION("Disassemble",_target)},
            {GVAR(settingAssembleAction) && {alive _target} && {_target call FUNC(canDisassemble)}}
        ] call ace_interact_menu_fnc_createAction;

        [_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    };
}] call CBA_fnc_addClassEventHandler;
