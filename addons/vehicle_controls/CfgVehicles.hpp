#define ARTY_COMP_ACTION \
    class GVAR(artyCompAction) {\
        condition = QUOTE(GVAR(settingArtyComputerAction) && {getNumber (configOf _target >> 'artilleryScanner') isEqualTo 1} && {_player isEqualTo gunner _target});\
        displayName = CQSTRING(STR_artillery_computer);\
        icon = ICON_ARTY_COMP;\
        statement = QPACTION('ArtilleryComputer',_target);\
    }

#define LIGHTS_ACTION \
    class GVAR(lightsOnAction) {\
        condition = QUOTE(GVAR(settingLightsAction) && {'headlights' call EFUNC(main,ignoreKeybindForInputAction)} && {!isLightOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_ACTION_LIGHTS_ON);\
        icon = ICON_LIGHTS_ON;\
        statement = QUOTE(_target setPilotLight true);\
    };\
    class GVAR(lightsOffAction) {\
        condition = QUOTE(GVAR(settingLightsAction) && {'headlights' call EFUNC(main,ignoreKeybindForInputAction)} && {isLightOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_ACTION_LIGHTS_OFF);\
        icon = ICON_LIGHTS_OFF;\
        statement = QUOTE(_target setPilotLight false);\
    }

#define MANUAL_FIRE_ACTION \
    class GVAR(manualFireAction) {\
        condition = QUOTE(GVAR(settingManualAction) && {'heliManualFire' call EFUNC(main,ignoreKeybindForInputAction)} && {!isManualFire _target} && {[ARR_2(_player,_target)] call FUNC(canManual)});\
        displayName = CQSTRING(STR_action_manual_fire);\
        icon = ICON_MANUAL_FIRE;\
        statement = QPACTION('ManualFire',_target);\
    };\
    class GVAR(manualFireCancelAction) {\
        condition = QUOTE(GVAR(settingManualAction) && {'heliManualFire' call EFUNC(main,ignoreKeybindForInputAction)} && {isManualFire _target} && {[ARR_2(_player,_target)] call FUNC(canManual)});\
        displayName = CQSTRING(STR_action_manual_fire_cancel);\
        icon = ICON_MANUAL_FIRE_CANCEL;\
        statement = QPACTION('ManualFireCancel',_target);\
    }

#define ENGINE_ACITON \
    class GVAR(engineOnAction) {\
        condition = QUOTE(GVAR(settingEngineAction) && {'engineToggle' call EFUNC(main,ignoreKeybindForInputAction) && {'engineControlACE' call EFUNC(main,ignoreKeybindForInputAction)}} && {!isEngineOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_action_engineon);\
        icon = ICON_ENGINE_ON;\
        statement = QUOTE(_target engineOn true);\
    };\
    class GVAR(engineOffAction) {\
        condition = QUOTE(GVAR(settingEngineAction) && {'engineToggle' call EFUNC(main,ignoreKeybindForInputAction) && {'engineControlACE' call EFUNC(main,ignoreKeybindForInputAction)}} && {isEngineOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_action_engineoff);\
        icon = ICON_ENGINE_OFF;\
        statement = QUOTE(_target engineOn false);\
    }

#define GEAR_ACTION \
    class GVAR(gearAction) {\
        condition = QUOTE(GVAR(settingGearAction) && {'LandGear' call EFUNC(main,ignoreKeybindForInputAction)} && {getNumber (configOf _target >> 'gearRetracting') isEqualTo 1} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
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
        statement = QUOTE(_target setCollisionLight true);\
    };\
    class GVAR(collisionLightsOffAction) {\
        condition = QUOTE(GVAR(settingCollisionAction) && {isCollisionLightOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_ACTION_COLLISIONLIGHTS_OFF);\
        icon = ICON_COLLISION_LIGHTS_OFF;\
        statement = QUOTE(_target setCollisionLight false);\
    }

#define HOVER_ACTION \
    class GVAR(hoverAction) {\
        condition = QUOTE(GVAR(settingHoverAction) && {'AutoHover' call EFUNC(main,ignoreKeybindForInputAction)} && {!isAutoHoverOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_action_hover);\
        icon = ICON_HOVER;\
        statement = QPACTION('AutoHover',_target);\
    };\
    class GVAR(hoverActionCancel) {\
        condition = QUOTE(GVAR(settingHoverAction) && {'AutoHover' call EFUNC(main,ignoreKeybindForInputAction)} && {isAutoHoverOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_action_hover_cancel);\
        icon = ICON_HOVER_CANCEL;\
        statement = QPACTION('AutoHoverCancel',_target);\
    }

#define FLAPS_ACTION \
    class GVAR(flapsAction) {\
        condition = QUOTE(GVAR(settingFlapsAction) && {'FlapsDown' call EFUNC(main,ignoreKeybindForInputAction)} && {getNumber (configOf _target >> 'flaps') isNotEqualTo 0} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CSTRING(Flaps);\
        icon = ICON_FLAPS;\
        insertChildren = QUOTE(_this call FUNC(flapsSubMenus));\
    }
    
/*
#define LOCK_CONTROLS_ACTION \
    class GVAR(lockControlsAction) {\
        condition = QUOTE(GVAR(settingLockControlsAction) && {isCopilotEnabled _target} && {currentPilot _target isEqualTo _player});\
        displayName = CQSTRING(STR_action_lock_control);\
        statement = QPACTION('LockVehicleControl',_target);\
    };\
    class GVAR(unlockControlsAction) {\
        condition = QUOTE(GVAR(settingUnlockControlsAction) && {!isCopilotEnabled _target} && {currentPilot _target isEqualTo _player});\
        displayName = CQSTRING(STR_action_unlock_control);\
        statement = QPACTION('UnlockVehicleControl',_target);\
    }

#define TAKE_CONTROLS_ACTION \
    class GVAR(takeControlsAction) {\
        condition = QUOTE(GVAR(settingTakeControlsAction) && {isCopilotEnabled _target} && {currentPilot _target isNotEqualTo _player} && {(((allTurrets _target select {getNumber ([ARR_2(_target,_x)] call BIS_fnc_turretConfig >> 'isCopilot') > 0}) apply {_target turretUnit _x}) select 0) isEqualTo _player});\
        displayName = CQSTRING(STR_action_take_control);\
        statement = QPACTION('TakeVehicleControl',_target);\
    };\
    class GVAR(suspendControlsAction) {\
        condition = QUOTE(GVAR(settingTakeControlsAction) && {currentPilot _target isEqualTo _player} && {(((allTurrets _target select {getNumber ([ARR_2(_target,_x)] call BIS_fnc_turretConfig >> 'isCopilot') > 0}) apply {_target turretUnit _x}) select 0) isEqualTo _player});\
        displayName = CQSTRING(STR_action_suspend_control);\
        statement = QPACTION('SuspendVehicleControl',_target);\
    }

#define VTOL_VECTORING_ACTION \
    class GVAR(VTOLvectoringAction) {\
        condition = QUOTE(GVAR(settingVectoringAction) && {'VTOLVectoring' call EFUNC(main,ignoreKeybindForInputAction)} && {!isAutoHoverOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_action_hover);\
        icon = ICON_HOVER;\
        statement = QPACTION('VTOLVectoring',_target);\
    };\
    class GVAR(VTOLvectoringActionCancel) {\
        condition = QUOTE(GVAR(settingVectoringAction) && {'VTOLVectoring' call EFUNC(main,ignoreKeybindForInputAction)} && {isAutoHoverOn _target} && {[ARR_2(_player,_target)] call FUNC(isDriver)});\
        displayName = CQSTRING(STR_action_hover_cancel);\
        icon = ICON_HOVER_CANCEL;\
        statement = QPACTION('VTOLVectoringCancel',_target);\
    }
*/

class CfgVehicles {
    class LandVehicle;
    class Car: LandVehicle {
      		class ACE_SelfActions {
            ENGINE_ACITON;
            MANUAL_FIRE_ACTION;
            LIGHTS_ACTION;
            ARTY_COMP_ACTION;
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
            MANUAL_FIRE_ACTION;
            LIGHTS_ACTION;
            ARTY_COMP_ACTION;
        };
    };

    class Air;
    class Helicopter: Air {
        class ACE_SelfActions {
            ENGINE_ACITON;
            MANUAL_FIRE_ACTION;
            COLLISION_LIGHTS_ACTION;
            GEAR_ACTION;
            HOVER_ACTION;
            //LOCK_CONTROLS_ACTION;
            //TAKE_CONTROLS_ACTION;
        };
    };

    class Plane: Air {
        class ACE_SelfActions {
            ENGINE_ACITON;
            MANUAL_FIRE_ACTION;
            COLLISION_LIGHTS_ACTION;
            GEAR_ACTION;
            FLAPS_ACTION;
        };
    };

    class Ship;
   	class Ship_F: Ship {
      		class ACE_SelfActions {
            ENGINE_ACITON;
            MANUAL_FIRE_ACTION;
            LIGHTS_ACTION;
            COLLISION_LIGHTS_ACTION;
            ARTY_COMP_ACTION;
      		};
   	};
};
