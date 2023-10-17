#include "..\script_component.hpp"

/*
 * Author: johnb43
 * Places drone from player's backpack.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * player call AIMEE_uav_terminal_fnc_UAVAssemble
 *
 * Public: No
 */

params ["_unit"];

private _UAVType = _unit call FUNC(UAVType);

if (_UAVType == "") exitWith {};

_unit playAction "PutDown";

[{
    params ["_unit"];

    // Check if backpack hasn't changed
    private _UAVType = _unit call FUNC(UAVType);

    if (_UAVType == "") exitWith {};

    removeBackpackGlobal _unit;

    // Prevent collision damage to unit
    ["ace_common_fixCollision", _unit] call CBA_fnc_localEvent;

    // Find position to place UAV
    private _direction = getDir _unit;
    private _position = (getPosASL _unit) vectorAdd [0.8 * sin(_direction), 0.8 * cos(_direction), 0];
    private _intersection = (lineIntersectsSurfaces [_position vectorAdd [0, 0, 1.5], _position vectorDiff [0, 0, 1.5], _unit, objNull, true, 1, "GEOM", "FIRE"]) param [0, []];

    private _vectorUp = if (_intersection isNotEqualTo []) then {
        _intersection params ["_intersectPosASL", "_surfaceNormal"];

        _position = _intersectPosASL vectorAdd [0, 0, 0.05];
        _surfaceNormal
    } else {
        [0, 0, 1]
    };

    // Place UAV
    private _uav = _UAVType createVehicle [0, 0, 0];
    createVehicleCrew _uav;

    _uav setDir _direction;
    _uav setPosASL _position;
    _uav setVectorUp _vectorUp;

    // Make UAV be placed on ground
    ["ace_common_fixPosition", _uav] call CBA_fnc_localEvent;
    ["ace_common_fixFloating", _uav] call CBA_fnc_localEvent;

    _unit reveal _uav;
}, _this, 1] call CBA_fnc_waitAndExecute;
