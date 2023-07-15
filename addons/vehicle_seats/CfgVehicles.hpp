#define GETIN_ACTION \
class GVAR(getInAction) {\
    condition = QUOTE(GVAR(settingGetInAction) && {alive _target} && {!(_player call EFUNC(main,operatingUAV))} && {locked _target < 2} && {!([ARR_2(side _player,side _target)] call BIS_fnc_sideIsEnemy)} && {((fullCrew [ARR_3(_target,'',true)]) findIf {[ARR_3(_player,_target,_x)] call FUNC(canSwitch)}) != -1});\
    displayName = CQSTRING(STR_rscMenu.hppRscGroupRootMenu_Items_GetIn1);\
    exceptions[] = {"isNotInside", "isNotSwimming"};\
    icon = ICON_GET_IN;\
    insertChildren = QUOTE([ARR_2(_target,_player)] call FUNC(changeMenus));\
    statement = QUOTE([ARR_2(_target,_player)] call FUNC(getInRun));\
}

class CfgVehicles {
    class LandVehicle;
    class Car: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                GETIN_ACTION;
            };
        };
    };

    class Motorcycle: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                GETIN_ACTION;
            };
        };
    };

    class StaticWeapon: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                GETIN_ACTION;
            };
        };
    };

    class Tank: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                GETIN_ACTION;
            };
        };
    };

    class Air;
    class Helicopter: Air {
        class ACE_Actions {
            class ACE_MainActions {
                GETIN_ACTION;
            };
        };
    };

    class Plane: Air {
        class ACE_Actions {
            class ACE_MainActions {
                GETIN_ACTION;
            };
        };
    };

    class Ship;
    class Ship_F: Ship {
        class ACE_Actions {
            class ACE_MainActions {
                GETIN_ACTION;
            };
        };
    };

    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class GVAR(changeAction) {
                condition = QUOTE(private _vehicle = objectParent _player; GVAR(settingChangeAction) && {!isNull _vehicle} && {!(_player call EFUNC(main,operatingUAV))} && {locked _vehicle < 2} && {isMultiplayer || {(effectiveCommander _vehicle) == _player}} && {!([ARR_3(_player,_vehicle,'turnIn')] call FUNC(canTurnInOrOut))});
                displayName = CQSTRING(STR_3den_display3den_entitymenu_changeseat_text);
                exceptions[] = {"isNotInside"};
                icon = ICON_CHANGE_SEAT;
                insertChildren = QUOTE([ARR_2(_target,_player)] call FUNC(changeMenus));
            };

            class GVAR(turnOutAction) {
                condition = QUOTE(private _vehicle = objectParent _player; GVAR(settingTurnOutAction) && {!isNull _vehicle} && {!(_player call EFUNC(main,operatingUAV))} && {'TurnOut' call EFUNC(main,ignoreKeybind)} && {[ARR_3(_player,_vehicle,'turnOut')] call FUNC(canTurnInOrOut)});
                displayName = CQSTRING(STR_action_turnout);
                exceptions[] = {"isNotInside"};
                icon = ICON_ARROW_UP;
                statement = QPACTION('TurnOut',objectParent _player);
            };

            class GVAR(turnInAction) {
                condition = QUOTE(private _vehicle = objectParent _player; GVAR(settingTurnOutAction) && {!isNull _vehicle} && {!(_player call EFUNC(main,operatingUAV))} && {'TurnIn' call EFUNC(main,ignoreKeybind)} && {[ARR_3(_player,_vehicle,'turnIn')] call FUNC(canTurnInOrOut)});
                displayName = CQSTRING(STR_action_turnin);
                exceptions[] = {"isNotInside"};
                icon = ICON_ARROW_DOWN;
                statement = QPACTION('TurnIn',objectParent _player);
            };

            class GVAR(ejectActionMoving) {
                condition = QUOTE(private _vehicle = objectParent _player; GVAR(settingGetOutAction) && {!isNull _vehicle} && {!(_player call EFUNC(main,operatingUAV))} && {'Eject' call EFUNC(main,ignoreKeybind)} && {!(abs speed _vehicle < 2 && {(getPos _vehicle) select 2 < 2})} && {[ARR_2(_player,_vehicle)] call FUNC(canEject) != EJECT_TYPE_NONE});
                displayName = CQSTRING(STR_action_eject);
                exceptions[] = {"isNotInside"};
                icon = ICON_EJECT;

                class GVAR(ejectConfirmAction) {
                    condition = QUOTE(true);
                    displayName = CSTRING(ConfirmEject);
                    exceptions[] = {"isNotInside"};
                    icon = ICON_CONFIRM;
                    statement = QUOTE([ARR_2(_player,objectParent _player)] call FUNC(eject));
                };
            };

            class GVAR(getOutAction) {
                condition = QUOTE(private _vehicle = objectParent _player; GVAR(settingGetOutAction) && {!isNull _vehicle} && {!(_player call EFUNC(main,operatingUAV))} && {'GetOut' call EFUNC(main,ignoreKeybind)} && {abs speed _vehicle < 2} && {(getPos _vehicle) select 2 < 2});
                displayName = CQSTRING(STR_action_getout);
                exceptions[] = {"isNotInside"};
                icon = ICON_GET_OUT;
                statement = QPACTION('GetOut',objectParent _player);

                class GVAR(ejectAction) {
                    condition = QUOTE('Eject' call EFUNC(main,ignoreKeybind) && {[ARR_2(_player,objectParent _player)] call FUNC(canEject) >= 0});
                    displayName = CQSTRING(STR_action_eject);
                    exceptions[] = {"isNotInside"};
                    icon = ICON_EJECT;
                    statement = QUOTE([ARR_2(_player,objectParent _player)] call FUNC(eject));
                };
            };

            class GVAR(parachuteAction) {
                condition = QUOTE((getUnitFreefallInfo _player) select 1 && {getText (configOf backpackContainer _player >> 'parachuteClass') != ''});
                displayName = CQSTRING(STR_A3_action_deploy_parachute);
                icon = ICON_PARACHUTE;
                statement = QPACTION('OpenParachute',_player);
            };
        };
    };
};
