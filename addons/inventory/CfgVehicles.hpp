#define VEHICLE_INVENTORY_ACTION \
    class GVAR(openAction) {\
        condition = QUOTE(GVAR(settingOpenAction) && {alive _target} && {_target call FUNC(hasInventory)});\
        displayName = CQSTRING(STR_action_gear);\
        exceptions[] = {"isNotSwimming"};\
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
                    condition = QUOTE(GVAR(settingOpenAction) && {!isNull firstBackpack _target} && {(firstBackpack _target) call FUNC(hasInventory)} && {_target call FUNC(canPickup)});
                    displayName = CQSTRING(STR_single_open);
                    icon = ICON_INVENTORY;
                    statement = QPACTION('Gear',firstBackpack _target);
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
                    displayName = CSTRING(disassemble);
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
                condition = QUOTE(GVAR(settingBackpackAction) && {GVAR(settingOpenAction)} && {isNull objectParent _target} && {!isNull unitBackpack _target} && {alive _target} && {(unitBackpack _target) call FUNC(hasInventory)});
                displayName = CSTRING(openBackpack);
                distance = DISTANCE_INTERACTION_BACKPACK_3D;
                exceptions[] = {"isNotSwimming"};
                icon = ICON_INVENTORY;
                position = QUOTE(_target call FUNC(backpackPos));
                statement = QPACTION('OpenBag',_target);
            };

            class ACE_MainActions {
                class GVAR(backpackAction) {
                    condition = QUOTE(!GVAR(settingBackpackAction) && {GVAR(settingOpenAction)} && {isNull objectParent _target} && {!isNull unitBackpack _target} && {alive _target} && {(unitBackpack _target) call FUNC(hasInventory)});
                    displayName = CSTRING(openBackpack);
                    exceptions[] = {"isNotSwimming"};
                    icon = ICON_INVENTORY;
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
                statement = QUOTE([ARR_2(_player,backpackContainer _player)] call FUNC(assemble));
            };
        };
    };
};
