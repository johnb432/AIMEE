#include "script_component.hpp"

if (!hasInterface) exitWith {};

GVAR(commandingTurrets) = createHashMap;

// User actions
[
    "AllVehicles",
    1,
    ["ACE_SelfActions"],
    [
        QGVAR(userActions),
        format [LQSTRING(str_disp_xbox_hint_igui_more_actions), ""],
        ICON_MORE,
        {},
        {
            GVAR(settingUserActions) && {!isNull (configOf (_this select 0) >> "UserActions")};
        },
        FUNC(userActionMenus)
    ] call ace_interact_menu_fnc_createAction,
    true
] call ace_interact_menu_fnc_addActionToClass;

// Detect when a controls are shifted in the player's vehicle
["turret", {
    params ["_unit", "_newTurret", "_oldTurret"];

    private _vehicle = objectParent _unit;

    if (isNull _vehicle) then {
        if (isNil QGVAR(controlsShiftedEH)) exitWith {};

        removeMissionEventHandler ["ControlsShifted", GVAR(controlsShiftedEH)];

        GVAR(controlsShiftedEH) = nil;
    } else {
        if !(_vehicle isKindOf "Helicopter") exitWith {};

        _vehicle setVariable [QGVAR(copilotControlsUnlocked), !isPlayer driver _vehicle];

        if (!isNil QGVAR(controlsShiftedEH)) exitWith {};

        GVAR(controlsShiftedEH) = addMissionEventHandler ["ControlsShifted", {
        	params ["", "", "_vehicle", "", "_controlsUnlocked"];

            _vehicle setVariable [QGVAR(copilotControlsUnlocked), _controlsUnlocked];
        }];
    };
}, true] call CBA_fnc_addPlayerEventHandler;
