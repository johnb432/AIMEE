#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Gets or sets landing gear status; Sets a new value for gear status if _set is not nil, old value is returned.
 * For meanings of status values see the macros.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Set new value <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_vehicle", ["_set", nil]];

private _old = _vehicle getVariable [QGVAR(gearStatus), GEAR_UNKNOWN];

if (_old isEqualTo GEAR_UNKNOWN) then {
    // Guess where the animation is at
    private _last = 0;
    private _count = 0;
    private _highest = 0;
    private _highestV = 0;
    private _phases = [];
    private _phase = -1;

    {
        if (_x find "gear" isNotEqualTo -1) then {
            _phase = _vehicle animationPhase _x;

            if (_phase >= 0) then {
                _phases pushBack _phase;
            };
        };
    } forEach animationNames _vehicle;

    if (_phases isEqualTo []) exitWith {-1};

    _phases sort true;

    {
        if (_last isNotEqualTo _x) then {
            _count = 0;
        };

        _last = _x;
        _count = _count + 1;

        if (_count > _highest) then {
            _highest = _count;
            _highestV = _x;
        };
    } forEach _phases;

    if (_highestV isEqualTo 0) exitWith {
        _old = GEAR_DOWN;
    };

    _old = [GEAR_UP, GEAR_UNKNOWN] select (_highestV < 1);
};

if (!isNil "_set") then {
    _vehicle setVariable [QGVAR(gearStatus), _set];
};

_old;
