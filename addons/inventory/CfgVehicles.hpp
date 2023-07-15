#define VEHICLE_INVENTORY_ACTION \
    class GVAR(openAction) {\
        condition = QUOTE(GVAR(settingOpenAction) && {alive _target} && {_target call FUNC(hasInventory)});\
        displayName = CQSTRING(STR_action_gear);\
        icon = ICON_INVENTORY;\
        statement = QPACTION('Gear',_target);\
    }

class CfgVehicles {
    class ReammoBox;
    class WeaponHolder: ReammoBox {
        class ACE_Actions {
            class GVAR(holderAction) {
                condition = QUOTE(GVAR(settingHolderAction));
                displayName = DEFAULT_TEXT;
                distance = DISTANCE_INTERACTION_WEAPONHOLDER;
                modifierFunction = QUOTE(call FUNC(holderModify));
                position = QUOTE(_target worldToModel (getPosATL _target));
                statement = QUOTE(if !(_target call FUNC(canPickup) && {[ARR_2(_player,_target)] call FUNC(playerPickup)}) then {PACTION('Gear',_target)});

                class GVAR(holderOpenAction) {
                    condition = QUOTE(private _firstContainer = ((everyContainer _target) param [ARR_2(0,[ARR_2('',objNull)])]) select 1; GVAR(settingOpenAction) && {!isNull _firstContainer} && {_firstContainer call FUNC(hasInventory)} && {_target call FUNC(canPickup)});
                    displayName = CQSTRING(STR_single_open);
                    icon = ICON_INVENTORY;
                    statement = QPACTION('Gear',((everyContainer _target) param [ARR_2(0,[ARR_2('',objNull)])]) select 1);
                };
            };
        };
    };

    class Thing;
    class ThingX: Thing {
        class ACE_Actions {
            class ACE_MainActions {
                condition = "true";
                displayName = CQSTRING(STR_ACE_Interaction_MainAction);
                distance = 2;
                selection = "";

                VEHICLE_INVENTORY_ACTION;
            };
        };
    };
    class WeaponHolderSimulated: ThingX {
        class ACE_Actions: ACE_Actions {
            delete GVAR(openAction);
            class GVAR(holderAction) {
                condition = QUOTE(GVAR(settingHolderAction));
                displayName = DEFAULT_TEXT;
                distance = DISTANCE_INTERACTION_WEAPONHOLDER;
                modifierFunction = QUOTE(call FUNC(holderModify));
                position = QUOTE(_target worldToModel (getPosATL _target));
                statement = QUOTE(if !(_target call FUNC(canPickup) && {[ARR_2(_player,_target)] call FUNC(playerPickup)}) then {PACTION('Gear',_target)});
            };
        };
    };

    class LandVehicle;
    class Car: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                VEHICLE_INVENTORY_ACTION;
            };
        };
    };

    class Tank: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                VEHICLE_INVENTORY_ACTION;
            };
        };
    };

    class Air;
    class Helicopter: Air {
        class ACE_Actions {
            class ACE_MainActions {
                VEHICLE_INVENTORY_ACTION;
            };
        };
    };

    class Plane: Air {
        class ACE_Actions {
            class ACE_MainActions {
                VEHICLE_INVENTORY_ACTION;
            };
        };
    };

    class Ship;
    class Ship_F: Ship {
        class ACE_Actions {
            class ACE_MainActions {
                VEHICLE_INVENTORY_ACTION;
            };
        };
    };

    class StaticWeapon: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                class GVAR(disassembleAction) {
                    condition = QUOTE(GVAR(settingAssembleAction) && {alive _target} && {_target call FUNC(canDisassemble)});
                    displayName = CQSTRING(STR_a3_disassemble);
                    icon = ICON_REPAIR;
                    statement = QPACTION('Disassemble', _target);
                };
            };
        };
    };

    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class GVAR(backpackAction3D) {
                condition = QUOTE(GVAR(settingBackpackAction) && {GVAR(settingOpenAction)} && {isNull objectParent _target} && {alive _target} && {!isNull unitBackpack _target} && {(unitBackpack _target) call FUNC(hasInventory)});
                displayName = DEFAULT_TEXT;
                distance = DISTANCE_INTERACTION_BACKPACK_3D;
                exceptions[] = {"isNotSwimming"};
                icon = ICON_INVENTORY;
                position = QUOTE(_target call FUNC(backpackPos));
                modifierFunction = QUOTE((_this select 3) set [ARR_2(1, FORMAT_1(localize 'STR_ACTION_OPEN_BAG',localize 'STR_BACKPACK_CONTAINER_NAME'))]);
                statement = QPACTION('OpenBag',_target);
            };

            class ACE_MainActions {
                class GVAR(backpackAction) {
                    condition = QUOTE(!GVAR(settingBackpackAction) && {GVAR(settingOpenAction)} && {isNull objectParent _target} && {alive _target} && {!isNull unitBackpack _target} && {(unitBackpack _target) call FUNC(hasInventory)});
                    displayName = DEFAULT_TEXT;
                    exceptions[] = {"isNotSwimming"};
                    icon = ICON_INVENTORY;
                    modifierFunction = QUOTE((_this select 3) set [ARR_2(1, FORMAT_1(localize 'STR_ACTION_OPEN_BAG',localize 'STR_BACKPACK_CONTAINER_NAME'))]);
                    statement = QPACTION('OpenBag',_target);
                };

                class GVAR(openAction) {
                    condition = QUOTE(GVAR(settingOpenAction) && {isNull objectParent _target} && {!alive _target || {_target getVariable [ARR_2('ACE_isUnconscious',false)]}});
                    displayName = CQSTRING(STR_action_gear);
                    exceptions[] = {"isNotSwimming"};
                    icon = ICON_INVENTORY;
                    statement = QPACTION('Gear',_target);
                };
            };
        };

        class ACE_SelfActions {
            class GVAR(assembleAction) {
                condition = QUOTE(GVAR(settingAssembleAction) && {_player call FUNC(canAssemble)});
                displayName = DEFAULT_TEXT;
                icon = ICON_REPAIR;
                modifierFunction = QUOTE(call FUNC(assembleModify));
                statement = QUOTE(_player call FUNC(assemble));
            };
        };
    };
};
