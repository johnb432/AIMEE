#include "..\script_component.hpp"
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

if (_controller != _this) exitWith {[]};

private _config = configOf _uav;
private _menus = [];

// If in a turret, give option to release controls of turret
if (_role != "") then {
    _menus pushBack [[
        QGVAR(releaseUAV),
        LQSTRING(STR_useract_uav_releasecontrols),
        ICON_RELEASE,
        {
            // Ticket: https://feedback.bistudio.com/T128594 -> Now workaround
            (getConnectedUAVUnit (_this select 1)) action ["BackFromUAV"];
        },
        {true}
    ] call ace_interact_menu_fnc_createAction, [], _uav];
} else {
    // If in no turret, give options to disconnect and see camera feed from drone
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
        {
            (_this select 1) call FUNC(infoPanelMenus)
        }
    ] call ace_interact_menu_fnc_createAction, [], _this];
};

// Give option to take gunner turret if existent and player isn't a gunner already
if (getText (_config >> "uavCameraGunnerPos") != "" && {_role != "GUNNER"}) then {
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

// Give option to take driver turret if existent and player isn't a driver already
if (getText (_config >> "uavCameraDriverPos") != "" && {_role != "DRIVER"}) then {
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

_menus
