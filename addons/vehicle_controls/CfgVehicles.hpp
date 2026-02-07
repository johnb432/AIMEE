#define ARTY_COMP_ACTION \
    class GVAR(artyCompAction) {\
        condition = QUOTE(GVAR(settingArtyComputerAction) && {_player == gunner _target} && {getNumber (configOf _target >> 'artilleryScanner') == 1});\
        displayName = CQSTRING(STR_artillery_computer);\
        icon = ICON_ARTY_COMP;\
        statement = QPACTION('ArtilleryComputer',_target);\
    }

#define LIGHTS_ACTION \
    class GVAR(lightsOnAction) {\
        condition = QUOTE(GVAR(settingLightsAction) && {'headlights' call EFUNC(main,ignoreKeybind)} && {!isLightOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_ACTION_LIGHTS_ON);\
        icon = ICON_LIGHTS_ON;\
        statement = QPACTION('LightOn',_target);\
    };\
    class GVAR(lightsOffAction) {\
        condition = QUOTE(GVAR(settingLightsAction) && {'headlights' call EFUNC(main,ignoreKeybind)} && {isLightOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_ACTION_LIGHTS_OFF);\
        icon = ICON_LIGHTS_OFF;\
        statement = QPACTION('LightOff',_target);\
    }

#define MANUAL_FIRE_ACTION \
    class GVAR(manualFireAction) {\
        condition = QUOTE(GVAR(settingManualAction) && {'heliManualFire' call EFUNC(main,ignoreKeybind)} && {!isManualFire _target} && {[ARR_2(_player,_target)] call FUNC(canManual)});\
        displayName = CQSTRING(STR_action_manual_fire);\
        icon = ICON_MANUAL_FIRE;\
        statement = QPACTION('ManualFire',_target);\
    };\
    class GVAR(manualFireCancelAction) {\
        condition = QUOTE(GVAR(settingManualAction) && {'heliManualFire' call EFUNC(main,ignoreKeybind)} && {isManualFire _target} && {[ARR_2(_player,_target)] call FUNC(canManual)});\
        displayName = CQSTRING(STR_action_manual_fire_cancel);\
        icon = ICON_MANUAL_FIRE_CANCEL;\
        statement = QPACTION('ManualFireCancel',_target);\
    }

#define ENGINE_ACITON \
    class GVAR(engineOnAction) {\
        condition = QUOTE(GVAR(settingEngineAction) && {'engineToggle' call EFUNC(main,ignoreKeybind) && {'engineControlACE' call EFUNC(main,ignoreKeybind)}} && {!isEngineOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_action_engineon);\
        icon = ICON_ENGINE_ON;\
        statement = QPACTION('EngineOn',_target);\
    };\
    class GVAR(engineOffAction) {\
        condition = QUOTE(GVAR(settingEngineAction) && {'engineToggle' call EFUNC(main,ignoreKeybind) && {'engineControlACE' call EFUNC(main,ignoreKeybind)}} && {isEngineOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_action_engineoff);\
        icon = ICON_ENGINE_OFF;\
        statement = QPACTION('EngineOff',_target);\
    }

#define GEAR_ACTION \
    class GVAR(gearAction) {\
        condition = QUOTE(GVAR(settingGearAction) && {'LandGear' call EFUNC(main,ignoreKeybind)} && {getNumber (configOf _target >> 'gearRetracting') == 1} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = DEFAULT_TEXT;\
        icon = ICON_GEAR;\
        modifierFunction = QUOTE(call FUNC(gearModify));\
        statement = QUOTE([ARR_2(_player,_target)] call FUNC(toggleGear));\
    }

#define COLLISION_LIGHTS_ACTION \
    class GVAR(collisionLightsOnAction) {\
        condition = QUOTE(GVAR(settingCollisionAction) && {!isCollisionLightOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_ACTION_COLLISIONLIGHTS_ON);\
        icon = ICON_COLLISION_LIGHTS_ON;\
        statement = QPACTION('CollisionLightOn',_target);\
    };\
    class GVAR(collisionLightsOffAction) {\
        condition = QUOTE(GVAR(settingCollisionAction) && {isCollisionLightOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_ACTION_COLLISIONLIGHTS_OFF);\
        icon = ICON_COLLISION_LIGHTS_OFF;\
        statement = QPACTION('CollisionLightOff',_target);\
    }

// From Apollo in the Arma discord:
// class Reflectors {} do not have animationSources to switch them on and off.
// If they're in the root of the vehicle the game puts a userAction "lights on", or if they're in a turret it gives a "searchlight on" option. There are no "hide" animations in model.cfg for them.
#define SEARCH_LIGHT_ACTION \
    class GVAR(searchLightOnAction) {\
        condition = QUOTE(GVAR(settingSearchAction) && {private _turret = _target unitTurret _player; !(_turret in [ARR_2([],[-1])]) && {!isLightOn [ARR_2(_target,_turret)]} && {count ([ARR_2(_target,_turret)] call CBA_fnc_getTurret >> 'Reflectors') != 0}});\
        displayName = CQSTRING(STR_action_searchlights_on);\
        icon = ICON_LIGHTS_ON;\
        statement = QPACTION('SearchLightOn',_target);\
    };\
    class GVAR(searchLightOffAction) {\
        condition = QUOTE(GVAR(settingSearchAction) && {isLightOn [ARR_2(_target,_target unitTurret _player)]});\
        displayName = CQSTRING(STR_action_searchlights_off);\
        icon = ICON_LIGHTS_OFF;\
        statement = QPACTION('SearchLightOff',_target);\
    }

#define HOVER_ACTION \
    class GVAR(hoverAction) {\
        condition = QUOTE(GVAR(settingHoverAction) && {'AutoHover' call EFUNC(main,ignoreKeybind)} && {!isAutoHoverOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_action_hover);\
        icon = ICON_HOVER;\
        statement = QPACTION('AutoHover',_target);\
    };\
    class GVAR(hoverActionCancel) {\
        condition = QUOTE(GVAR(settingHoverAction) && {'AutoHover' call EFUNC(main,ignoreKeybind)} && {isAutoHoverOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_action_hover_cancel);\
        icon = ICON_HOVER_CANCEL;\
        statement = QPACTION('AutoHoverCancel',_target);\
    }

#define LOCK_CONTROL_ACTION \
    class GVAR(lockControlAction) {\
        condition = QUOTE(GVAR(settingTakeControlsAction) && {isCopilotEnabled _target} && {driver _target == _player} && {_target getVariable [ARR_2(QQGVAR(copilotControlsUnlocked),false)]});\
        displayName = CQSTRING(STR_action_lock_control);\
        statement = QPACTION('LockVehicleControl',_target);\
    };\
    class GVAR(unlockControlAction) {\
        condition = QUOTE(GVAR(settingTakeControlsAction) && {isCopilotEnabled _target} && {driver _target == _player} && {!(_target getVariable [ARR_2(QQGVAR(copilotControlsUnlocked),false)])});\
        displayName = CQSTRING(STR_action_unlock_control);\
        statement = QPACTION('UnlockVehicleControl',_target);\
    }

#define TAKE_CONTROL_ACTION \
    class GVAR(takeControlAction) {\
        condition = QUOTE(GVAR(settingTakeControlsAction) && {isCopilotEnabled _target} && {!isPlayer driver _target || {_target getVariable [ARR_2(QQGVAR(copilotControlsUnlocked),false)]}} && {!([ARR_2(_player,_target)] call FUNC(isDriver))} && {getNumber ([ARR_2(_target,_target unitTurret _player)] call CBA_fnc_getTurret >> 'isCopilot') == 1});\
        displayName = CQSTRING(STR_action_take_control);\
        statement = QPACTION('TakeVehicleControl',_target);\
    };\
    class GVAR(releaseControlAction) {\
        condition = QUOTE(GVAR(settingTakeControlsAction) && {isCopilotEnabled _target} && {!isPlayer driver _target || {_target getVariable [ARR_2(QQGVAR(copilotControlsUnlocked),false)]}} && {[ARR_2(_player,_target)] call FUNC(isDriver)} && {getNumber ([ARR_2(_target,_target unitTurret _player)] call CBA_fnc_getTurret >> 'isCopilot') == 1});\
        displayName = CQSTRING(STR_action_suspend_control);\
        statement = QPACTION('SuspendVehicleControl',_target);\
    }

#define FLAPS_ACTION \
    class GVAR(flapsAction) {\
        condition = QUOTE(GVAR(settingFlapsAction) && {'FlapsDown' call EFUNC(main,ignoreKeybind)} && {getNumber (configOf _target >> 'flaps') != 0} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CSTRING(Flaps);\
        icon = ICON_FLAPS;\
        insertChildren = QUOTE(_target call FUNC(flapsMenus));\
    }

class CfgVehicles {
    class LandVehicle;
    class Car: LandVehicle {
        class ACE_SelfActions {
            ENGINE_ACITON;
            LIGHTS_ACTION;
            SEARCH_LIGHT_ACTION;
            ARTY_COMP_ACTION;
            MANUAL_FIRE_ACTION;
        };
    };

    class Motorcycle: LandVehicle {
        class ACE_SelfActions {
            ENGINE_ACITON;
            LIGHTS_ACTION;
        };
    };

    class StaticWeapon: LandVehicle {
        class ACE_SelfActions {
            ARTY_COMP_ACTION;
        };
    };

    class Tank: LandVehicle {
        class ACE_SelfActions {
            ENGINE_ACITON;
            LIGHTS_ACTION;
            SEARCH_LIGHT_ACTION;
            ARTY_COMP_ACTION;
            MANUAL_FIRE_ACTION;
        };
    };

    class Air;
    class Helicopter: Air {
        class ACE_SelfActions {
            TAKE_CONTROL_ACTION;
            LOCK_CONTROL_ACTION;
            ENGINE_ACITON;
            HOVER_ACTION;
            GEAR_ACTION;
            LIGHTS_ACTION;
            COLLISION_LIGHTS_ACTION;
            SEARCH_LIGHT_ACTION;
            MANUAL_FIRE_ACTION;
        };
    };

    class Plane: Air {
        class ACE_SelfActions {
            ENGINE_ACITON;
            GEAR_ACTION;
            FLAPS_ACTION;
            LIGHTS_ACTION;
            COLLISION_LIGHTS_ACTION;
            SEARCH_LIGHT_ACTION;
            MANUAL_FIRE_ACTION;
        };
    };

    class Ship;
    class Ship_F: Ship {
        class ACE_SelfActions {
            ENGINE_ACITON;
            LIGHTS_ACTION;
            COLLISION_LIGHTS_ACTION;
            SEARCH_LIGHT_ACTION;
            ARTY_COMP_ACTION;
            MANUAL_FIRE_ACTION;
        };
    };
};
