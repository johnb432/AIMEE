#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Returns whether a gun can be manually fired by a unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * Can manual fire <BOOL>
 *
 * Example:
 * [player, vehicle player] call AIMEE_vehicle_controls_fnc_canManual
 *
 * Public: No
 */

params ["_unit", "_vehicle"];

private _config = configOf _vehicle;

if (getNumber (_config >> "enableManualFire") == 0 || {isPlayer gunner _vehicle}) exitWith {
    false // return
};

if (_vehicle isKindOf "Air" || {unitIsUAV _vehicle}) then {
    call FUNC(isDriver) && {"true" configClasses (_config >> "Turrets") isNotEqualTo []} // return
} else {
    // primaryObserver in config is what the command "commander" returns, which isn't always the actual commander slot
    // Only the "effectiveCommander" can use manual fire
    _unit == effectiveCommander _vehicle && {
        (GVAR(commandingTurrets) getOrDefaultCall [typeOf _vehicle, {
            private _turretConfig = configNull;
            private _commanding = 0;
            private _maxCommanding = -1e10;
            private _maxTurret = [];

            {
                _turretConfig = _config;

                {
                    if (_x < 0) exitWith {
                        _turretConfig = configNull;
                    };

                    // config classes ignores inherited classes, just like the engine does with turrets
                    _turretConfig = ("true" configClasses (_turretConfig >> "turrets")) param [_x, configNull];
                } forEach _x;

                _commanding = getNumber (_turretConfig >> "commanding");

                if (_commanding > _maxCommanding) then {
                    _maxCommanding = _commanding;
                    _maxTurret = _x;
                };
            } forEach (allTurrets _vehicle);

            _maxTurret
        }, true]) isEqualTo (_vehicle unitTurret _unit) // return
    }
};
