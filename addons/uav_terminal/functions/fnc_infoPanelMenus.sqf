#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Makes menus for given panel types.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Returns menus <ARRAY>
 *
 * Example:
 * player call AIMEE_uav_terminal_fnc_infoPanelMenus
 *
 * Public: No
 */

["left", "right"] apply {
    [[
        format [QGVAR(infoPanelAction_%1), _x],
        DEFAULT_TEXT,
        "",
        {
            params ["", "", "_id"];

            {
                if ("UAVFeedDisplayComponent" in (infoPanel _x)) then {
                    setInfoPanel [_x, "EmptyDisplayComponent"];
                } else {
                    if (_id == _x) then {
                        setInfoPanel [_id, "UAVFeedDisplayComponent"];
                    };
                };
            } forEach ["left", "right"];
        },
        {true},
        nil,
        _x,
        nil,
        nil,
        nil,
        {
            params ["", "", "_id", "_menu"];

            private _opened = "UAVFeedDisplayComponent" in (infoPanel _id);

            _menu set [1, [[TEXT_RIGHT, TEXT_LEFT] select (_id == "left"), [TEXT_CLOSE_RIGHT, TEXT_CLOSE_LEFT] select (_id == "left")] select _opened];
            _menu set [2, [ICON_ON, ICON_OFF] select _opened];
        }
    ] call ace_interact_menu_fnc_createAction, [], _this];
};
