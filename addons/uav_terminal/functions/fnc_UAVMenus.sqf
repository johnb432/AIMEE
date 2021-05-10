#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Unit <OBJECT>
 * 2: Arguments <ARRAY>
 *
 * Return Value:
 * Returns menus <ARRAY>
 *
 * Public: No
 */

params ["_target", "_player", "_args"];

private _uav = getConnectedUAV _player;
(UAVControl _uav) params ["_controller", "_role"];

if (_controller isNotEqualTo _player) exitWith {[]};

private _config = configOf _uav;
private _menus = [];

if (_role isNotEqualTo "") then {
   	_menus pushBack [[
      		QGVAR(releaseUAV),
      		LQSTRING(STR_useract_uav_releasecontrols),
      		ICON_RELEASE,
        {
          		params ["_target", "_player", "_args"];

          		// "BackFromUAV" action doesn't work when controlling gunner. ticket: https://feedback.bistudio.com/T128594
          		_player remoteControl objNull;
          		if (cameraView isEqualTo "GUNNER") then {
          			   _player switchCamera "INTERNAL";
          		} else {
          			   switchCamera _player;
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
          		params ["_target", "_player", "_args"];

          		_target action ["UAVTerminalReleaseConnection", _player];
       	},
      		{true}
   	] call ace_interact_menu_fnc_createAction, [], _uav];

   	_menus pushBack [[
      		QGVAR(feedUAV),
      		LQSTRING(str_usract_uav_view),
      		ICON_FEED,
      		{},
      		{true},
      		FUNC(infoPanelMenus),
      		"UAVFeedDisplayComponent"
   	] call ace_interact_menu_fnc_createAction, [], _player];
};

if (!isNull (_config >> "uavCameraGunnerPos") && {_role isNotEqualTo "GUNNER"}) then {
   	_menus pushBack [[
      		QGVAR(gunnerUAV),
      		LQSTRING(STR_useract_uav_takegunnercontrols),
      		ICON_GUNNER,
        {
          		params ["_target", "_player", "_args"];

          		_player action ["SwitchToUAVGunner", _target];
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
          		params ["_target", "_player", "_args"];

          		_player action ["SwitchToUAVDriver", _target];
       	},
      		{true}
   	] call ace_interact_menu_fnc_createAction, [], _uav];
};

_menus;
