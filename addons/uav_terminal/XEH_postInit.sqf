#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Add connect and disconnect actions to all UAVs
["AllVehicles", "init", {
    params ["_object"];

    if (unitIsUAV _object && {!(_object isKindOf "CAManBase")}) then {
        private _action = [
            QGVAR(connectActionUAV),
            LQSTRING(STR_useract_uav_uavterminalmakeconnection),
            getText (configOf _object >> "icon"),
            {PACTION("UAVTerminalMakeConnection",_target)},
            {GVAR(UAVAction) && {alive _target} && {getConnectedUAV _player != _target} && {side _target == side _player} && {_player call FUNC(assignedTerminal)}}
        ] call ace_interact_menu_fnc_createAction;

        [_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

        _action = [
            QGVAR(disconnectActionUAV),
            LQSTRING(STR_useract_uav_uavterminalreleaseconnection),
            ICON_DISCONNECT,
            {_target action ["UAVTerminalReleaseConnection", _player]},
            {GVAR(UAVAction) && {alive _target} && {getConnectedUAV _player == _target}}
        ] call ace_interact_menu_fnc_createAction;

        [_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    };
}] call CBA_fnc_addClassEventHandler;
