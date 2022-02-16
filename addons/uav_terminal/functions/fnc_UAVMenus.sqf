#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Makes menus for UAVs.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Returns menus <ARRAY>
 *
 * Example:
 * player call AIMEE_uav_terminal_fnc_UAVMenus
 *
 * Public: No
 */

private _uav = getConnectedUAV _this;
(UAVControl _uav) params ["_controller", "_role"];

if (_controller isNotEqualTo _this) exitWith {[]};

private _config = configOf _uav;
private _menus = [];

if (_role isNotEqualTo "") then {
    _menus pushBack [[
        QGVAR(releaseUAV),
        LQSTRING(STR_useract_uav_releasecontrols),
        ICON_RELEASE,
        {
            params ["", "_unit"];

            // "BackFromUAV" action doesn't work when controlling gunner. ticket: https://feedback.bistudio.com/T128594
            _unit remoteControl objNull;

            if (cameraView isEqualTo "GUNNER") then {
                _unit switchCamera "INTERNAL";
            } else {
                switchCamera _unit;
            };
        },
        {true}
    ] call ace_interact_menu_fnc_createAction, [], _uav];
} else {
    _menus pushBack [[
        QGVAR(disconnectUAV),
        LQSTRING(STR_useract_uav_uavterminalreleaseconnection),
        ICON_DISCONNECT,
        {
            (_this select 0) action ["UAVTerminalReleaseConnection", _this select 1];
        },
        {true}
    ] call ace_interact_menu_fnc_createAction, [], _uav];

    _menus pushBack [[
        QGVAR(feedUAV),
        LQSTRING(str_usract_uav_view),
        ICON_FEED,
        {},
        {true},
        {(_this select 1) call FUNC(infoPanelMenus)}
    ] call ace_interact_menu_fnc_createAction, [], _this];
};

if (!isNull (_config >> "uavCameraGunnerPos") && {_role isNotEqualTo "GUNNER"}) then {
    _menus pushBack [[
        QGVAR(gunnerUAV),
        LQSTRING(STR_useract_uav_takegunnercontrols),
        ICON_GUNNER,
        {
            (_this select 1) action ["SwitchToUAVGunner", _this select 0];
        },
        {true}
    ] call ace_interact_menu_fnc_createAction, [], _uav];
};

if (!isNull (_config >> "uavCameraDriverPos") && {_role isNotEqualTo "DRIVER"}) then {
    _menus pushBack [[
        QGVAR(driverUAV),
        LQSTRING(STR_useract_uav_takecontrols),
        if (_uav isKindOf "Air") then {
            ICON_PILOT
        } else {
            ICON_DRIVER
        },
        {
            (_this select 1) action ["SwitchToUAVDriver", _this select 0];
        },
        {true}
    ] call ace_interact_menu_fnc_createAction, [], _uav];
};

_menus;
